module SimpleArray;

/** \brief a typesafe simple resizable array
 * 
 * is used to not rely on the GC but keep the interfaces simple
 * and the footprint is also low
 *
 * the memory can be handled from outside with a reference counting cheme, static scope (exit) deallocation, any other principle or simply GC
 *
 * the receiver doesn't own it!!!
 */
template SimpleArray(Type)
{
	struct SimpleArray
	{
		uint length;
		Type *ptr; // for [] array compatiblity

		// TODO< drop it because it doesn't work, or just rewrite it, so it returns reference or pointer >
		// needed for GC'ed array compatibility :<
		public Type opIndex(size_t index)
		{
			return ptr[index];
		}
	}
}
