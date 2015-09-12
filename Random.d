module Random;

// http://www.codeproject.com/Articles/25172/Simple-Random-Number-Generation

public struct StructRandom
{
	uint z;
	uint w;
}

public void init(ref StructRandom thisPtr)
{
	// NOTE< just random numbers >
	thisPtr.z = 83289;
	thisPtr.w = 5;
}

public uint generateUint(ref StructRandom thisPtr)
{
	thisPtr.z = 36969 * (thisPtr.z & 65535) + (thisPtr.z >> 16);
	thisPtr.w = 18000 * (thisPtr.w & 65535) + (thisPtr.w >> 16);
    return (thisPtr.z << 16) + thisPtr.w;
}

template generateFloating(Type)
{
	public Type generateFloating(ref StructRandom thisPtr)
	{
		return (cast(Type)thisPtr.generateUint() + 1.0) * 2.328306435454494e-10;
	}
}
