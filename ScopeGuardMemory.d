module ScopeGuardMemory;

import MemoryC;

struct ScopeGuardMemory
{
	public this(void* ptr) nothrow
	{
		this.ptr = ptr;
	}

	public ~this() nothrow
	{
		free(ptr);
	}

	private void* ptr;
}
