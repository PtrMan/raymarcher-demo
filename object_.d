// see https://github.com/D-Programming-Language/druntime/blob/e47a00bff935c3f079bb567a6ec97663ba384487/src/object_.d#L2629

module object;

// just as allways for x64
alias int   ptrdiff_t;
alias uint  size_t;
alias immutable(char)[]  string;

// hack
alias string wstring;
alias string dstring;

class Object
{
    /**
     * Convert Object to a human readable string.
     */
    string toString()
    {
        return this.classinfo.name;
    }

    /**
     * Compute hash function for Object.
     */
    size_t toHash() @trusted nothrow
    {
        return cast(size_t)cast(void*)this;
    }

    /**
     * Compare with another Object obj.
     * Returns:
     *  $(TABLE
     *  $(TR $(TD this &lt; obj) $(TD &lt; 0))
     *  $(TR $(TD this == obj) $(TD 0))
     *  $(TR $(TD this &gt; obj) $(TD &gt; 0))
     *  )
     */
     /*
    int opCmp(Object o)
    {
        // BUG: this prevents a compacting GC from working, needs to be fixed
        //return cast(int)cast(void*)this - cast(int)cast(void*)o;

        throw new Exception("need opCmp for class " ~ this.classinfo.name);
        //return this !is o;
    }
    */

    /**
     * Returns !=0 if this object does have the same contents as obj.
     */
    bool opEquals(Object o)
    {
        return this is o;
    }

    bool opEquals(Object lhs, Object rhs)
    {
        if (lhs is rhs)
            return true;
        if (lhs is null || rhs is null)
            return false;
        if (typeid(lhs) == typeid(rhs))
            return lhs.opEquals(rhs);
        return lhs.opEquals(rhs) &&
               rhs.opEquals(lhs);
    }
}


bool _xopEquals(in void*, in void*)
{
    // TODO< exit >

    assert(false);
}

bool _xopCmp(in void*, in void*)
{
    // right?

    // TODO< exit >

    assert(false);
}


// stub stub stub
class Throwable : Object
{
}

class Exception : Throwable
{
}

struct ModuleInfo
{
}



class Error
{
}



/**
 * Information about an interface.
 * When an object is accessed via an interface, an Interface* appears as the
 * first entry in its vtbl.
 */
struct Interface
{
    TypeInfo_Class   classinfo;  /// .classinfo for this interface (not for containing class)
    void*[]     vtbl;
    ptrdiff_t   offset;     /// offset to Interface 'this' from Object 'this'
}


/**
 * Array of pairs giving the offset and type information for each
 * member in an aggregate.
 */
struct OffsetTypeInfo
{
    size_t   offset;    /// Offset of member from start of object
    TypeInfo ti;        /// TypeInfo for this member
}

/**
 * Runtime type information about a type.
 * Can be retrieved for any type using a
 * <a href="../expression.html#typeidexpression">TypeidExpression</a>.
 */
class TypeInfo
{
    override string toString() const
    {
        // hack to keep const qualifiers for TypeInfo member functions
        return (cast()super).toString();
    }

    override size_t toHash() @trusted const
    {
        try
        {
            auto data = this.toString();
            return hashOf(data.ptr, data.length);
        }
        catch (Throwable)
        {
            // This should never happen; remove when toString() is made nothrow

            // BUG: this prevents a compacting GC from working, needs to be fixed
            return cast(size_t)cast(void*)this;
        }
    }

    int opCmp(Object o)
    {
        if (this is o)
            return 0;
        TypeInfo ti = cast(TypeInfo)o;
        if (ti is null)
            return 1;
        return dstrcmp(this.toString(), ti.toString());
    }

    bool opEquals(Object o)
    {
        /* TypeInfo instances are singletons, but duplicates can exist
         * across DLL's. Therefore, comparing for a name match is
         * sufficient.
         */
        if (this is o)
            return true;
        auto ti = cast(const TypeInfo)o;
        return ti && this.toString() == ti.toString();
    }

    /// Returns a hash of the instance of a type.
    size_t getHash(in void* p) @trusted nothrow const { return cast(size_t)p; }

    /// Compares two instances for equality.
    bool equals(in void* p1, in void* p2) const { return p1 == p2; }

    /// Compares two instances for &lt;, ==, or &gt;.
    int compare(in void* p1, in void* p2) const { return 0; }

    /// Returns size of the type.
    @property size_t tsize() nothrow pure const @safe { return 0; }

    /// Swaps two instances of the type.
    void swap(void* p1, void* p2) const
    {
        size_t n = tsize;
        for (size_t i = 0; i < n; i++)
        {
            byte t = (cast(byte *)p1)[i];
            (cast(byte*)p1)[i] = (cast(byte*)p2)[i];
            (cast(byte*)p2)[i] = t;
        }
    }

    /// Get TypeInfo for 'next' type, as defined by what kind of type this is,
    /// null if none.
    @property const(TypeInfo) next() nothrow pure const { return null; }

    /// Return default initializer.  If the type should be initialized to all zeros,
    /// an array with a null ptr and a length equal to the type size will be returned.
    // TODO: make this a property, but may need to be renamed to diambiguate with T.init...
    const(void)[] init() nothrow pure const @safe { return null; }

    /// Get flags for type: 1 means GC should scan for pointers
    @property uint flags() nothrow pure const @safe { return 0; }

    /// Get type information on the contents of the type; null if not available
    const(OffsetTypeInfo)[] offTi() const { return null; }
    /// Run the destructor on the object and all its sub-objects
    void destroy(void* p) const {}
    /// Run the postblit on the object and all its sub-objects
    void postblit(void* p) const {}


    /// Return alignment of type
    @property size_t talign() nothrow pure const @safe { return tsize; }

    /** Return internal info on arguments fitting into 8byte.
     * See X86-64 ABI 3.2.3
     */
    version (X86_64) int argTypes(out TypeInfo arg1, out TypeInfo arg2) @safe nothrow
    {
        arg1 = this;
        return 0;
    }

    /** Return info used by the garbage collector to do precise collection.
     */
    @property immutable(void)* rtInfo() nothrow pure const @safe { return null; }
}


/**
 * Runtime type information about a class.
 * Can be retrieved from an object instance by using the
 * $(LINK2 ../property.html#classinfo, .classinfo) property.
 */
class TypeInfo_Class : TypeInfo
{
    override string toString() const { return info.name; }

    override bool opEquals(Object o)
    {
        if (this is o)
            return true;
        auto c = cast(const TypeInfo_Class)o;
        return c && this.info.name == c.info.name;
    }

    override size_t getHash(in void* p) @trusted const
    {
        auto o = *cast(Object*)p;
        return o ? o.toHash() : 0;
    }

    override bool equals(in void* p1, in void* p2) const
    {
        Object o1 = *cast(Object*)p1;
        Object o2 = *cast(Object*)p2;

        return (o1 is o2) || (o1 && o1.opEquals(o2));
    }

    override int compare(in void* p1, in void* p2) const
    {
        Object o1 = *cast(Object*)p1;
        Object o2 = *cast(Object*)p2;
        int c = 0;

        // Regard null references as always being "less than"
        if (o1 !is o2)
        {
            if (o1)
            {
                if (!o2)
                    c = 1;
                else
                    c = o1.opCmp(o2);
            }
            else
                c = -1;
        }
        return c;
    }

    override @property size_t tsize() nothrow pure const
    {
        return Object.sizeof;
    }

    override @property uint flags() nothrow pure const { return 1; }

    override @property const(OffsetTypeInfo)[] offTi() nothrow pure const
    {
        return m_offTi;
    }

    @property auto info() @safe nothrow pure const { return this; }
    @property auto typeinfo() @safe nothrow pure const { return this; }

    byte[]      init;           /** class static initializer
                                 * (init.length gives size in bytes of class)
                                 */
    string      name;           /// class name
    void*[]     vtbl;           /// virtual function pointer table
    Interface[] interfaces;     /// interfaces this class implements
    TypeInfo_Class   base;           /// base class
    void*       destructor;
    void function(Object) classInvariant;
    uint        m_flags;
    //  1:                      // is IUnknown or is derived from IUnknown
    //  2:                      // has no possible pointers into GC memory
    //  4:                      // has offTi[] member
    //  8:                      // has constructors
    // 16:                      // has xgetMembers member
    // 32:                      // has typeinfo member
    // 64:                      // is not constructable
    void*       deallocator;
    OffsetTypeInfo[] m_offTi;
    void function(Object) defaultConstructor;   // default Constructor

    immutable(void)* m_RTInfo;        // data for precise GC
    override @property immutable(void)* rtInfo() const { return m_RTInfo; }

    /**
     * Search all modules for TypeInfo_Class corresponding to classname.
     * Returns: null if not found
     */
    static const(TypeInfo_Class) find(in char[] classname)
    {
        foreach (m; ModuleInfo)
        {
          if (m)
            //writefln("module %s, %d", m.name, m.localClasses.length);
            foreach (c; m.localClasses)
            {
                //writefln("\tclass %s", c.name);
                if (c.name == classname)
                    return c;
            }
        }
        return null;
    }

    /**
     * Create instance of Object represented by 'this'.
     */
    Object create() const
    {
        if (m_flags & 8 && !defaultConstructor)
            return null;
        if (m_flags & 64) // abstract
            return null;
        Object o = _d_newclass(this);
        if (m_flags & 8 && defaultConstructor)
        {
            defaultConstructor(o);
        }
        return o;
    }
}
