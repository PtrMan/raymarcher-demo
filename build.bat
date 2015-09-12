dmd.exe -version=CL_VERSION_1_1 -defaultlib= -c app.d
dmd.exe -version=CL_VERSION_1_1 -defaultlib= -c ComputeImplementationErrorDescriptor.d
dmd.exe -version=CL_VERSION_1_1 -defaultlib= -c OpenClComputeStatic.d
dmd.exe -version=CL_VERSION_1_1 -defaultlib= -c misc.d
dmd.exe -version=CL_VERSION_1_1 -defaultlib= -c  dummyRuntime.d 


dmd.exe -version=CL_VERSION_1_1 -defaultlib= -map -w app.obj OpenClComputeStatic.obj ComputeImplementationErrorDescriptor.obj misc.obj dummyRuntime.obj openCl.lib 