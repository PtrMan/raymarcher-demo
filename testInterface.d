
import SimpleArray : SimpleArray;

import ComputeImplementationErrorDescriptor : ComputeImplementationErrorDescriptor;
import KernelParameter;

alias int programId;
alias int contextId;
alias int deviceId;
alias int bufferId;
alias int kernelId;
alias int commandQueueId;
alias int eventId;

enum EnumBlocking
{
	YES,
	NO
}

enum EnumBufferActionType
{
	READ,
	WRITE
}

interface ComputeImplementation
{
	/** \brief 
	 *
	 * \result program id
	 */
	public programId buildAndLinkWithSources(contextId context, SimpleArray!deviceId deviceIds, SimpleArray!string sources, ref ComputeImplementationErrorDescriptor errorDescriptor);

	public void releaseProgram(programId program);

	public bufferId allocateBufferInitialized(contextId context, uint size, void* ptr, ref ComputeImplementationErrorDescriptor errorDescriptor);

	public bufferId allocateBufferUninitialized(contextId context, uint size, ref ComputeImplementationErrorDescriptor errorDescriptor);

	public void releaseBuffer(bufferId buffer);

	public void enqueueBufferHostAction(bufferId buffer, commandQueueId commandQueue, EnumBufferActionType actionType, EnumBlocking blocking, void* ptr, uint size, eventId[] waitlist, bool useCompletionEvent, eventId event, ref ComputeImplementationErrorDescriptor errorDescriptor);

	public kernelId createKernelAndBindArguments(programId program, string kernelName, KernelParameter[] parameters, ref ComputeImplementationErrorDescriptor errorDescriptor);

	public void releaseKernel(kernelId kernel);

	public void executeKernel(kernelId kernel, commandQueueId commandQueue, uint[] globalWorkSize, uint[] localWorkSize, eventId[] waitlist, bool useCompletionEvent, eventId event, ref ComputeImplementationErrorDescriptor errorDescriptor);

	public commandQueueId createCommandQueue(contextId context, deviceId device, ref ComputeImplementationErrorDescriptor errorDescriptor);

	public void releaseCommandQueue(commandQueueId commandQueue);

	public void flushCommandQueue(commandQueueId commandQueueId);
}

class Zx : ComputeImplementation
{
	public programId buildAndLinkWithSources(contextId context, SimpleArray!deviceId deviceIds, SimpleArray!string sources, ref ComputeImplementationErrorDescriptor errorDescriptor)
	{
		return cast(programId)0;
	}

	public void releaseProgram(programId program)
	{

	}

	public bufferId allocateBufferInitialized(contextId context, uint size, void* ptr, ref ComputeImplementationErrorDescriptor errorDescriptor)
	{
		return cast(bufferId)0;
	}

	public bufferId allocateBufferUninitialized(contextId context, uint size, ref ComputeImplementationErrorDescriptor errorDescriptor)
	{
		return cast(bufferId)0;
	}

	public void releaseBuffer(bufferId buffer)
	{

	}

	public void enqueueBufferHostAction(bufferId buffer, commandQueueId commandQueue, EnumBufferActionType actionType, EnumBlocking blocking, void* ptr, uint size, eventId[] waitlist, bool useCompletionEvent, eventId event, ref ComputeImplementationErrorDescriptor errorDescriptor)
	{

	}

	public kernelId createKernelAndBindArguments(programId program, string kernelName, KernelParameter[] parameters, ref ComputeImplementationErrorDescriptor errorDescriptor)
	{
		return cast(kernelId)0;
	}

	public void releaseKernel(kernelId kernel)
	{

	}

	public void executeKernel(kernelId kernel, commandQueueId commandQueue, uint[] globalWorkSize, uint[] localWorkSize, eventId[] waitlist, bool useCompletionEvent, eventId event, ref ComputeImplementationErrorDescriptor errorDescriptor)
	{

	}

	public commandQueueId createCommandQueue(contextId context, deviceId device, ref ComputeImplementationErrorDescriptor errorDescriptor)
	{
		return cast(commandQueueId)0;
	}

	public void releaseCommandQueue(commandQueueId commandQueue)
	{

	}

	public void flushCommandQueue(commandQueueId commandQueueId)
	{

	}
}

import core.stdc.stdio;

void main(string[] ayy)
{
	Zx aaa= new Zx();

	aaa.releaseKernel(cast(kernelId)0);

	printf("init[0] = %x\n", (cast(uint*)aaa)[0]);
	printf("init[1] = %x\n", (cast(uint*)aaa)[1]);
	printf("init[2] = %x\n", (cast(uint*)aaa)[2]);
	printf("init[3] = %x\n", (cast(uint*)aaa)[3]);
	printf("init[4] = %x\n", (cast(uint*)aaa)[4]);
}

