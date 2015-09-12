module dummyRuntime;

// for an example of a minimal library see http://arsdnet.net/dcode/minimal.d

// for all documented hooks see http://wiki.dlang.org/Runtime_Hooks

// for other runtime stuff
// (object crap, etc)
// https://github.com/D-Programming-Language/druntime/blob/e47a00bff935c3f079bb567a6ec97663ba384487/src/object_.d#L2629

import StdioC;


private
{
	enum
    {
        PAGESIZE = 4096
    }

	enum : size_t
    {
        BIGLENGTHMASK = ~(cast(size_t)PAGESIZE - 1),
        SMALLPAD = 1,
        MEDPAD = ushort.sizeof,
        LARGEPREFIX = 16, // 16 bytes padding at the front of the array
        LARGEPAD = LARGEPREFIX + 1,
        MAXSMALLSIZE = 256-SMALLPAD,
        MAXMEDSIZE = (PAGESIZE / 2) - MEDPAD
    }
}

/**
 * Support for array.dup property.
 */
struct Array2
{
    size_t length;
    void*  ptr;
}

extern(C)
{
	__gshared void* _Dmodule_ref;

	void _d_array_bounds(void* m, uint line) {
		//write("_d_array_bounds");
	}
	void _d_assertm(void* m, uint line) {
		//write("_d_assertm");
	}

	// dunno exactly what it does
	void _d_framehandler(void* arg0)
	{
		fatalExit();
	}

	void _d_assert_msg(string msg, string file, uint line)
	{
		fatalExit();
	}

	/*
	 * Throw a D object.
	 */
	void _d_throwc(Object *h)
	{
		// print???
		fatalExit();
	}

	
	Object _d_newclass(const ClassInfo ci)
	{
		void* p;

		puts("DEBUG _d_newclass() called");

		//debug(PRINTF) printf("_d_newclass(ci = %p, %s)\n", ci, cast(char *)ci.name);
		
		// NOTE< we don't have any COM objects >
		if( false ) // if COM object
		{
		}
		else
		{
			// because we don't use any GC we just do a malloc
			p = malloc(ci.init.length);
    		if( !p )
    		{
        		onOutOfMemoryError();
    		}
		}
    	
    	
	    //debug(PRINTF)
	    {
	        printf("p = %p\n", p);
	        printf("ci = %p, ci.init = %p, len = %d\n", ci, ci.init.ptr, ci.init.length);
	        printf("vptr = %p\n", *cast(void**) ci.init);
	        printf("vtbl[0] = %p\n", (*cast(void***) ci.init)[0]);
	        printf("vtbl[1] = %p\n", (*cast(void***) ci.init)[1]);
	        printf("init[0] = %x\n", (cast(uint*) ci.init)[0]);
	        printf("init[1] = %x\n", (cast(uint*) ci.init)[1]);
	        printf("init[2] = %x\n", (cast(uint*) ci.init)[2]);
	        printf("init[3] = %x\n", (cast(uint*) ci.init)[3]);
	        printf("init[4] = %x\n", (cast(uint*) ci.init)[4]);
	    }
	    

	    
	    puts("DEBUG initialize");

	    foreach(a;0..ci.init.length)
	    {
	    	puts(".");
	    }

	    // initialize it
	    (cast(byte*) p)[0 .. ci.init.length] = ci.init[];

	    puts("DEBUG return");

	    // debug(PRINTF) printf("initialization done\n");
	    return cast(Object) p;
	}

	/**
	 * Allocate a new array of length elements.
	 * ti is the type of the resulting array, or pointer to element.
	 * (For when the array is initialized to 0)
	 */
	void[] _d_newarrayT(const TypeInfo ti, size_t length)
	{
		puts("DEBUG _d_newarrayT() called");

	    void[] result;
	    auto size = ti.next.tsize;                  // array element size

	    puts("...here0");

	    //debug(PRINTF) printf("_d_newarrayT(length = x%x, size = %d)\n", length, size);
	    if (length == 0 || size == 0)
	        result = null;
	    else
	    {
	        auto newsize = size * length;

	        size = newsize;
	        
	        // NOTE< we don't use any array padding because it makes appending much much more easy >
	        void* base = malloc(size);
	        auto arrstart = base;
	        result = arrstart[0..length];
	    }
	    return result;

	Loverflow:
	    onOutOfMemoryError();
	    assert(false);
	}

	void* _d_arrayliteralTX(const TypeInfo ti, size_t length)
	{
		// HACK< to shorten the crap down >
		return _d_newarrayT(ti, length).ptr;
	}

	/**
     * Extend an array by n elements.
	 * Caller must initialize those elements.
	 */
	byte[] _d_arrayappendcTX(const TypeInfo ti, ref byte[] px, size_t n)
	{
	    // only optimize array append where ti is not a shared type
	    auto sizeelem = ti.next.tsize;              // array element size
	    auto length = px.length;
	    auto newlength = length + n;
	    auto newsize = newlength * sizeelem;

	    void* newPtr = realloc(px.ptr, newsize);
	    if( !newPtr )
	    {
	    	onOutOfMemoryError();
	    	assert(false);
	    }

	    auto arrstart = newPtr;
	    return cast(byte[])arrstart[0..newlength];
	}

	/**
	 * Append y[] to array x[]
	 */
	void[] _d_arrayappendT(const TypeInfo ti, ref byte[] x, byte[] y)
	{
	    auto length = x.length;
	    auto sizeelem = ti.next.tsize;              // array element size
	    _d_arrayappendcTX(ti, x, y.length);
	    memcpy(x.ptr + length * sizeelem, y.ptr, y.length * sizeelem);
		
		return x;
	}


	void onOutOfMemoryError()
	{
		// TODO< print out of error >
		fatalExit();
	}


	byte[] _d_arraycopy(size_t size, byte[] from, byte[] to)
	{
		puts("DEBUG _d_arraycopy() called");
	    printf("f = %p,%d, t = %p,%d, size = %d\n",            from.ptr, from.length, to.ptr, to.length, size);

	    if( to.length != from.length )
	    {
	    	// TODO< print error >
	    	fatalExit();
	    }
	    else if (to.ptr + to.length * size <= from.ptr ||
	             from.ptr + from.length * size <= to.ptr)
	    {
	    	puts("DEBUG ...copy");
	        memcpy(to.ptr, from.ptr, to.length * size);
	    }
	    else
	    {
	        //throw new Error("overlapping array copy");
	        fatalExit();
	    }
	    return to;
	}

	/**
	 * Resize dynamic arrays with 0 initializers.
	 */
	void[] _d_arraysetlengthT(const TypeInfo ti, size_t newlength, void[]* p)
	in
	{
    	assert(ti);
    	assert(!(*p).length || (*p).ptr);
	}
	body
	{
		puts("DEBUG  _d_arraysetlengthT() called");

		void* ptr = realloc(p.ptr, newlength*ti.next.tsize);

		return ptr[0..newlength];
	}

	void[] _d_arraycatnT(const TypeInfo ti, uint n, ...)
	{
		size_t length;
		auto size = ti.next.tsize;   // array element size

		puts("DEBUG  _d_arraycatnT() called");

		// TODO< debug concatination >


		// count allocation size
		// only for x86
		byte[]* p = cast(byte[]*)(&n + 1);

        for (auto i = 0; i < n; i++)
        {
            byte[] b = *p++;
            length += b.length;
        }

	    if (!length)
	        return null;

	    auto allocsize = length * size;
	    void *a = malloc(allocsize);

	    // copy new content in

	    p = cast(byte[]*)(&n + 1);

        size_t j = 0;
        for (auto i = 0; i < n; i++)
        {
            byte[] b = *p++;
            if (b.length)
            {
                memcpy(a + j, b.ptr, b.length * size);
                j += b.length * size;
            }
        }

	    return a[0..length];
	}

	/*
	void[] _adDupT(const TypeInfo ti, void[] a) nothrow
	out (result)
	{
	    auto sizeelem = ti.next.tsize;              // array element size
	    assert(memcmp((*cast(Array2*)&result).ptr, a.ptr, a.length * sizeelem) == 0);
	}
	body
	{
	    Array2 r;

	    puts("DEBUG _adDupT() called");

	    if (a.length)
	    {
	        auto sizeelem = ti.next.tsize;                  // array element size
	        auto size = a.length * sizeelem;
	        void* ptr = malloc(size);
	        r.ptr = ptr;
	        r.length = a.length;
	        memcpy(r.ptr, a.ptr, size);
	    }
	    return *cast(void[]*)(&r);
	}
	*/
	
	// very hacky, i hope it doesn't get called
	// im also not sure about the function signature
	void _d_local_unwind2()
	{
		// DEBUG
		puts("_d_local_unwind2() called");

		assert(0);
	}



	/**
	 * get the start of the array for the given block
	 */
	/*
	void *__arrayStart(BlkInfo info)
	{
	    return info.base + ((info.size & BIGLENGTHMASK) ? LARGEPREFIX : 0);
	}
	*/

	/**
	 * get the padding required to allocate size bytes.  Note that the padding is
  	 * NOT included in the passed in size.  Therefore, do NOT call this function
  	 * with the size of an allocated block.
  	*/
  	/*
	size_t __arrayPad(size_t size)
	{
	    return size > MAXMEDSIZE ? LARGEPAD : (size > MAXSMALLSIZE ? MEDPAD : SMALLPAD);
	}
	*/

	void fatalExit()
	{
		// TODO< exit >

		assert(false);
	}
}

extern (C)
{
	void*   malloc(size_t size) nothrow;
	void*   realloc(void* ptr, size_t size) nothrow;
	void    free(void* ptr) nothrow;

	void *memcpy(void *, void *, size_t) nothrow;
	pure int   memcmp(in void* s1, in void* s2, size_t n) nothrow;
}

// some "funny" stubs
extern (C)
{
	void *D15TypeInfo_Struct6__vtblZ;
	void *D12TypeInfo_Aya6__initZ;
	void *D16TypeInfo_Typedef6__vtblZ;
	void *D14TypeInfo_Const6__vtblZ;
	void *D10TypeInfo_v6__initZ;
	void *D11TypeInfo_Ai6__initZ;
	//void *D14TypeInfo_Class6__vtblZ;
	void *D11TypeInfo_Aa6__initZ;

	// hack because the bullshit is too big
	void *D14TypeInfo_Array6__vtblZ;
	void *D10TypeInfo_a6__initZ;
	void *D16TypeInfo_Pointer6__vtblZ;
	void *D11TypeInfo_Ak6__initZ;
	void *D9invariant12_d_invariantFC6ObjectZv;

	void *D6Object7__ClassZ;
}

extern (C)
{
	// absolute hack
	string D6object6Object8toStringMFZAya(void*)
	{
		return "";
	}

	int D6object6Object6toHashMFNbNeZk(void* ptr)
	{
		return cast(int)ptr;
	}

	bool D6object6Object8opEqualsMFC6ObjectZb(void* this_,void* other)
    {
    	return this_ is other;
    }


    bool D6object6Object5opCmpMFC6ObjectZi(void*, void* lhs, void* rhs)
    {
        if (lhs is rhs)
            return true;
        if (lhs is null || rhs is null)
            return false;
        return lhs is rhs;
    }
}



