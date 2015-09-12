module InstanciatedTemplates;

import SimpleArray : SimpleArray;
//import opencl.c.opencl;
import KernelParameter : KernelParameter;

SimpleArray!string sources;
SimpleArray!int deviceIds;

SimpleArray!(SimpleArray!char) openclSources;
SimpleArray!KernelParameter kernelParameters;