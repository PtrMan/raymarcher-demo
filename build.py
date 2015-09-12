import subprocess
import os

def doExit(Reason, Text):
	print(Reason)
	
	if Text != None:
		print("="*20)
		print(Text)
	
	exit(1)

class BuildEnvironment(object):
	def __init__(self):
		# is a dict with
		# "action" is a function which gets as parameter the configuration and the step itself 
		#          must return a list with dicts with
		#               "path"
		#               "arguments"
		self._steps = []

		self.configuration = {}

	def build(self):
		for step in self._steps:
			actionResultList = step["action"](self.configuration, step)

			self.doActions(actionResultList)

	# exits on error
	def doActions(self, actionResultList):
		for actionResult in actionResultList:
			print("BUILD-[]: execute " + actionResult["path"] + " " + " ".join(actionResult["arguments"]) )

			f = subprocess.Popen(actionResult["path"] + " " + " ".join(actionResult["arguments"]), stderr=subprocess.PIPE)
			f.wait()
		
			message = f.stderr.read()
		
			if len(message) > 0 :
				doExit("[E]", message)

buildEnvironment = BuildEnvironment()

buildEnvironment.configuration = {
	"pathToObjconv" : "C:\\Users\\r0b3\\files\\programme\\objconv\\objconvOld",
	"pathToDmd" : "dmd",
	"pathToFasm" : "C:\\Users\\r0b3\\files\\programme\\fasmw17121\\fasm",
	"pathToLink" : "C:\\Program Files (x86)\\Microsoft Visual Studio 12.0\\VC\\bin\\link"
}

# action which does
# * compile the objectName with dmd
# * disasssemble the objectfile
# * convert it into MS Coff assembly source
# * convert the source with FASM to an MS Coff object file
def actionCompileDisassembleTranscribeCompile(configuration, step):
	instantiateFlag = ""

	if step["instanciatetemplates"]:
		instantiateFlag = "-allinst"

	return [
		{
			"path":configuration["pathToDmd"],
			"arguments":["-version=CL_VERSION_1_1", "-defaultlib=", "-c", "-release", instantiateFlag, "-J.", "-op", step["objectName"] + ".d"]
		},
	

		{
			"path":configuration["pathToObjconv"],
			"arguments":["-fnasm", step["objectName"] + ".obj"]
		},

		{
			"path":"python",
			"arguments":["replaceStrangeSymbols.py", step["objectName"] + ".asm"]
		},

		{
			"path":"python",
			"arguments":["transcriberTool.py", step["objectName"], step["containsSymbols"]]
		},

		{
			"path":"python",
			"arguments":["replaceExceptionHandlingWithZero.py", step["objectName"] + "_ms.asm"]
		},

		{
			"path":configuration["pathToFasm"],
			"arguments":[step["objectName"] + "_ms.asm"]
		}
	]

def actionLink(configuration, step):
	return [
	{
		"path":configuration["pathToLink"],
		"arguments":[
			"/VERBOSE",
			"/SUBSYSTEM:CONSOLE",
			#"/SUBSYSTEM:WINDOWS",
			"/MAP",
			"/NODEFAULTLIB",
			"/ENTRY:D3app5entryFZv",
			"\"C:\\Program Files (x86)\\Windows Kits\\8.0\\Lib\\Win8\\Um\\X86\\Kernel32.lib\"",
			"\"C:\\Program Files (x86)\\Windows Kits\\8.0\\Lib\\Win8\\Um\\X86\\User32.lib\"",
			"\"C:\\Program Files (x86)\\Windows Kits\\8.0\\Lib\\Win8\\Um\\X86\\Gdi32.lib\"",
			"\"C:\\Program Files (x86)\\Windows Kits\\8.0\\Lib\\Win8\\Um\\X86\\Ole32.lib\"",
			"libctiny.lib",
			"\"C:\\Program Files\\NVIDIA GPU Computing Toolkit\\Cuda\\V6.0\\Lib\\Win32\\OpenCl.lib\"",
			"MiniRuntimeAsm.obj",
			"ComputeImplementationErrorDescriptor_ms.obj",
			"OpenClComputeStatic_ms.obj",
			"ScopeGuardMemory_ms.obj",
			"MiniRuntime_ms.obj",
			"App_ms.obj",
			"InstanciatedTemplates_ms.obj",
			"ExceptionHandlingStub_ms.obj",
			"Misc_ms.obj",
			"Window_ms.obj",
			"Math_ms.obj",
			"DirectSoundDir/DirectSound_ms.obj",
			"DirectSoundDir/ComManager_ms.obj",
			"DirectSoundDir/dsound_ms.obj",
			"allocators/DartAllocator_ms.obj"
		]
	}
	]

# list with all object files which we want to build/link
# the flag reprensents if the instances should be expanded
buildInfo = [
("ComputeImplementationErrorDescriptor", False),
("OpenClComputeStatic", False),
("ScopeGuardMemory", False),
("MiniRuntime", False),
("app", True),
("InstanciatedTemplates", True),
("ExceptionHandlingStub", False),
("Misc", False),
("Window", False),
("Math", False),
("DirectSoundDir/DirectSound", False),
("allocators/DartAllocator", False),
("synth/Core", False)
]

# associated *_exportedSymbols.txt file contains really symbols
buildInfoWithSymbols = [
("DirectSoundDir/dsound", False),
("DirectSoundDir/ComManager", False)
]

for buildObjectName in buildInfoWithSymbols:
	buildEnvironment._steps.append(
		{
			"action": actionCompileDisassembleTranscribeCompile,
			"objectName": buildObjectName[0],
			"instanciatetemplates" : buildObjectName[1],
			"containsSymbols" : "symbols"
		}
	)


for buildObjectName in buildInfo:
	buildEnvironment._steps.append(
		{
			"action": actionCompileDisassembleTranscribeCompile,
			"objectName": buildObjectName[0],
			"instanciatetemplates" : buildObjectName[1],
			"containsSymbols" : "no"
		}
	)

buildEnvironment._steps.append(
	{
		"action": actionLink
		# TODO< params >
	}
)

buildEnvironment.build()
