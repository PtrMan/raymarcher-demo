module Synth.NotesGenerator;

static import MemoryC;
import Random;

import Sll;

/+
 +
 + aBcb -> aBcb.aBcb   duplicate with break
 + aBcb -> aBcbaBcb    duplicate without break
 + 
 + aBc -> aaCc   (double first)
 + aBc -> Bc     (remove first)
 + 
 + insert lader up
 + insert lader down
 +  
 + - linked list for replacing posibilities
 + - array for content/notes
 + 
 + * need to sync both on changes
 + 
 + TODO- write single linked list impl (typeless because of space)
 + TODO- actual system
 +
 +/

// for testing
struct NativeAllocator
{
	public static void* malloc(uint size)
	{
		return MemoryC.malloc(size);
	}

	public static void free(void* ptr, uint size)
	{
		MemoryC.free(ptr);
	}
}

alias Sll.Sll!(void, NativeAllocator) VoidSll;

struct StructProductionInfo
{
	uint index; // index to the array where the production resides
}

struct StructNotesGenerator
{
	// list with all open production points
	// are *StructProductionInfo pointers (nativly allocated)
	VoidSll.StructRoot productionSll;

	// actual notes
	DynamicArray!uint notes;

	public static void init(ref StructNotesGenerator thisPtr)
	{
		thisPtr.productionSll.initRoot();
		notes.init();
	}

	public static void doRandomProduction(ref StructNotesGenerator thisPtr, ref StructRandom random)
	{
		uint chosenProductionIndex;
		VoidSll.StructElement *iterationElement;
		uint productionIndex;

		chosenProductionIndex = random.generateUint() % thisPtr.getCountOfProductions();

		// iterate until we hit the chosen production
		productionIndex = 0;
		iterationElement = thisPtr.productionsSll.firstElement;

		for(;;)
		{
			assert(iterationElement !is null);

			if( productionIndex == chosenProductionIndex )
			{
				break;
			}

			productionIndex++;
			iterationElement = iterationElement.next;
		}

		// TODO

		// TODO< apply production and modify notes array accordingly >
	}

	// TODO< move the body into the sll and call it? >
	private static uint getCountOfProductions(ref StructNotesGenerator thisPtr)
	{
		uint count;
		VoidSll.StructElement *iterationElement;

		count = 0;

		iterationElement = thisPtr.productionsSll.firstElement;

		for(;;)
		{
			if( iterationElement is null )
			{
				break;
			}

			count++;

			iterationElement = iterationElement.next;
		}

		return count;
	}

	public static void release(ref StructNotesGenerator thisPtr)
	{
		VoidSll.StructElement *iterationElement;
		VoidSll.StructElement *nextElement;

		// free all elements of productionsSll ...
		iterationElement = thisPtr.productionsSll.firstElement;

		for(;;)
		{
			if( iterationElement is null )
			{
				break;
			}

			MemoryC.free(iterationElement.content);

			iterationElement = iterationElement.next;
		}

		// ...free the sll itself
		thisPtr.productionsSll.freeList();

		thisPtr.notes.release();
	}
}


/*
public void aa()
{
	Sll.Sll!(void, NativeAllocator).StructRoot root;

	Sll.Sll!(void, NativeAllocator).initRoot(root);
}
*/