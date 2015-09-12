# -*- coding: utf-8 -*-

import sys

objectFileAssemblyName = sys.argv[1]

inputFile = open(objectFileAssemblyName, "rb")
content = inputFile.read()
inputFile.close()

# replace
n = 127
while n < 255:
	content = content.replace(chr(n), hex(n)[1:])

	n += 1

outputFile = open(objectFileAssemblyName, "wb")
outputFile.write(content)
outputFile.close()