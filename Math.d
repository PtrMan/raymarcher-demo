module Math;

public void sinCos(float angle, out float sin, out float cos)
{
	float sin2;
	float cos2;

	asm
	{
		fld float ptr [angle];
		fsincos;
		fstp float ptr [cos2];
		fstp float ptr [sin2];
	}

	cos = cos2;
	sin = sin2;
}

// doesn't check for overflow/underflow/unnormalized values etc.
public float exp2(float value)
{
	const float ONE = 1.0f;

	float result;

	// from
	// http://t-a-w.blogspot.de/2006/06/docking-assembly.html
	// (modified)
	asm
	{

		fld     float ptr [value];
		//fadd    float ptr [ONE];   // fixup
		fld     ST(0);             // Duplicate
		frndint;                   // Round
		fsubr   ST, ST(1);         // Subtract
		//fxch    ST(1);             // Exchange top two values on the stack
		f2xm1;                     // 2^(fractional part) - 1
		fadd    float ptr [ONE];   // add one
		fscale;                    // Multiply by 2(integer part)
		fstp    float ptr [result];
		fstp    ST(1);             // Clean-up
		
	}

	return result;
}

public float exp(float value)
{
	// taken from https://github.com/D-Programming-Language/phobos/blob/master/std/math.d
	enum float LOG2E = 1.442695f;

	//  e^^x = 2^^(LOG2E*x)
	// see https://github.com/D-Programming-Language/phobos/blob/master/std/math.d
	return exp2(value*LOG2E);
}