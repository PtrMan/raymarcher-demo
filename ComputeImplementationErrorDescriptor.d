module ComputeImplementationErrorDescriptor;

struct ComputeImplementationErrorDescriptor
{
	public bool errorHappend;
	public string errorMessage;
	public string computeEndpoint;
	public string errorousFunctionName;


/*

	string buildErrorMessage(ref ComputeImplementationErrorDescriptor thisRef)
	{
		string result;

		result ~= "Compute " ~ thisRef.computeEndpoint ~ " call:" ~ thisRef.errorousFunctionName ~ "\n";
		result ~= "Error Message:\n";
		result ~= thisRef.errorMessage;

		return result;
	}

*/


	static public void setToUnknownErrorState(ref ComputeImplementationErrorDescriptor thisRef)
	{
		thisRef.errorMessage = "NOTSET";
		thisRef.errorHappend = true;
	}
}
