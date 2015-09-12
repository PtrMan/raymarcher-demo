module MemoryC;

extern (C)
{
	void*   malloc(size_t size) nothrow;
	void*   realloc(void* ptr, size_t size) nothrow;
	void    free(void* ptr) nothrow;

	void *memcpy(void *, void *, size_t) nothrow;
}
