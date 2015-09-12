# -*- coding: utf-8 -*-

import sys

# input is the (changed) assembly filename
# replaces all dereferences of fs:__except_list with 0, so [fs:0] is written, which is right
# is a deep hack into the D se-H(andling) mechanism
# because
# i don't know how to set __except_list from outside to 0

objectFileAssemblyName = sys.argv[1]

inputFile = open(objectFileAssemblyName, "rb")
content = inputFile.read()
inputFile.close()

# replace
content = content.replace("[fs:__except_list]", "[fs:0]")

outputFile = open(objectFileAssemblyName, "wb")
outputFile.write(content)
outputFile.close()