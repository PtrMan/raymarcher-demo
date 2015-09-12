module ExceptionHandlingStub;

// from druntime/src/rt/deh_win32.d
extern(C)
{
	extern __gshared int _except_list; // This is just FS:[0]
}

// is needed because the exception handling stuff is called/used when

public void setupExceptionHandling()
{
	//maybe right, maybe wrong...
	_except_list = cast(int)&lastExceptionHandler;
}

// gets called when no other exception handler handles the exception
// is this needed, the druntime says its not but it might be called
private void lastExceptionHandler()
{
	// TODO< call exit >
}
