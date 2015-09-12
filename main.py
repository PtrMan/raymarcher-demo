# Sample source code from the Tutorial Introduction in the documentation.

import pycuda.driver as cuda
import pycuda.autoinit
from pycuda.compiler import SourceModule

import numpy
outputDepths = numpy.random.randn(512, 512)

outputDepths = outputDepths.astype(numpy.float32)

outputDepths_gpu = cuda.mem_alloc(outputDepths.size * outputDepths.dtype.itemsize)

cuda.memcpy_htod(outputDepths_gpu, outputDepths)

f = open("C:\\Users\\r0b3\\files\\backuped\\own_dropbox\\programmierung\\raymarcher0\\raymarcher6.opencl")
filecontent = f.read()
f.close()

mod = SourceModule(filecontent)

func = mod.get_function("singleSHkernel")
func(outputDepths_gpu, block=(16,8,1), grid=(16,32))

# alternate kernel invocation -------------------------------------------------

# alternate kernel invocation -------------------------------------------------

func(cuda.InOut(outputDepths), numpy.float32(0.0), block=(16, 8, 1), grid=(16,32))
print "doubled with InOut:"
print outputDepths
