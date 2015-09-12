module Sll;

// taken from my project "myos" and modified so it uses a chosable allocator

/* this implements a "single linked list"
 *
 */

template Sll(Type, AllocatorType)
{
	struct StructElement
	{
		Type *content;
		
		StructElement *next;
	}
	
	struct StructRoot {
		StructElement *firstElement;
		StructElement *lastElement;
	}

	// returns null if it fails
	StructElement* appendTo(ref StructRoot thisPtr)
	{
		StructElement *newElement;

		newElement = cast(StructElement*)AllocatorType.malloc(StructElement.sizeof);
		if( newElement is null )
		{
			return null;
		}

		newElement.next = null;
		newElement.content = null;

		if( thisPtr.lastElement is null )
		{
			//assert(thisPtr.firstElement is null);

			thisPtr.firstElement = thisPtr.lastElement = newElement;
		}
		else
		{
			thisPtr.lastElement.next = newElement;
			thisPtr.lastElement = newElement;
		}

		return newElement;
	}

	// returns null if it fails
	StructElement* insertAfter(ref StructRoot thisPtr, StructElement *afterThis)
	{
		StructElement *oldNext;
		StructElement *newElement;

		// assert afterThis !is null

		// assert thisPtr.firstElement !is null
		// assert thisPtr.lastElement !is null

		if( afterThis is afterThis.lastElement )
		{
			return appendTo(thisPtr);
		}

		newElement = cast(StructElement*)AllocatorType.malloc(StructElement.sizeof);
		if( newElement is null )
		{
			return null;
		}

		newElement.next = afterThis.next;
		newElement.content = null;

		afterThis.next = newElement;

		return newElement;
	}

	void free(ref StructRoot thisPtr, StructElement *elementToDelete)
	{
		StructElement *lastElement;
		StructElement *currentElement;

		if( thisPtr.firstElement is null || thisPtr.lastElement is null )
		{
			// assert(false);

			return;
		}

		lastElement = null;
		currentElement = thisPtr.firstElement;

		for(;;)
		{
			if( currentElement is null )
			{
				// assert(false);

				return;
			}

			if( currentElement is elementToDelete )
			{
				if( previousElement !is null )
				{
					previousElement.next = currentElement.next;
				}
				
				if( currentElement is thisPtr.firstElement )
				{
					thisPtr.firstElement = currentElement.next;
				}

				if( currentElement is thisPtr.lastElement )
				{
					thisPtr.lastElement = previousElement;
				}

				AllocatorType.free(currentElement, StructElement.sizeof);

				return;
			}

			previousElement = currentElement;
			currentElement = currentElement.next;
		}
		
	}

	public void freeList(ref StructRoot thisPtr)
	{
		StructElement *nextElement;
		StructElement *currentElement;

		currentElement = thisPtr.firstElement;

		for(;;)
		{
			if( currentElement is null )
			{
				break;
			}

			nextElement = currentElement.next;
			AllocatorType.free(currentElement);

			currentElement = nextElement;
		}

		thisPtr.firstElement = null;
		thisPtr.lastElement = null;
	}
	
	void initRoot(ref StructRoot thisPtr)
	{
		thisPtr.firstElement = null;
		thisPtr.lastElement = null;
	}
}
