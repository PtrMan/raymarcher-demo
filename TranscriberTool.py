import sys

from Transcriber import translate

objectFileAssemblyName = sys.argv[1]

exportedSymbolsFile = open(objectFileAssemblyName + "_exportedSymbols.txt")
writeOutSymbolsTemp = exportedSymbolsFile.readlines()
exportedSymbolsFile.close()

writeOutSymbols = []
for string in writeOutSymbolsTemp:
	writeOutSymbols.append(string.replace("\n", ""))

translate(objectFileAssemblyName + ".asm", objectFileAssemblyName + "_ms.asm", writeOutSymbols, sys.argv[2] == "symbols")
