module misc;

import dummyRuntime;

void* memcpy(void* destination, const void* source, size_t num) nothrow
{
	//return dummyRuntime.memcpy(destination, cast(void*)source, num);


	// own
	foreach(index; 0..num)
	{
		(cast(byte*)destination)[index] = (cast(byte*)source)[index];
	}

	return destination;

    //(cast(ubyte*)destination)[0 .. num][]=(cast(const(ubyte)*)source)[0 .. num];
    //return destination;
}

void memset(void* ptr, byte value, uint length)
{
	foreach(index; 0..length)
	{
		(cast(byte*)ptr)[index] = value;
	}
}
