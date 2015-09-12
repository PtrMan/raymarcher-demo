module synth.Core;

/**
 * The Synthesizer is a Granular/Puslar Synthesizer
 *
 * The currently played granular samples are stored in a (fixed size) array
 * This means that the number of played samples is limited
 *
 * All other samples are waiting in a single linked queue, sorted by absolute samples to play (because supersampling can be used)
 * The memory of everything execept the static array is allocated/freed with the Dart allocator because it is fast
 *
 * If a particle is queued to be played it is removed from the particle queue
 * this is the case because we
 * * need to scan for new to play particles only in the queue
 * * can immediately delete particles which are finished playing without worying about memory leaks/double free etc.
 *
 * In a more generic implementation any allocator might be used
 */

import allocators.DartAllocator;
static import Math;

public enum EnumEnvelopeType
{
	BOX,
	GAUSSIAN,
	SINC1CYCLE,

	EXPOTENTIALBEGIN,
	EXPOTENTIALEND
}

private enum PLAYARRAYSIZE = 100;

public struct StructSynthCore
{
	StructDart* allocator;

	// fixed size array which stores all played particles (of one channel)
	// there can't be any gaps of inactive particles
	StructPlayedParticle* playedParticlesArrayChannel0;

	StructParticleInformation* lastParticleForChannel0;
	StructParticleInformation* firstParticleForChannel0;

}

private struct StructPlayedParticle
{
	bool active;
	StructParticleInformation* particle; // pointer at the particle, can only be null if not active
	uint subsamplesPlaying; // number of subsamples this sound is allready playing
}

// contains data about a particle which is played or is queued to be played
private struct StructParticleInformation
{
	StructParticleInformation* next; // pointer to the next particle, can be null
	uint samplesTillBegin; // can't be null
	uint particleLength; // particle length in samples
	float cycles;
	float amplitude;

	EnumEnvelopeType envelopeType;
}

public StructSynthCore* newSynthCore()
{
	StructSynthCore* resultStruct;

	resultStruct = cast(StructSynthCore*)MemoryC.malloc(StructSynthCore.sizeof);
	if( resultStruct is null )
	{
		return resultStruct; // compresses better than "null"
	}

	resultStruct.firstParticleForChannel0 = null;
	resultStruct.lastParticleForChannel0 = null;


	// allocate array
	resultStruct.playedParticlesArrayChannel0 = cast(StructPlayedParticle*)MemoryC.malloc(StructPlayedParticle.sizeof * PLAYARRAYSIZE);
	if( resultStruct.playedParticlesArrayChannel0 is null )
	{
		MemoryC.free(resultStruct);

		resultStruct = cast(StructSynthCore*)null;
		return resultStruct; // compresses better than "null"
	}

	// initialize array
	foreach( i; 0..PLAYARRAYSIZE )
	{
		resultStruct.playedParticlesArrayChannel0[i].active = false;
	}

	resultStruct.allocator = newDartAllocator();
	if( resultStruct.allocator is null )
	{
		MemoryC.free(resultStruct.playedParticlesArrayChannel0);
		MemoryC.free(resultStruct);

		resultStruct = cast(StructSynthCore*)null;
		return resultStruct; // compresses better than "null"
	}

	return resultStruct;
}

public void freeSynthCore(StructSynthCore* synthCore)
{
	assert(synthCore !is null);

	freeDartAllocator(synthCore.allocator);
	MemoryC.free(synthCore.playedParticlesArrayChannel0);
	MemoryC.free(synthCore);
}

// TODO< maybe we search for a matching place, requires some time but the samples don't need to be ordered
/**
 *
 * important is that the particles can only queued up with increasing "samplesTillBegin"
 *
 * eats silently all allocation failures
 * TODO< because its not so important for the demo because of size, for another application this must be improved >
 */
public void queueParticle(StructSynthCore* thisPtr, uint samplesTillBegin, uint particleLength, float particleCycles, float amplitude, EnumEnvelopeType envelopeType)
{
	StructParticleInformation* newParticle;
	bool calleeSuccess;

	assert(thisPtr !is null);

	newParticle = cast(StructParticleInformation*)thisPtr.allocator.allocate(StructParticleInformation.sizeof, calleeSuccess);
	newParticle.next = null;
	newParticle.samplesTillBegin = samplesTillBegin;
	newParticle.particleLength = particleLength;
	newParticle.cycles = particleCycles;
	newParticle.amplitude = amplitude;
	newParticle.envelopeType = envelopeType;
	// TODO< set status of particle >

	// if it is the first particle we need to allocate it
	// and set it as the last and first particle
	//
	// else we relink everything
	if( thisPtr.firstParticleForChannel0 is null )
	{
		thisPtr.firstParticleForChannel0 = thisPtr.lastParticleForChannel0 = newParticle;
	}
	else
	{
		thisPtr.lastParticleForChannel0.next = newParticle;
		thisPtr.lastParticleForChannel0 = newParticle;
	}
}

// NOTE< until now we don't use any supersampling >
public void samplesIntoBuffer(StructSynthCore* thisPtr, float* buffer, uint numberOfSamples)
{
	float sampleValue;
	uint numberOfPlayedParticles;

	foreach( bufferIndex; 0..numberOfSamples )
	{

		// this method/function does much stuff at once, because we don't want to pay for the bytes for the overhead of managing structs/calling functions etc.

		// scan number of played particles
		// we do this because it speeds up the inner loops of the synth a bit
		// firther it simplifies the code

		numberOfPlayedParticles = 0;

		foreach( particleIndex; 0..PLAYARRAYSIZE )
		{
			if( !thisPtr.playedParticlesArrayChannel0[particleIndex].active )
			{
				break;
			}

			numberOfPlayedParticles++;
		}

		// mix all playing particles

		sampleValue = 0.0f;

		foreach( particleIndex; 0..numberOfPlayedParticles )
		{
			float sinResult;
			float cosResult;


			// calculate sample

			float relativeParticlePosition; // range [0.0, 1.0]

			float phase;
			float particleCycles;
			float particleAmplitude;
			float amplitude;

			float particleEnvelope;
			float sincPhase;
			float multipliedSincPhase;


			particleCycles = thisPtr.playedParticlesArrayChannel0[particleIndex].particle.cycles;
			particleAmplitude = thisPtr.playedParticlesArrayChannel0[particleIndex].particle.amplitude;

			// TODO< divisor can be precalculated >
			relativeParticlePosition = (cast(float)thisPtr.playedParticlesArrayChannel0[particleIndex].subsamplesPlaying * (1.0f/cast(float)1 /* subsamples */ ) ) / cast(float)thisPtr.playedParticlesArrayChannel0[particleIndex].particle.particleLength;

			sincPhase = (relativeParticlePosition - 0.5f) * 2.0f * 3.141f;

			final switch( thisPtr.playedParticlesArrayChannel0[particleIndex].particle.envelopeType )
			{
				case EnumEnvelopeType.BOX:
				particleEnvelope = 1.0f;
				break;


				case EnumEnvelopeType.GAUSSIAN:
				// i hope the two constants are not twisted
				particleEnvelope = calculateGaussianDistribution(relativeParticlePosition, 0.5f, 0.2f);
				break;


				case EnumEnvelopeType.SINC1CYCLE:
				// check if it is in the middle of the sinc
				// we have to chheck it because we would divide by zero
				if( thisPtr.playedParticlesArrayChannel0[particleIndex].subsamplesPlaying/(1 /* subsamples */)  == cast(float)thisPtr.playedParticlesArrayChannel0[particleIndex].particle.particleLength/2 )
				{
					particleEnvelope = 1.0f;
				}
				else
				{
					multipliedSincPhase = 1.0f * sincPhase;
					Math.sinCos(multipliedSincPhase, sinResult, cosResult);

					particleEnvelope = sinResult / multipliedSincPhase;
				}
				break;


				case EnumEnvelopeType.EXPOTENTIALBEGIN:
				particleEnvelope = Math.exp2(-8.0f*relativeParticlePosition);
				break;


				case EnumEnvelopeType.EXPOTENTIALEND:
				particleEnvelope = Math.exp2(-8.0f*(1.0f-relativeParticlePosition));
				break;
			}
			
			phase = relativeParticlePosition;
			phase = phase * 2.0f * 3.141f * particleCycles;

			Math.sinCos(phase, sinResult, cosResult);

			amplitude = sinResult;
			amplitude *= particleAmplitude;
			amplitude *= particleEnvelope;

			sampleValue += amplitude;
		}

		// advance subsampletime

		foreach( particleIndex; 0..numberOfPlayedParticles )
		{
			thisPtr.playedParticlesArrayChannel0[particleIndex].subsamplesPlaying++;
		}

		// write out sample value
		buffer[bufferIndex] = sampleValue;


		// check if playing of particles is finished and reorder/copy particle content
		
		for( uint particleIndex = 0; particleIndex < PLAYARRAYSIZE ; particleIndex++ )
		{
			bool particleFinishedPlaying;

			if( !thisPtr.playedParticlesArrayChannel0[particleIndex].active )
			{
				break;
			}

			particleFinishedPlaying = thisPtr.playedParticlesArrayChannel0[particleIndex].subsamplesPlaying > thisPtr.playedParticlesArrayChannel0[particleIndex].particle.particleLength * 1 /* subsamples */;

			if( particleFinishedPlaying )
			{
				thisPtr.allocator.free(thisPtr.playedParticlesArrayChannel0[particleIndex].particle, StructParticleInformation.sizeof);

				// this is needed because it could be that we don't do the next step because its the last element
				thisPtr.playedParticlesArrayChannel0[particleIndex].active = false;

				// tranfer the informations from the next playing particle to this
				if( particleIndex == PLAYARRAYSIZE-1 )
				{
					thisPtr.playedParticlesArrayChannel0[particleIndex].active = thisPtr.playedParticlesArrayChannel0[particleIndex+1].active;
					thisPtr.playedParticlesArrayChannel0[particleIndex].particle = thisPtr.playedParticlesArrayChannel0[particleIndex+1].particle;
					thisPtr.playedParticlesArrayChannel0[particleIndex].subsamplesPlaying = thisPtr.playedParticlesArrayChannel0[particleIndex+1].subsamplesPlaying;
				}
				
				// even out the index
				particleIndex--;
			}
		}
		
		// check for new particles we need to play

		StructParticleInformation* currentParticle;

		/* outcommented because i don't need debug
		{
			import std.stdio;
			writeln("check new play");
		}
		*/

		for(;;)
		{
			currentParticle = thisPtr.firstParticleForChannel0;

			if( currentParticle is null )
			{
				break;
			}

			/* outcommented because i don't need debug
			{
				import std.stdio;
				writeln("samples till begin ", currentParticle.samplesTillBegin);
			}
			*/

			if( currentParticle.samplesTillBegin == 0 )
			{
				StructParticleInformation* cachedNextParticle;

				cachedNextParticle = currentParticle.next;

				// relink linked list
				thisPtr.firstParticleForChannel0 = currentParticle.next;
				// we do this because it can be that it was the last particle,
				// in this case we have to set also the lastParticleForChannel0 to null
				if( thisPtr.firstParticleForChannel0 is null )
				{
					thisPtr.lastParticleForChannel0 = null;
				}

				// add to played particles
				// for this we need to search a free place
				// and add it
				foreach(particleIndex; 0..PLAYARRAYSIZE )
				{
					if( !thisPtr.playedParticlesArrayChannel0[particleIndex].active )
					{
						thisPtr.playedParticlesArrayChannel0[particleIndex].active = true;
						thisPtr.playedParticlesArrayChannel0[particleIndex].particle = currentParticle;
						thisPtr.playedParticlesArrayChannel0[particleIndex].subsamplesPlaying = 0;

						break;
					}
				}

				// invalidate pointer
				currentParticle.next = null;

				// move on and search for other particles
				currentParticle = currentParticle.next;
				continue;
			}
			else
			{
				break;
			}
		}

		// advance the time of the particles

		currentParticle = thisPtr.firstParticleForChannel0;

		for(;;)
		{
			if( currentParticle is null )
			{
				break;
			}

			currentParticle.samplesTillBegin--;

			currentParticle = currentParticle.next;
		}
	}
}

// belongs actually into a math library
private float calculateGaussianDistribution(float x, float mu, float delta)
{
	enum float ONEDIVSQRTTWO = 0.707107f; // 1.0 / Sqrt(2.0)

	float distToMean;

	distToMean = x - mu;

	return ONEDIVSQRTTWO*delta * Math.exp(-0.5f*((distToMean*distToMean)/(delta*delta)));
}
