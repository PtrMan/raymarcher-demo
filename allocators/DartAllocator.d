module allocators.DartAllocator;

/** \brief fast allocator for Elements which have a bound lifetime
 *
 * we allocate (huge) frames from the system
 * for each frame we store a counter with allocated elements
 * on allocation request we look if the current frame has enought space
 * * if it has space we just move the head pointer and increment the counter
 * * if it doesn't have space we allocate a new frame and link the old frame to the new (so we do have a linked list of all frames)
 *
 * on deallocation we do
 * - check if it is in the current frame
 *   * if so, decrement the element counter
 *   * if not, decrement the counter of the coresponding frame
 *   * if the frame reaches zero elements we deallocate it (link it out of the single linked list)
 *
 * is called a dart allocator because it fast moves in one direction
 */

static import MemoryC;

private enum FRAMESIZE = 524288; // 512 kb

public struct StructDart
{
	StructFrame* firstFrame; // can be null
	StructFrame* lastFrame; // can be null, if no block was allocated
}

private struct StructFrame
{
	StructFrame* next; // can be null
	uint freeSize;
	uint usedSize;

	uint occupiedElements;

	void* memory;
}

public StructDart* newDartAllocator()
{
	StructDart* resultStruct;

	resultStruct = cast(StructDart*)MemoryC.malloc(StructDart.sizeof);
	if( resultStruct is null )
	{
		return resultStruct; // compresses surely better than return 0
	}

	resultStruct.firstFrame = null;
	resultStruct.lastFrame = null;

	return resultStruct;
}

public void freeDartAllocator(StructDart* dartAllocator)
{
	StructFrame* iterationDeallocationFrame;

	// TODO< nulltest >

	iterationDeallocationFrame = dartAllocator.firstFrame;

	for(;;)
	{
		StructFrame* currentFrame;

		if( iterationDeallocationFrame is null )
		{
			break;
		}

		currentFrame = iterationDeallocationFrame;

		iterationDeallocationFrame = currentFrame.next;

		MemoryC.free(currentFrame.memory);
		MemoryC.free(currentFrame);
	}

	MemoryC.free(dartAllocator);
}

public void* allocate(StructDart* dartAllocator, uint size, out bool success)
{
	void* resultPtr;

	// TODO< nulltest >

	success = false;

	// if we don't have a frame, allocate one
	if( dartAllocator.lastFrame is null )
	{
		dartAllocator.firstFrame = dartAllocator.lastFrame = allocateFrame();
		if( dartAllocator.lastFrame is null )
		{
			return null;
		}
	}

	// if the remaining size is not enougth, allocate a new frame and set it as the last frame
	if( dartAllocator.lastFrame.freeSize < size )
	{
		StructFrame* newAllocatedFrame;

		newAllocatedFrame = allocateFrame();
		if( dartAllocator.lastFrame is null )
		{
			return null;
		}

		// link it
		dartAllocator.lastFrame.next = newAllocatedFrame;

		dartAllocator.lastFrame = newAllocatedFrame;
	}

	// calculate pointer, do size calculations
	resultPtr = cast(void*)(cast(uint)dartAllocator.lastFrame.memory + dartAllocator.lastFrame.usedSize);
	dartAllocator.lastFrame.usedSize += size;
	dartAllocator.lastFrame.freeSize -= size;
	dartAllocator.lastFrame.occupiedElements++;

	success = true;
	return resultPtr;
}

// length is passed to be compatible with Andrei Alexandrescu allocator scheme
public void free(StructDart* dartAllocator, void* ptr, uint length)
{
	StructFrame* previousFrame;
	StructFrame* currentFrame;

	// TODO< null tests >

	// try to find the coresponding block, if not found, assert

	currentFrame = dartAllocator.firstFrame;

	for(;;)
	{
		bool pointerInRangeOfFrame;

		if( currentFrame is null )
		{
			break;
		}

		pointerInRangeOfFrame = (cast(uint)ptr >= cast(uint)currentFrame.memory) && (cast(uint)ptr < cast(uint)currentFrame.memory + FRAMESIZE);

		if( !pointerInRangeOfFrame )
		{
			previousFrame = currentFrame;
			currentFrame = currentFrame.next;

			continue;
		} 

		// we are here if it is in the range

		assert(currentFrame.occupiedElements > 0);

		currentFrame.occupiedElements--;

		// we do only if it is not the frame we currently populate
		// * check if it does have zero elements
		//  * if so, we can free it, to do it we have to link the ll first
		if( currentFrame !is dartAllocator.lastFrame && currentFrame.occupiedElements == 0 )
		{
			// we can't relink a frame before it which doesn't exist
			if( previousFrame !is null )
			{
				previousFrame.next = currentFrame.next;
			}

			MemoryC.free(currentFrame.memory);
			MemoryC.free(currentFrame);
		}

		return;

		assert(false, "Should be unreachable!");
	}

	assert(false, "Found no block, memory wasn't allocated or allready freed!");
}


private StructFrame* allocateFrame()
{
	StructFrame* result;

	result = cast(StructFrame*)MemoryC.malloc(StructFrame.sizeof);
	if( result is null )
	{
		return result; // compress better?
	}

	result.memory = MemoryC.malloc(FRAMESIZE);
	if( result.memory is null)
	{
		MemoryC.free(result);

		return cast(StructFrame*)0;
	}

	result.next = null;
	result.freeSize = FRAMESIZE;
	result.usedSize = 0;

	return result;
}