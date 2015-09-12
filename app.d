import opencl.c.opencl;

import core.sys.windows.windows;

import ComputeImplementation;
import OpenClComputeStatic : OpenClComputeStatic;
import ComputeImplementationErrorDescriptor : ComputeImplementationErrorDescriptor;
import KernelParameter : KernelParameter;

import MemoryC;
import misc : memcpy;
import StdioC;
import SimpleArray : SimpleArray;

import Window : myWinMain;

static import DirectSoundDir.DirectSound;
import DirectSoundDir.dsound;

// testing
import allocators.DartAllocator;


/*
void openCLHandleResult(cl_errcode Result, out bool IsError, out string ErrorDescription)
{
	IsError = true;
	ErrorDescription = "UNSET";

	if( Result == CL_SUCCESS )
	{
		IsError = false;
		return;
	}

	// TODO
}
*/

// if it is not without standard library
/*
static if(false)
{
	void main(string[] args)
	{
		entry();
	}
}
else
{
	import dummyRuntime;

	extern(C) int main()
	{
		entry();
		return 0;
	}
}
*/

string escapeSlashes(string input)
{
	string replacedContent = "";

	foreach(iterationChar; input)
	{
		if(iterationChar == '\\')
		{
			replacedContent ~= "\\\\";
		}
		else
		{
			replacedContent ~= iterationChar;
		}
	}

	return replacedContent;
}

string readSource()
{
	string content = import("raymarcher6.opencl");

	content = escapeSlashes(content);

	return "string " ~ "kernelRaymarcher" ~ " = \"\"\"" ~ content ~ "\"\"\";";
}

struct StructHandles
{
	DirectSoundDir.DirectSound.DirectSoundStruct directSoundStruct;

	IDirectSoundBuffer directSoundSecondaryBuffer;
}

// this function gets called from Window.d when the window got opened
// it is used to initialize direct Sound
void windowInitCallback(void* innerFunctionArgument, HWND hwnd)
{
	StructHandles* ptrToStructHandles;
	bool calleeSuccess;

	ptrToStructHandles = cast(StructHandles*)innerFunctionArgument;

	DirectSoundDir.DirectSound.setup(hwnd, ptrToStructHandles.directSoundStruct, calleeSuccess);
	if( !calleeSuccess )
	{
		puts("DirectSound");
		// TODO< exit application >
		for(;;)
		{}
	}

	DirectSoundDir.DirectSound.createSoundBuffer(ptrToStructHandles.directSoundStruct, &ptrToStructHandles.directSoundSecondaryBuffer, 2, 16, 44100, 1000 /*ms*/);
	if( ptrToStructHandles.directSoundSecondaryBuffer is null )
	{
		puts("DirectSound Secondary Buffer");
		// TODO< exit application >
		for(;;)
		{}
	}

	DirectSoundDir.DirectSound.generateSound(ptrToStructHandles.directSoundStruct, ptrToStructHandles.directSoundSecondaryBuffer, 0, 1000 /*ms*/, 5000 /* hz */);

	DirectSoundDir.DirectSound.setPlaybackVolume(ptrToStructHandles.directSoundSecondaryBuffer, 0 /*db*/);

	DirectSoundDir.DirectSound.play(ptrToStructHandles.directSoundSecondaryBuffer, /*looped */false);	

	for(;;)
	{

	}
}

// this function gets called from Window.d on each tick
void windowTick(void* innerFunctionArgument, HWND hwnd)
{
	for(;;)
	{

	}
}

void entry()
{
	StructHandles passedStruct; 


	ComputeImplementationErrorDescriptor computeErrorDescriptor;
	SimpleArray!platformId computePlatformIds;
	SimpleArray!deviceId computeDeviceIds;
	contextId computeContext;
	platformId chosenPlatform;
	programId computeProgram;

	bufferId computeBufferForDepth;
	kernelId kernelForDepthOfSh;
	commandQueueId mainCommandQueue;

	SimpleArray!(SimpleArray!char) openclSources;
	SimpleArray!KernelParameter kernelParameters;

	// testing
	


	puts("eof");

	return;

	

	OpenClComputeStatic.getPlatforms(computePlatformIds, computeErrorDescriptor);
	if( computeErrorDescriptor.errorHappend )
	{
		// outcommented because building the error message is not implemented jet in a demoscene friendly way
		//string errorMessage = computeErrorDescriptor.buildErrorMessage();
		//puts(errorMessage.ptr);

		puts(computeErrorDescriptor.errorousFunctionName.ptr);
		return;
	}

	// TODO< choose first platform if there are many (and choose GPU) >

	chosenPlatform = computePlatformIds[1];


	// enumerate devices
	OpenClComputeStatic.enumerateDevices(computeDeviceIds, chosenPlatform, computeErrorDescriptor);
	if( computeErrorDescriptor.errorHappend )
	{
		// outcommented because building the error message is not implemented jet in a demoscene friendly way
		//string errorMessage = computeErrorDescriptor.buildErrorMessage();
		//puts(errorMessage.ptr);

		puts(computeErrorDescriptor.errorousFunctionName.ptr);
		return;
	}


	// create the context
	computeContext = OpenClComputeStatic.createContext(computeDeviceIds, chosenPlatform, computeErrorDescriptor);
	if( computeErrorDescriptor.errorHappend )
	{
		// outcommented because building the error message is not implemented jet in a demoscene friendly way
		//string errorMessage = computeErrorDescriptor.buildErrorMessage();
		//puts(errorMessage.ptr);
		puts(computeErrorDescriptor.errorousFunctionName.ptr);
		return;
	}
	
	// TODO< release context anyhow on exit >



	// TODO< some null termination stuff >
	mixin(readSource());

	// build program
	openclSources.length = 0;
	openclSources.ptr = cast(SimpleArray!char*)malloc((SimpleArray!char).sizeof * 1);
	if( !openclSources.ptr )
	{
		puts("malloc");
		return;
	}

	openclSources.length = 1;

	openclSources.ptr[0].ptr = cast(char*)kernelRaymarcher.ptr;
	openclSources.ptr[0].length = kernelRaymarcher.length;

	puts("[] before build");

	computeProgram = OpenClComputeStatic.buildAndLinkWithSources(computeContext, computeDeviceIds, openclSources, computeErrorDescriptor);
	if( computeErrorDescriptor.errorHappend )
	{
		//string errorMessage = computeErrorDescriptor.buildErrorMessage();

		puts(computeErrorDescriptor.errorousFunctionName.ptr);
		return;
	}

	puts("[] program built successfull");

	// allocate depth buffer
	// NOTE< size is fixed @512x512, need to allocate a bigger buffer for fullscreen renderings, note also that the maximal bufffer size can be limited >
	// TODO< allocate memory on host and allocate buffer with size and pointer >
	computeBufferForDepth = OpenClComputeStatic.allocateBufferUninitialized(computeContext, 512*512*4, computeErrorDescriptor);
	if( computeErrorDescriptor.errorHappend )
	{
		//string errorMessage = computeErrorDescriptor.buildErrorMessage();

		puts(computeErrorDescriptor.errorousFunctionName.ptr);
		return;
	}


	// create kernel
	// NOTE GC< maybe problematic >
	kernelParameters.length = 0;
	kernelParameters.ptr = cast(KernelParameter*)malloc(KernelParameter.sizeof * 2);
	if( !kernelParameters.ptr )
	{
		puts("malloc");
		return;
	}

	kernelParameters.length = 2;

	kernelParameters.ptr[0].size = (void*).sizeof;
	memcpy(&(kernelParameters.ptr[0].value), &computeBufferForDepth, computeBufferForDepth.sizeof);

	kernelParameters.ptr[1].size = float.sizeof;
	// NOTE< we keep the float unset because we don't use it for now >

	kernelForDepthOfSh = OpenClComputeStatic.createKernelAndBindArguments(computeProgram, "singleSHkernel", kernelParameters, computeErrorDescriptor);
	if( computeErrorDescriptor.errorHappend )
	{
		//string errorMessage = computeErrorDescriptor.buildErrorMessage();

		puts(computeErrorDescriptor.errorousFunctionName.ptr);
		return;
	}



	// create queue
	// NOTE< choose device #0, this might be wrong on some PC's >
	mainCommandQueue = OpenClComputeStatic.createCommandQueue(computeContext, computeDeviceIds[0], computeErrorDescriptor);
	if( computeErrorDescriptor.errorHappend )
	{
		//string errorMessage = computeErrorDescriptor.buildErrorMessage();

		puts(computeErrorDescriptor.errorousFunctionName.ptr);
		return;
	}

	puts("queue created!");

	SimpleArray!uint globalWorksize;
	SimpleArray!uint localWorksize;

	SimpleArray!eventId waitlist;

	uint[2] staticGlobalWorksize;
	uint[2] staticLocalWorksize;

	globalWorksize.ptr = cast(uint*)&staticGlobalWorksize;
	globalWorksize.length = 2;

	localWorksize.ptr = cast(uint*)&staticLocalWorksize;
	localWorksize.length = 2;

	globalWorksize.ptr[0] = 512;
	globalWorksize.ptr[1] = 512;

	localWorksize.ptr[0] = 16;
	localWorksize.ptr[1] = 8;

	waitlist.length = 0;

	// execute kernel
	// TODO TODO TODO
	OpenClComputeStatic.executeKernel(
		kernelForDepthOfSh,
		mainCommandQueue,
		globalWorksize,
		localWorksize, 
		waitlist,
		false,
		0,
		computeErrorDescriptor
	);
	if( computeErrorDescriptor.errorHappend )
	{
		//string errorMessage = computeErrorDescriptor.buildErrorMessage();

		puts(computeErrorDescriptor.errorousFunctionName.ptr);
		return;
	}

	puts("here");

	HINSTANCE hInstance = GetModuleHandleA(null);

	myWinMain(hInstance, null, null, 1, &windowInitCallback, &windowTick, &passedStruct);

	// here all destruction would take place

	return;





	/+

	// -----


	// ------
	
	openclSources.length = 0;


	KernelParameter[] kernelParameters;
	

	// HACK
	computeContext = cast(contextId)context;

	puts("here 0003 call");

	// build program
	//TODO TODO TOOD TODO
	//openclSources ~= readText("raymarcher6.opencl");

	computeProgram = OpenClComputeStatic.buildAndLinkWithSources(computeContext, computeDeviceIds, openclSources, computeErrorDescriptor);

	puts("here 0005");

	if( computeErrorDescriptor.errorHappend )
	{
		string errorMessage = computeErrorDescriptor.buildErrorMessage();

		puts(errorMessage.ptr);
		return;
	}

	scope(exit) OpenClComputeStatic.releaseProgram(computeProgram);

	puts("here 0004");

	// allocate depth buffer
	// NOTE< size is fixed @512x512, need to allocate a bigger buffer for fullscreen renderings, note also that the maximal bufffer size can be limited >
	// TODO< allocate memory on host and allocate buffer with size and pointer >
	computeBufferForDepth = OpenClComputeStatic.allocateBufferUninitialized(computeContext, 512*512*4, computeErrorDescriptor);
	if( computeErrorDescriptor.errorHappend )
	{
		string errorMessage = computeErrorDescriptor.buildErrorMessage();

		puts(errorMessage.ptr);
		return;
	}

	scope(exit) OpenClComputeStatic.releaseBuffer(computeBufferForDepth);


	// create kernel
	// NOTE GC< maybe problematic >
	kernelParameters.length = 0;
	kernelParameters.length = 2;

	kernelParameters[0].size = (void*).sizeof;
	memcpy(&(kernelParameters[0].value), &computeBufferForDepth, computeBufferForDepth.sizeof);

	kernelParameters[1].size = float.sizeof;
	// NOTE< we keep the float unset because we don't use it for now >

	kernelForDepthOfSh = OpenClComputeStatic.createKernelAndBindArguments(computeProgram, "singleSHkernel", kernelParameters, computeErrorDescriptor);
	if( computeErrorDescriptor.errorHappend )
	{
		string errorMessage = computeErrorDescriptor.buildErrorMessage();

		puts(errorMessage.ptr);
		return;
	}

	scope(exit) OpenClComputeStatic.releaseKernel(kernelForDepthOfSh);


	// create queue
	// NOTE< choose device #0, this might be wrong on some PC's >
	mainCommandQueue = OpenClComputeStatic.createCommandQueue(computeContext, computeDeviceIds[0], computeErrorDescriptor);
	if( computeErrorDescriptor.errorHappend )
	{
		string errorMessage = computeErrorDescriptor.buildErrorMessage();

		puts(errorMessage.ptr);
		return;
	}

	scope(exit) OpenClComputeStatic.releaseCommandQueue(mainCommandQueue);


	// execute kernel
	OpenClComputeStatic.executeKernel(
		kernelForDepthOfSh,
		mainCommandQueue,
		[512, 512],
		[16, 8], 
		[],
		false,
		0,
		computeErrorDescriptor
	);

	puts("here");
	
	+/

	/+
	
	TODO< open window
	draw content of framebuffer

	engine:
	- rendering with simple shading
	- managment of view
	 * 
	- managment of view/partitioning screen for not 512x512 sizes
	- reflections
	 * reflection direction estimation/calculate reflection candidates
	 * calc reflection rays
	- shadows
	 >

	TODO< sound-music creation
	- algorithms

	>

	TODO< sound engine
	- granuar sythesis

	- timeslicing effects

	- echo

	- fft?
	 * compact recursive version (with implementation of slcicing)

	>

	+/














	/+
	auto platforms = CLHost.getPlatforms();
	if (platforms.length < 1)
	{
		writeln("No platforms available.");
		return;
	}
	
	auto platform = platforms[1];
	writefln("%s\n\t%s\n\t%s\n\t%s\n\t%s", platform.name, platform.vendor, platform.clversion, platform.profile, platform.extensions);

	auto devices = platform.allDevices;
	if (devices.length < 1)
	{
		writeln("No devices available.");
		return;
	}

	foreach(CLDevice device; devices)
		writefln("%s\n\t%s\n\t%s\n\t%s\n\t%s", device.name, device.vendor, device.driverVersion, device.clVersion, device.profile, device.extensions);
	
	auto context = CLContext(devices);
	
	// Create a command queue and use the first device
	auto queue = CLCommandQueue(context, devices[0]);

	
	/*auto program = context.createProgram(readText("test.opencl"));*/

	auto program = context.createProgram( mixin(CL_PROGRAM_STRING_DEBUG_INFO) ~ q{
				__kernel void sum(	__global const int* a,
									__global const int* b,
									__global int* c)
				{
					int i = get_global_id(0);
					c[i] = a[i] + b[i];
				} });
	
	writeln("building...");

	program.build("-w -Werror");
	writeln("done");
	writeln(program.buildLog(devices[0]));
		

	writeln("get kernel");
	auto kernel = CLKernel(program, "sum");
	writeln("got kernel");

	// create input vectors
	immutable VECTOR_SIZE = 100;
	int[VECTOR_SIZE] va = void; foreach(int i,e; va) va[i] = i;
	int[VECTOR_SIZE] vb = void; foreach(int i,e; vb) vb[i] = cast(int) vb.length - i;
	int[VECTOR_SIZE] vc;

	// Create CL buffers
	auto bufferA = CLBuffer(context, CL_MEM_READ_ONLY | CL_MEM_COPY_HOST_PTR, va.sizeof, va.ptr);
	auto bufferB = CLBuffer(context, CL_MEM_READ_ONLY | CL_MEM_USE_HOST_PTR, vb.sizeof, vb.ptr);
	auto bufferC = CLBuffer(context, CL_MEM_WRITE_ONLY | CL_MEM_USE_HOST_PTR, vc.sizeof, vc.ptr);

	// Copy lists A and B to the memory buffers
//	queue.enqueueWriteBuffer(bufferA, CL_TRUE, 0, va.sizeof, va.ptr);
//	queue.enqueueWriteBuffer(bufferB, CL_TRUE, 0, vb.sizeof, vb.ptr);

	// Set arguments to kernel
	kernel.setArgs(bufferA, bufferB, bufferC);

	// Run the kernel on specific ND range
	auto global	= NDRange(VECTOR_SIZE);
	//auto local	= NDRange(1);
	CLEvent execEvent = queue.enqueueNDRangeKernel(kernel, global);
	queue.flush();
	// wait for the kernel to be executed
	execEvent.wait();

	// Read buffer vc into a local list
	// TODO: figure out why this call is needed even though CL_MEM_USE_HOST_PTR is used
	queue.enqueueReadBuffer(bufferC, CL_TRUE, 0, vc.sizeof, vc.ptr);

	foreach(i,e; vc)
	{
		writef("%d + %d = %d\n", va[i], vb[i], vc[i]);
	}

	+/
}
