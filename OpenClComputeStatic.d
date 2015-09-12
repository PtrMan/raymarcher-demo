module OpenClComputeStatic;

//import core.memory;
import MemoryC;

import opencl.c.opencl;

import ComputeImplementation;
import ComputeImplementationErrorDescriptor : ComputeImplementationErrorDescriptor;

struct OpenClComputeStatic
{
	/**
	 * \param platformIds in this are the platforms returned, array itself must be allocated and is owned by caller
	 *
	 */
	static public void getPlatforms(ref SimpleArray!platformId platformIds, ref ComputeImplementationErrorDescriptor errorDescriptor)
	{
		cl_uint countOfPlatforms;
		cl_errcode openClResult;

		ComputeImplementationErrorDescriptor.setToUnknownErrorState(errorDescriptor);
		errorDescriptor.computeEndpoint = "OpenCL";

		// get number of platforms
		openClResult = clGetPlatformIDs(0, null, &countOfPlatforms);
		openCLHandleResult(openClResult, errorDescriptor.errorHappend, errorDescriptor.errorMessage);
		if( errorDescriptor.errorHappend )
		{
			errorDescriptor.errorousFunctionName = "clGetPlatformIDs";

			return;
		}

		if( countOfPlatforms == 0 )
		{
			errorDescriptor.errorousFunctionName = "NONE";
			errorDescriptor.errorMessage = "No platforms available";
			errorDescriptor.errorHappend = true;

			return;
		}

		platformIds.ptr = cast(platformId*)malloc(cl_platform_id.sizeof * countOfPlatforms);
		if( !platformIds.ptr )
		{
			errorDescriptor.errorousFunctionName = "malloc";

			return;
		}


		

		openClResult = clGetPlatformIDs(cast(cl_uint)countOfPlatforms, cast(cl_platform_id*)platformIds.ptr, null);
		openCLHandleResult(openClResult, errorDescriptor.errorHappend, errorDescriptor.errorMessage);
		if( errorDescriptor.errorHappend )
		{
			free(cast(void*)platformIds.ptr);

			errorDescriptor.errorousFunctionName = "clGetPlatformIDs";

			return;
		}

		platformIds.length = cast(uint)countOfPlatforms;
	}

	/**
	 * tries to enumerate the devices of the chosen platform
	 *
	 * \param computeDeviceIds struct itself is owned by caller, on success the memory contains all device-id's, memory must be freed by caller
	 * \param chosenPlatform is the chosen platform
	 * \param errorDescriptor ...
	 */
	static public void enumerateDevices(ref SimpleArray!deviceId computeDeviceIds, platformId chosenPlatform, ref ComputeImplementationErrorDescriptor errorDescriptor)
	{
		cl_uint countOfDevices;
		cl_errcode openClResult;

		ComputeImplementationErrorDescriptor.setToUnknownErrorState(errorDescriptor);
		errorDescriptor.computeEndpoint = "OpenCL";

	    // get number of devices
	    openClResult = clGetDeviceIDs(cast(cl_platform_id)chosenPlatform, CL_DEVICE_TYPE_ALL, 0, null, &countOfDevices);
	    openCLHandleResult(openClResult, errorDescriptor.errorHappend, errorDescriptor.errorMessage);
		if( errorDescriptor.errorHappend )
		{
			errorDescriptor.errorousFunctionName = "clGetDeviceIDs";

			return;
		}

		computeDeviceIds.length = 0;
	    computeDeviceIds.ptr = cast(deviceId*)malloc(deviceId.sizeof * countOfDevices);
	    
	    if( !computeDeviceIds.ptr )
		{
			errorDescriptor.errorHappend = true;
			errorDescriptor.errorousFunctionName = "malloc";

			return;
		}

		computeDeviceIds.length = countOfDevices;

	    openClResult = clGetDeviceIDs(cast(cl_platform_id)chosenPlatform, CL_DEVICE_TYPE_ALL, cast(cl_uint)computeDeviceIds.length, cast(cl_device_id*)computeDeviceIds.ptr, null);
	    openCLHandleResult(openClResult, errorDescriptor.errorHappend, errorDescriptor.errorMessage);
		if( errorDescriptor.errorHappend )
		{
			errorDescriptor.errorousFunctionName = "clGetDeviceIDs";

			return;
		}
	}

	static public contextId createContext(ref SimpleArray!deviceId computeDeviceIds, platformId chosenPlatform, ref ComputeImplementationErrorDescriptor errorDescriptor)
	{
		cl_errcode openClResult;
		contextId resultContextId;

		resultContextId = 0;

		
		//alias int contextPropertiesType;
		// outcommented because it requires exception handling code
		alias cl_context_properties contextPropertiesType;

		ComputeImplementationErrorDescriptor.setToUnknownErrorState(errorDescriptor);
		errorDescriptor.computeEndpoint = "OpenCL";
		
		contextPropertiesType* cps = cast(contextPropertiesType*)malloc(contextPropertiesType.sizeof * 3);
		if( !cps )
		{
			errorDescriptor.errorHappend = true;
			errorDescriptor.errorousFunctionName = "malloc";
			return cast(contextId)0;
		}

		cps[0] = cast(contextPropertiesType)CL_CONTEXT_PLATFORM;
		cps[1] = cast(contextPropertiesType)(chosenPlatform);
		cps[2] = 0;

		resultContextId = cast(contextId)clCreateContext(cps, cast(cl_uint)computeDeviceIds.length, cast(cl_device_id*)computeDeviceIds.ptr, null, null, &openClResult);
		openCLHandleResult(openClResult, errorDescriptor.errorHappend, errorDescriptor.errorMessage);
		if( errorDescriptor.errorHappend )
		{
			errorDescriptor.errorousFunctionName = "clCreateContext";

			goto unwind_free;
		}

		// fall through
		
		// error handling
		unwind_free:
		free(cps);

		return resultContextId;
	}

	static public void releaseContext(contextId context)
	{
		// TODO
	}

	static public programId buildAndLinkWithSources(contextId context, SimpleArray!deviceId deviceIds, SimpleArray!(SimpleArray!char) sources, ref ComputeImplementationErrorDescriptor errorDescriptor)
	{
		cl_errcode openClResult;
		programId resultProgramId;

		resultProgramId = 0;

		ComputeImplementationErrorDescriptor.setToUnknownErrorState(errorDescriptor);
		errorDescriptor.computeEndpoint = "OpenCL";

		char** arrayForStringPointers = cast(char**)malloc((char*).sizeof * sources.length);
		if( !arrayForStringPointers )
		{
			errorDescriptor.errorHappend = true;
			errorDescriptor.errorousFunctionName = "malloc";
			return cast(programId)0;
		}

		size_t* arrayForStringLengths = cast(size_t*)malloc(size_t.sizeof * sources.length);
		if( !arrayForStringLengths )
		{
			errorDescriptor.errorHappend = true;
			errorDescriptor.errorousFunctionName = "malloc";
			
			goto unwind_arrayForStringPointers;
		}

		{
		import StdioC;
		puts("DEBUG here 7");
		}

		foreach(arrayI; 0..sources.length)
		{
			arrayForStringPointers[arrayI] = cast(char*)sources[arrayI].ptr;
			arrayForStringLengths[arrayI] = sources[arrayI].length;
		}

		foreach(aa;0..sources.length)
		{
			import StdioC;
			printf("-%d", sources[0].ptr);
		}
		
		resultProgramId = cast(int)clCreateProgramWithSource(cast(cl_context)context, sources.length, arrayForStringPointers, arrayForStringLengths, &openClResult);
		openCLHandleResult(openClResult, errorDescriptor.errorHappend, errorDescriptor.errorMessage);
		if( errorDescriptor.errorHappend )
		{
			errorDescriptor.errorousFunctionName = "clCreateProgramWithSource";

			goto unwind_arrayForStringLengths;
		}

		/* uncommented because in the demoscene demo we can't relay on exception handling because we don't initialize the exception handling stuff
		scope(exit)
		{
			if( errorDescriptor.errorHappend )
			{
				releaseProgram(cast(int)resultProgramId);
			}
		}
		*/


		openClResult = clBuildProgram(cast(cl_program)resultProgramId, cast(cl_uint)deviceIds.length, cast(cl_device_id*)deviceIds.ptr, null, null, null);
		openCLHandleResult(openClResult, errorDescriptor.errorHappend, errorDescriptor.errorMessage);
		if( errorDescriptor.errorHappend )
		{
			if( openClResult == CL_BUILD_PROGRAM_FAILURE )
			{
				uint logSize;
				void *rawString;
				string logString;

				openClResult = clGetProgramBuildInfo(cast(cl_program)resultProgramId, cast(cl_device_id)deviceIds[0], CL_PROGRAM_BUILD_LOG, cast(uint)0, null, &logSize);
				openCLHandleResult(openClResult, errorDescriptor.errorHappend, errorDescriptor.errorMessage);
				if( errorDescriptor.errorHappend )
				{
					errorDescriptor.errorousFunctionName = "clGetProgramBuildInfo";

					goto unwind_releaseProgram;
				}

				rawString = malloc(logSize);
				if( !rawString )
				{
					errorDescriptor.errorHappend = true;
					errorDescriptor.errorousFunctionName = "malloc";

					goto unwind_releaseProgram;
				}
				// old GC version
				//rawString = GC.malloc(logSize, GC.BlkAttr.NO_MOVE | GC.BlkAttr.NO_SCAN);

				// old GC version
				//scope(exit) GC.free(rawString);

				// TODO< choose device >
				openClResult = clGetProgramBuildInfo(cast(cl_program)resultProgramId, cast(cl_device_id)deviceIds[0], CL_PROGRAM_BUILD_LOG, logSize, rawString, null);
				openCLHandleResult(openClResult, errorDescriptor.errorHappend, errorDescriptor.errorMessage);
				if( errorDescriptor.errorHappend )
				{
					errorDescriptor.errorousFunctionName = "clGetProgramBuildInfo";

					free(rawString);
					goto unwind_releaseProgram;
				}

				/*
				is outcommented because _aDupT is as notrow not accepted (compiler bug?)

				logString = (cast(char*)rawString)[0..logSize].dup;
				*/

				errorDescriptor.errorHappend = true;
				errorDescriptor.errorousFunctionName = "clBuildProgram";
				errorDescriptor.errorMessage = "TODO"; // logString;


				free(rawString);
				goto unwind_releaseProgram;
			}
			else
			{
				errorDescriptor.errorousFunctionName = "clBuildProgram";

				goto unwind_releaseProgram;
			}
		}

		{
		import StdioC;
		puts("DEBUG here 3");
		}

		assert(!errorDescriptor.errorHappend);
		// fall through

		// error handling

		unwind_releaseProgram:
		{
			if( errorDescriptor.errorHappend )
			{
				releaseProgram(cast(int)resultProgramId);
			}
		}

		unwind_arrayForStringLengths:
		free(arrayForStringLengths);

		unwind_arrayForStringPointers:
		free(arrayForStringPointers);

		return resultProgramId;
	}

	
	static public void releaseProgram(programId program) nothrow
	{
		clReleaseProgram(cast(cl_program)program);
	}

	static public bufferId allocateBufferUninitialized(contextId context, uint size, ref ComputeImplementationErrorDescriptor errorDescriptor)
	{
		return allocateBufferInternal(context, size, null, cast(cl_mem_flags)0, errorDescriptor);
	}

	static public bufferId allocateBufferInitialized(contextId context, uint size, void* ptr, ref ComputeImplementationErrorDescriptor errorDescriptor)
	{
		return allocateBufferInternal(context, size, ptr, CL_MEM_ALLOC_HOST_PTR, errorDescriptor);
	}

	static public void releaseBuffer(bufferId buffer)
	{
		clReleaseMemObject(cast(cl_mem)buffer);
	}

	static public void enqueueBufferHostAction(bufferId buffer, commandQueueId commandQueue, EnumBufferActionType actionType, EnumBlocking blocking, void* ptr, uint size, SimpleArray!eventId waitlist, bool useCompletionEvent, eventId event, ref ComputeImplementationErrorDescriptor errorDescriptor)
	{
		cl_errcode openClResult;
		string errorousFunctionName;
		cl_bool clBlocking;
		void* ptrToWaitlist;
		cl_event* completionEventPtr;

		ComputeImplementationErrorDescriptor.setToUnknownErrorState(errorDescriptor);
		errorDescriptor.computeEndpoint = "OpenCL";

		// this must be because the OpenCL specificiation is a bit convoluted
		if( waitlist.length == 0 )
		{
			ptrToWaitlist = null;
		}
		else
		{
			ptrToWaitlist = waitlist.ptr;
		}

		if( useCompletionEvent )
		{
			completionEventPtr = cast(cl_event*)&event;
		}
		else
		{
			completionEventPtr = null;
		}

		if( blocking == EnumBlocking.YES )
		{
			clBlocking = CL_TRUE;
		}
		else
		{
			clBlocking = CL_FALSE;
		}

		if( actionType == EnumBufferActionType.READ )
		{
			errorousFunctionName = "clEnqueueReadBuffer";

			openClResult = clEnqueueReadBuffer(
				cast(cl_command_queue)commandQueue,
				cast(cl_mem)buffer,
				clBlocking,
				0, // offset
				size,
				ptr,
 				waitlist.length,
 				cast(cl_event*)ptrToWaitlist,
 				completionEventPtr
 			);
		}
		else // actionType == EnumBufferActionType.WRITE
		{
			errorousFunctionName = "clEnqueueWriteBuffer";

			openClResult = clEnqueueWriteBuffer(
				cast(cl_command_queue)commandQueue,
				cast(cl_mem)buffer,
				clBlocking,
				0, // offset
				size,
				ptr,
 				waitlist.length,
 				cast(cl_event*)ptrToWaitlist,
 				completionEventPtr
 			);
		}

		openCLHandleResult(openClResult, errorDescriptor.errorHappend, errorDescriptor.errorMessage);
		if( errorDescriptor.errorHappend )
		{
			errorDescriptor.errorousFunctionName = errorousFunctionName;
			return;
		}
	}

	
	static public kernelId createKernelAndBindArguments(programId program, string kernelName,SimpleArray!KernelParameter parameters, ref ComputeImplementationErrorDescriptor errorDescriptor)
	{
		cl_errcode openClResult;
		kernelId resultKernelId;

		
		ComputeImplementationErrorDescriptor.setToUnknownErrorState(errorDescriptor);
		errorDescriptor.computeEndpoint = "OpenCL";


		resultKernelId = cast(kernelId)clCreateKernel(cast(cl_program)program, kernelName.ptr, &openClResult);
		openCLHandleResult(openClResult, errorDescriptor.errorHappend, errorDescriptor.errorMessage);
		if( errorDescriptor.errorHappend )
		{
			errorDescriptor.errorousFunctionName = "clCreateKernel";
			return cast(kernelId)0;
		}


		foreach( parameterI; 0..parameters.length )
		{
			clSetKernelArg(cast(cl_kernel)resultKernelId, parameterI, parameters.ptr[parameterI].size, parameters.ptr[parameterI].value.ptr);
		}

		
		return resultKernelId;
	}

	static public void releaseKernel(kernelId kernel)
	{
		clReleaseKernel(cast(cl_kernel)kernel);
	}

	static public void executeKernel(kernelId kernel, commandQueueId commandQueue, SimpleArray!uint globalWorkSize, SimpleArray!uint localWorkSize, SimpleArray!eventId waitlist, bool useCompletionEvent, eventId event, ref ComputeImplementationErrorDescriptor errorDescriptor)
	in
	{
		assert(globalWorkSize.length > 0);
		assert(localWorkSize.length > 0);
		assert(globalWorkSize.length == localWorkSize.length);
	}
	body
	{
		
		cl_errcode openClResult;
		void* ptrToWaitlist;
		cl_event* completionEventPtr;

		ComputeImplementationErrorDescriptor.setToUnknownErrorState(errorDescriptor);
		errorDescriptor.computeEndpoint = "OpenCL";

		// this must be because the OpenCL specificiation is a bit convoluted
		if( waitlist.length == 0 )
		{
			ptrToWaitlist = null;
		}
		else
		{
			ptrToWaitlist = waitlist.ptr;
		}

		if( useCompletionEvent )
		{
			completionEventPtr = cast(cl_event*)&event;
		}
		else
		{
			completionEventPtr = null;
		}

		openClResult = clEnqueueNDRangeKernel(
			cast(cl_command_queue)commandQueue,
 			cast(cl_kernel)kernel,
 			cast(cl_uint)localWorkSize.length,
 			null, // global work offset
 			globalWorkSize.ptr,
 			localWorkSize.ptr,
 			waitlist.length,
 			cast(cl_event*)ptrToWaitlist,
 			completionEventPtr
 		);
 		openCLHandleResult(openClResult, errorDescriptor.errorHappend, errorDescriptor.errorMessage);
		if( errorDescriptor.errorHappend )
		{
			{
				import StdioC;
				printf("%d", openClResult);
			}

			errorDescriptor.errorousFunctionName = "clEnqueueNDRangeKernel";
			return;
		}
		
	}

	static public commandQueueId createCommandQueue(contextId context, deviceId device, ref ComputeImplementationErrorDescriptor errorDescriptor)
	{
		
		commandQueueId resultCommandQueueId;
		cl_errcode openClResult;
		

		ComputeImplementationErrorDescriptor.setToUnknownErrorState(errorDescriptor);
		errorDescriptor.computeEndpoint = "OpenCL";

		resultCommandQueueId = cast(commandQueueId)clCreateCommandQueue(
			cast(cl_context)context,
 			cast(cl_device_id)device,
			cast(cl_command_queue_properties)0,
 			&openClResult
 		);
 		openCLHandleResult(openClResult, errorDescriptor.errorHappend, errorDescriptor.errorMessage);
		if( errorDescriptor.errorHappend )
		{
			errorDescriptor.errorousFunctionName = "clCreateCommandQueue";
			return cast(commandQueueId)0;
		}
		
		return resultCommandQueueId;
	}
	
	static public void releaseCommandQueue(commandQueueId commandQueue)
	{
		clReleaseCommandQueue(cast(cl_command_queue)commandQueue);
	}

	static public void flushCommandQueue(commandQueueId commandQueueId)
	{
		clFlush(cast(cl_command_queue)commandQueueId);
	}
	
	private static void openCLHandleResult(cl_errcode result, out bool isError, out string errorDescription)
	{
		isError = true;
		errorDescription = "UNSET";

		if( result == CL_SUCCESS )
		{
			isError = false;
			return;
		}

		// TODO
	}

	private static bufferId allocateBufferInternal(contextId context, uint size, void *ptr, cl_mem_flags flags, ref ComputeImplementationErrorDescriptor errorDescriptor)
	{
		cl_errcode openClResult;
		bufferId resultBufferId;

		ComputeImplementationErrorDescriptor.setToUnknownErrorState(errorDescriptor);
		errorDescriptor.computeEndpoint = "OpenCL";

		resultBufferId = cast(bufferId)clCreateBuffer(cast(cl_context)context, flags, size, ptr, &openClResult);
		openCLHandleResult(openClResult, errorDescriptor.errorHappend, errorDescriptor.errorMessage);
		if( errorDescriptor.errorHappend )
		{
			errorDescriptor.errorousFunctionName = "clCreateBuffer";
			return cast(bufferId)0;
		}

		return resultBufferId;
	}
}
