module StdioC;

alias void FILE;
alias uint c_long; // 32bit

enum
{
    SEEK_SET,
    SEEK_CUR,
    SEEK_END
}

extern (C)
{
	int   puts(in char* s) nothrow;

	// actualy for debugging
	int printf(in char* format, ...);


	int   fclose(FILE* stream);
	FILE* fopen(in char* filename, in char* mode);

	size_t fread(void* ptr, size_t size, size_t nmemb, FILE* stream);
	size_t fwrite(in void* ptr, size_t size, size_t nmemb, FILE* stream);

	int    fseek(FILE* stream, c_long offset, int whence);
    /*c_long*/size_t ftell(FILE* stream);
}
