# stripping utility

# TODO< 
# * data labels are not recursivly marked
# * remove/outcomment old legacy code
# >
import pdb
import re

class IInformationFollower(object):
	# called when the Sissecter enters a new section
	def enterSection(self, name, alignment, attribute):
		pass

	def addLabel(self, labelname):
		pass

	def addAssembly(self, memonic, params):
		pass

	def addDataByte(self, elements):
		pass

	def addDataWord(self, elements):
		pass

	def addDataDoubleWord(self, elements):
		pass

	def addExternSymbol(self, symbolName):
		pass

class SectionInfo(object):
	def __init__(self, name, alignment, attribute):
		self.name = name
		self.alignment = alignment
		self.attribute = attribute

		self.content = []

	def isData(self):
		return self.getSectionType() == EnumSectionType.DATASECTION

	def isText(self):
		return self.getSectionType() == EnumSectionType.TEXTSECTION

	def getSectionType(self):
		# NOTE< this propably only works for OMF input object-files >
		# TODO< generalize for other types >
		if self.attribute == "noexecute":
			return EnumSectionType.DATASECTION

		return EnumSectionType.TEXTSECTION


class EnumSectionContentType(object):
	LABEL = 0
	MEMONIC = 1
	DATABYTE = 2
	DATADOUBLEWORD = 3
	DATAWORD = 4

# stores the memonics/labels/data in the sections and hold it accessible
class StorageInformationFollower(IInformationFollower):
	def __init__(self):
		self.sections = {}
		self.currentSectionName = None
		self._externSymbols = []

	def enterSection(self, name, alignment, attribute):
		newSection = SectionInfo(name, alignment, attribute)
		self.sections[name] = newSection

		self.currentSectionName = name

	def addLabel(self, labelname):
		self.sections[self.currentSectionName].content.append({"type":EnumSectionContentType.LABEL, "data":{"labelname":labelname}})

	def addAssembly(self, memonic, params):
		# small hack to remove FLAT prefix, because nasm can handle it
		# TODO< move into own wrapping stge for input? >
		params = params.replace("FLAT:", "")

		self.sections[self.currentSectionName].content.append({"type":EnumSectionContentType.MEMONIC, "data":{"memonic":memonic, "params":params}})

	def addDataByte(self, elements):
		self.sections[self.currentSectionName].content.append({"type":EnumSectionContentType.DATABYTE, "data":{"elements":elements}})

	def addDataDoubleWord(self, elements):
		self.sections[self.currentSectionName].content.append({"type":EnumSectionContentType.DATADOUBLEWORD, "data":{"elements":elements}})

	def addDataWord(self, elements):
		self.sections[self.currentSectionName].content.append({"type":EnumSectionContentType.DATAWORD, "data":{"elements":elements}})

	def getExternSymbols(self):
		return self._externSymbols

	def addExternSymbol(self, symbolName):
		self._externSymbols.append(symbolName)

class EnumParseState(object):
	BEGINNING = 0
	INSECTION = 1

class Dissecter(object):
	def __init__(self):
		self._regexAssemblyWithoutParams = re.compile("\ +(?P<memonic>[a-z]+)")
		self._regexAssembly = re.compile("\ +(?P<memonic>[a-z]+)\ +(?P<params>[0-9A-Za-z\-,\ \[\]:_\+\?\@\*]+)")
		self._regexSection = re.compile("SECTION\ (?P<sectionname>[A-Za-z0-9\$\?\_\.\@]+)\ +align=(?P<align>[0-9]+)\ (?P<attribute>.+)")
		self._regexLabel = re.compile("^(?P<name>[A-Za-z0-9\_\?\@]+)\:(?P<remainder>.*)")

		self._regexDataByte = re.compile("\ +db\ (?P<data>.+)")
		self._regexDataWord = re.compile("\ +dw\ (?P<data>.+)")
		self._regexDataDoubleWord = re.compile("\ +dd\ (?P<data>.+)")

		self.informationFollower = None # must be set from the outside

	@staticmethod
	def _getUncommented(line):
		commentPosition = line.find(";")

		if commentPosition != -1:
			return line[:commentPosition]

		return line

	def parse(self, lines):
		# 0 : beginning
		# 

		state = EnumParseState.BEGINNING

		for line in lines:
			matched = False

			# for debugging
			readLineContent = line

			line = Dissecter._getUncommented(line)

			line = line.rstrip()

			readLineContent = line

			resultLabel = self._regexLabel.search(line)

			if resultLabel != None:
				self.informationFollower.addLabel(
					resultLabel.groupdict()["name"]
				)

				line = resultLabel.groupdict()["remainder"]

			if line == "":
				# we ignore blank lines
				continue

			# must happen before other stuff, else funny bugs creep up
			if len(line) > 7 and line[:7] == "SECTION":
				resultSection = self._regexSection.search(line)

				if resultSection == None:
					print("[ERROR]== " + "section is irgnored because of invalid signs:")
					print("..." + line)

					self.informationFollower.enterSection(
						"META_IGNORE",
						16,
						""
					)

				else:
					self.informationFollower.enterSection(
						resultSection.groupdict()["sectionname"],
						int(resultSection.groupdict()["align"]),
						resultSection.groupdict()["attribute"]
					)

				state = EnumParseState.INSECTION

				matched = True

				continue

			if len(line) > len("extern ") and line[:len("extern ")] == "extern ":
				self.informationFollower.addExternSymbol(line[len("extern "):])

				matched = True

				continue

			if state == EnumParseState.INSECTION:
				resultDataByte = self._regexDataByte.search(line)
				resultDataDoubleWord = self._regexDataDoubleWord.search(line)
				resultDataWord = self._regexDataWord.search(line)
				
				resultAssembly = self._regexAssembly.search(line)
				resultAssemblyWithoutParams = self._regexAssemblyWithoutParams.search(line)

				if resultDataByte != None:
					self.informationFollower.addDataByte(
						resultDataByte.groupdict()["data"].split(", ")
					)

					matched = True

				elif resultDataDoubleWord != None:
					self.informationFollower.addDataDoubleWord(
						resultDataDoubleWord.groupdict()["data"].split(", ")
					)

					matched = True

				elif resultDataWord != None:
					self.informationFollower.addDataWord(
						resultDataWord.groupdict()["data"].split(", ")
					)

					matched = True

				elif resultAssembly != None:
					# it is a assembly line

					self.informationFollower.addAssembly(
						resultAssembly.groupdict()["memonic"],
						resultAssembly.groupdict()["params"]
					)

					matched = True

				elif resultAssemblyWithoutParams != None:
					self.informationFollower.addAssembly(
						resultAssemblyWithoutParams.groupdict()["memonic"],
						""
					)

					matched = True

			

			if not matched:
				#print("ERROR: line didn't match!")
				#print(line)
				#print("read:" + readLineContent + "<-")
				pass

# enum for the termination of the _getElementsOfSectionForLabel function
class EnumTerminationType(object):
	TILLENDOFSECTION = 0
	TILLNEXTJUMP = 1

# enum for the type for the _msCoffExporterGetStringOfSectionsWithUsedSymbols()
class EnumSectionType(object):
	TEXTSECTION = 0
	DATASECTION = 1

# enum for the possible labeltypes/value for the dict with all labels of a section
class EnumLabelType(object):
	NOTUSED = 0
	TEXTLABEL = 1 # executable
	DATALABEL = 2 # nonexecutable

# used to write out sections (and depending stuff) from a StorageInformationFollower
class ObjectWriteOut(object):
	def __init__(self):
		self._regexMovregPtr = re.compile("(?P<dest>[a-z]+),\ dword\ \[(?P<srcAddress>.+)\]")
		self._regexMovRegLabel = re.compile("(?P<dest>[a-z]+),\ (?P<labelname>[a-zA-Z\_\?^0-9][A-Za-z0-9\_\?]+)")
		# TODO< must be acually adress because it can be a src and a dest >
		self._regexPtr = re.compile("d?word\ \[(?P<srcAddress>.+)\]")
		self._regexLabel = re.compile("^[A-Za-z\_\@\?][A-Za-z0-9\_\@\?]+$")

		self._sectionCounter = 0

		# TODO< remove this >
		self.config = {"forceExport":[]}

	# enumerates symbols in sections,
	# exports only sections which contain referenced/exported symbols

	# this logic can also be used as a linker
	# the only point is to rename the local labels or organize the object-files splited
	def getStringOfWrittenOutObjectFile(self, exportedSymbols, informationFollower):
		dictOfLabelsAndSectioninfoBySections = self._getLabelsOfAllSections(informationFollower)

		# mark all Symbols/labels which are reachable/exported
		self._markSymbols(dictOfLabelsAndSectioninfoBySections, exportedSymbols)

		# get all extern symbols
		externSymbolsInOrginalFile = informationFollower.getExternSymbols()

		# propagate label usages recursivly
		self._propagateLabelUsages(dictOfLabelsAndSectioninfoBySections, exportedSymbols, externSymbolsInOrginalFile)

		# get used extern labels
		usedExternalSymbols = self._getReferencedExternalSymbolsAsList(dictOfLabelsAndSectioninfoBySections, externSymbolsInOrginalFile)

		print("DEBUG usedExternalSymbols " + str(usedExternalSymbols))

		# public symbols can't be extern
		usedExternalSymbols = list(set(usedExternalSymbols) - set(exportedSymbols))

		# write intro into output
		objectFileContent = "format MS COFF\n\n"

		# write extern labels into output
		objectFileContent += self._getStringOfImportSymbols(usedExternalSymbols)

		# write public symbols into output
		objectFileContent += self._getStringOfExports(exportedSymbols)

		# export the referenced labels in the data section into the new data section
		objectFileContent += self._msCoffExporterGetStringOfSectionsWithUsedSymbols(dictOfLabelsAndSectioninfoBySections, EnumSectionType.DATASECTION)

		# TODO< export the referenced executable text-sections >
		objectFileContent += self._msCoffExporterGetStringOfSectionsWithUsedSymbols(dictOfLabelsAndSectioninfoBySections, EnumSectionType.TEXTSECTION)


		return objectFileContent

	# LEGACY no legacy

	# \result is a dict with the sectionnames as the key and a dict as a value with
	#         "labels" is a dict with Labels, values are the referencing status
	#         "sectionInfo" is the sectionInfo object

	def _msCoffExporterGetStringOfSectionsWithUsedSymbols(self, dictOfLabelsAndSectioninfoBySections, sectionType):
		def translateSectionTypeToCorrectLabelType():
			if sectionType == EnumSectionType.TEXTSECTION:
				return EnumLabelType.TEXTLABEL
			elif sectionType == EnumSectionType.DATASECTION:
				return EnumLabelType.DATALABEL
			else:
				assert False, "Should be unreachable!"

		# element of dictOfLabelsAndSectioninfoBySections is passed in
		def getReferencedLabels(dictElement):
			referencedLabelsnames = []

			for labelname in dictElement["labels"].keys():
				if dictElement["labels"][labelname] == translateSectionTypeToCorrectLabelType():
					referencedLabelsnames.append(labelname)

			return referencedLabelsnames


		def getExportedStringForLabelInSectionInfo(labelname, sectionInfo):
			resultString = labelname + ":\n"

			elements = None

			if sectionType == EnumSectionType.DATASECTION:
				elements = self._getElementsOfSectionForLabel(labelname, sectionInfo, EnumTerminationType.TILLNEXTJUMP)
			else:
				elements = self._getElementsOfSectionForLabel(labelname, sectionInfo, EnumTerminationType.TILLENDOFSECTION)

			#print("DEBUG _getElementsOfSectionForLabel() returned " + str(elements))
			print("DEBUG HERE 2")


			resultString = resultString + ObjectWriteOut._getStringOfElements(elements)

			print("DEBUG HERE")

			return resultString

		# replaces the MASM syntax with FSM syntax in the datasection
		def replaceMasmOutputOfDataSection(output):
			return output.replace("resd", "dd")

		if sectionType == EnumSectionType.DATASECTION:
			resultString = "section '.DATA' data" + "\n"
		else:
			resultString = "section '.TEXT' executable" + "\n"

		for dictElement in dictOfLabelsAndSectioninfoBySections.values():
			if sectionType == EnumSectionType.DATASECTION and dictElement["sectionInfo"].isText():
				continue

			labelsWhichAreReferenced = getReferencedLabels(dictElement)

			for referencedLabelname in labelsWhichAreReferenced:

				print("DEBUG for referenced label " + referencedLabelname)
				print("DEBUG getExportedStringForLabelInSectionInfo() returned: " + getExportedStringForLabelInSectionInfo(referencedLabelname, dictElement["sectionInfo"]))

				resultString += getExportedStringForLabelInSectionInfo(referencedLabelname, dictElement["sectionInfo"])

		resultString += "\n"

		if sectionType == EnumSectionType.DATASECTION:
			resultString = replaceMasmOutputOfDataSection(resultString)

		return resultString

	# LEGACY no legacy
	
	## \brief returns the string of the elements (from a section) as a string
	@staticmethod
	def _getStringOfElements(elements):
		objectFileString = ""

		for iterationElement in elements:
			cachedType = iterationElement["type"]

			if cachedType == EnumSectionContentType.MEMONIC:
				objectFileString += iterationElement["data"]["memonic"] + " " + iterationElement["data"]["params"]
			elif cachedType == EnumSectionContentType.LABEL:
				objectFileString +=  iterationElement["data"]["labelname"] + ":"
			elif cachedType == EnumSectionContentType.DATABYTE:
				joinedElements = ",".join(iterationElement["data"]["elements"]).replace("FLAT:", "")
				objectFileString += "db " + joinedElements
			elif cachedType == EnumSectionContentType.DATAWORD:
				joinedElements = ",".join(iterationElement["data"]["elements"]).replace("FLAT:", "")
				objectFileString += "dw " + joinedElements
			elif cachedType == EnumSectionContentType.DATADOUBLEWORD:
				joinedElements = ",".join(iterationElement["data"]["elements"]).replace("FLAT:", "")
				objectFileString += "dd " + joinedElements
			else:
				assert False, "Should be unreachable!"

			objectFileString += "\n"

		return objectFileString

	# LEGACY no legacy

	# mark all Symbols/labels which are reachable/exported
	def _markSymbols(self, dictOfLabelsAndSectioninfoBySections, entrySymbols):
		for dictElement in dictOfLabelsAndSectioninfoBySections.values():
			labelType = ObjectWriteOut._translateSectionTypeToCorrectLabelType(dictElement["sectionInfo"].getSectionType())

			for iterationLabelName in dictElement["labels"].keys():
				if iterationLabelName in entrySymbols:
					# mark it as reachable
					dictElement["labels"][iterationLabelName] = labelType

	# LEGACY no legacy
	@staticmethod
	def _translateSectionTypeToCorrectLabelType(sectionType):
		if sectionType == EnumSectionType.TEXTSECTION:
			return EnumLabelType.TEXTLABEL
		elif sectionType == EnumSectionType.DATASECTION:
			return EnumLabelType.DATALABEL
		else:
			assert False, "Should be unreachable!"

	# LEGACY no legacy

	# propagate label usages recursivly
	# \param dictOfLabelsAndSectioninfoBySections ...
	# \param exportedSymbols list with all symbol names which are exported, are used as entries for the recursive search
	# \param externSymbols list with all symbol names which are allready external and don't need any recursivly search
	def _propagateLabelUsages(self, dictOfLabelsAndSectioninfoBySections, exportedSymbols, externSymbols):
		def getSectionInfoWithLabelInside(labelName):
			for iterationDictElement in dictOfLabelsAndSectioninfoBySections.values():
				if labelName in iterationDictElement["labels"]:
					return iterationDictElement["sectionInfo"]

			assert False, "No section Found which contains label - Should be unreachable!"


		# set with all discovered symbol names
		discoveredLabelsSet = set(externSymbols)

		# set with all remaining labels
		remainingSymbolsSet = set(exportedSymbols)

		while len(list(remainingSymbolsSet)) > 0:
			# pop a symbol name
			currentLabelName = list(remainingSymbolsSet)[0]
			remainingSymbolsSet = set(list(remainingSymbolsSet)[1:])

			discoveredLabelsSet.add(currentLabelName)

			sectionInfoWhichContainsLabel = getSectionInfoWithLabelInside(currentLabelName)

			if sectionInfoWhichContainsLabel.isData():
				sectionName = sectionInfoWhichContainsLabel.name
				resultUnknownLabelsAsSet = self._searchReferencedLabelsInNonexecutableSectionAsSet(sectionInfoWhichContainsLabel)
			else:
				resultUnknownLabelsAsSet = self._searchReferencedLabelsInExecutableSectionByLabelAsSet(sectionInfoWhichContainsLabel, currentLabelName)

			resultUnknownLabelsAsSet = resultUnknownLabelsAsSet - discoveredLabelsSet


			remainingSymbolsSet = remainingSymbolsSet | resultUnknownLabelsAsSet


	# LEGACY no legacy

	def _searchReferencedLabelsInNonexecutableSectionAsSet(self, sectionInfo):
		# TODO

		# we just for now return a void set
		return set([])


	# LEGACY no legacy

	def _searchReferencedLabelsInExecutableSectionByLabelAsSet(self, sectionInfo, label):
		# NOTE< we ignore the label because
		#       * a section contains only one function (in a dmd-omf object-file)
		#       * it doesn't have any sense to trace reachalbe labels???
		#       
		#       so we effectivly return just the label itself
		#     >

		return set([label])















	# LEGACY no legacy

	# checks if an externSymbol is referenced by any code section
	# \param dictOfLabelsAndSectioninfoBySections dict, see _getLabelsOfAllSections()
	# \param externSymbols ..., is a list
	# \result list
	def _getReferencedExternalSymbolsAsList(self, dictOfLabelsAndSectioninfoBySections, externSymbols):
		def translateExternSymbolsToDict():
			resultDict = {}

			for iterationExternSymbol in externSymbols:
				resultDict[iterationExternSymbol] = False

			return resultDict

		def translateReferencedElementsInDictIntoList(resultDict):
			resultList = []

			for iterationKey in resultDict.keys():
				if resultDict[iterationKey]:
					resultList.append(iterationKey)

			return resultList

		externSymbolsUsageDict = translateExternSymbolsToDict()

		for iterationDict in dictOfLabelsAndSectioninfoBySections.values():
			sectionInfo = iterationDict["sectionInfo"]

			self._markCalledOrJumpedExternSymbols(sectionInfo, externSymbolsUsageDict)

		return translateReferencedElementsInDictIntoList(externSymbolsUsageDict)



	# LEGACY no legacy

	# searches in the assembly fr called or jumped extern symbols
	#
	# \param sectionInfo ...
	# \param externSymbols is a dict with the symbol names as keys and the values are booleans
	# \result None
	def _markCalledOrJumpedExternSymbols(self, sectionInfo, externSymbols):
		def ifExternMark(symbolName):
			if symbolName in externSymbols:
				externSymbols[symbolName] = True

		for iterationContent in sectionInfo.content:
			if iterationContent["type"] != EnumSectionContentType.MEMONIC:
				continue

			isNonLocal = len(iterationContent["data"]["params"]) > 0 and iterationContent["data"]["params"][0] != "?"
			isJumpOrCall = iterationContent["data"]["memonic"] == "jmp" or iterationContent["data"]["memonic"] == "call"
			isMov = iterationContent["data"]["memonic"] == "mov"

			if isJumpOrCall:
				symbolName = iterationContent["data"]["params"]
				
				# this converts near [labelname] into labelname
				if symbolName[:6] == "near [":
					symbolName = symbolName[6:-1] 

				regexResultLabel = self._regexLabel.search(symbolName)
				isLabel = regexResultLabel != None and symbolName not in ["eax", "ebx", "ecx", "edx", "esi", "edi", "esp", "ebp"]

				if isNonLocal and isJumpOrCall and isLabel:
					ifExternMark(symbolName)
			
			elif isMov:
				splitedParams = iterationContent["data"]["params"].split(", ")

				if len(splitedParams) == 2:
					regexResultPtr = self._regexPtr.search(splitedParams[0])
					regexResultLabelRight = self._regexLabel.search(splitedParams[1])


					if \
				   		splitedParams[0] in ["eax", "ebx", "ecx", "edx", "esi", "edi", "esp", "ebp"] and \
				   		splitedParams[1] not in ["eax", "ebx", "ecx", "edx", "esi", "edi", "esp", "ebp"] and \
				   		splitedParams[1][0] != "?":
					
						if regexResultLabelRight != None:
							# we assume that the 2nd param is a label
							ifExternMark(splitedParams[1])

					elif regexResultPtr != None:
						ptrAddress = regexResultPtr.groupdict()["srcAddress"]

						regexResultLabel = self._regexLabel.search(ptrAddress)

						if regexResultLabel != None and ptrAddress not in ["eax", "ebx", "ecx", "edx", "esi", "edi", "esp", "ebp"]:
							ifExternMark(ptrAddress)

















	# LEGACY legacy

	# exports sections
	def getStringOfWrittenOutObjectFileLegacy(self, exportedSections, informationFollower):
		calledOrJumpedSymbols = self._collectCalledOrJumpedSymbols(exportedSections, informationFollower)
		# convert the dictionary to a list because we don't need the speed of the dictionary anymore
		calledOrJumpedSymbols = calledOrJumpedSymbols.keys()

		objectfileContent = "format MS COFF\n\n"

		# HACK
		# we remove the .TEXT$ crap in front of the exportedSections
		# needed that we don't import exported sybmols

		exportedSymbols = []
		for exportedSection in exportedSections:
			exportedSymbols.append(exportedSection.replace(".text$", ""))

		objectfileContent += self._getStringOfImportSymbols(list(set(calledOrJumpedSymbols) - set(exportedSymbols)))
		objectfileContent += "\n"

		objectfileContent += self._getStringOfExports(exportedSections)
		objectfileContent += "\n"


		# the purpose of this section is to
		#  * get all referenced labels outside of the code
		#  * recursivly deted which labels we need (labels can adress other labels and so on)
		#
		# this is needed to detect and write out only referenced text sections
		# 
		# NOTE< as known labels we pass in a void set, this is a bit wrong because we know actually some symbols... >
		unknownLabelnamesSet = self._getAllUndefinedReferencedLabelnamesForAllSections(exportedSections, informationFollower, set())
		reachableLabels = self._getAllReachableLabels(unknownLabelnamesSet, informationFollower)
		filteredReachableLabels = ObjectWriteOut._filterLabels(reachableLabels)


		objectfileContent += self._getStringOfUsedDataLabels(filteredReachableLabels, informationFollower)
		objectfileContent += "\n"

		# TODO< check if the symbols are in the follower available >

		for iterationSectionName in exportedSections:
			objectfileContent += self._getStringOfSection(iterationSectionName, informationFollower)

		return objectfileContent

	# LEGACY

	def _getStringOfImportSymbols(self, symbolNames):
		result = ""

		for iterationSymbolName in symbolNames:
			result += "extrn" + " " + iterationSymbolName + "\n"

		result += "\n"

		for iterationSymbolName in self.config["forceExport"]:
			result += "extrn" + " " + iterationSymbolName + "\n"

		return result

	# LEGACY

	# goes through each symbol of symbolNames and searches in the assembly for symbols
	# which are jumped to or called
	#
	# the result is a hashmap with the names as keys and True as (dummy) value
	def _collectCalledOrJumpedSymbols(self, sectionNames, informationFollower):
		symbols = {}

		for iterationSectionName in sectionNames:
			if not iterationSectionName in informationFollower.sections:
				raise Exception("section " + iterationSectionName + " is not present!")

			section = informationFollower.sections[iterationSectionName]

			for iterationContent in section.content:
				if iterationContent["type"] == EnumSectionContentType.MEMONIC:
					isNonLocal = len(iterationContent["data"]["params"]) > 0 and iterationContent["data"]["params"][0] != "?"
					isJumpOrCall = iterationContent["data"]["memonic"] == "jmp" or iterationContent["data"]["memonic"] == "call"
					#isFld = iterationContent["data"]["memonic"] == "fld"
					#isFmul = iterationContent["data"]["memonic"] == "fmul"
					#isFldcw = iterationContent["data"]["memonic"] == "fldcw"
					isMov = iterationContent["data"]["memonic"] == "mov"

					if isJumpOrCall:
						symbolName = iterationContent["data"]["params"]
						
						# this converts near [labelname] into labelname
						if symbolName[:6] == "near [":
							symbolName = symbolName[6:-1] 

						regexResultLabel = self._regexLabel.search(symbolName)
						isLabel = regexResultLabel != None and symbolName not in ["eax", "ebx", "ecx", "edx", "esi", "edi", "esp", "ebp"]

						if isNonLocal and isJumpOrCall and isLabel:
							symbols[symbolName] = True
					
					elif isMov:
						splitedParams = iterationContent["data"]["params"].split(", ")

						if len(splitedParams) == 2:
							regexResultPtr = self._regexPtr.search(splitedParams[0])
							regexResultLabelRight = self._regexLabel.search(splitedParams[1])


							if \
						   		splitedParams[0] in ["eax", "ebx", "ecx", "edx", "esi", "edi", "esp", "ebp"] and \
						   		splitedParams[1] not in ["eax", "ebx", "ecx", "edx", "esi", "edi", "esp", "ebp"] and \
						   		splitedParams[1][0] != "?":
							
								if regexResultLabelRight != None:
									# we assume that the 2nd param is a label
									symbols[splitedParams[1]] = True

							elif regexResultPtr != None:
								ptrAddress = regexResultPtr.groupdict()["srcAddress"]

								regexResultLabel = self._regexLabel.search(ptrAddress)

								if regexResultLabel != None and ptrAddress not in ["eax", "ebx", "ecx", "edx", "esi", "edi", "esp", "ebp"]:
									symbols[ptrAddress] = True

					# uncommented because it is faulty
					# because it adds local symbols
					#elif isFld or isFmul or isFldcw:
					#	regexResultPtr = self._regexPtr.search(iterationContent["data"]["params"])
						
					#	ptrAddress = regexResultPtr.groupdict()["srcAddress"]

					#	regexResultLabel = self._regexLabel.search(ptrAddress)
					#	isLabel = regexResultLabel != None and iterationContent["data"]["params"] not in ["eax", "ebx", "ecx", "edx", "esi", "edi", "esp", "ebp"]

					#	if isLabel:
					#		symbols[ptrAddress] = True


				elif iterationContent["type"] == EnumSectionContentType.LABEL:
					pass

		return symbols

	# LEGACY no legacy

	def _getStringOfExports(self, symbolNames):
		exportString = ""

		for iterationSymbol in symbolNames:
			# because else we couldn't define these symbols in the very D file
			if iterationSymbol in self.config["forceExport"]:
				continue

			# LEGACY< if not in legacy -> remove replace >
			exportString += "public " + iterationSymbol.replace(".text$", "") + "\n"

		return exportString

	# LEGACY
	
	def _getStringOfSection(self, sectionName, informationFollower):
		objectfileContent = ""

		self._sectionCounter = 0

		# we need the counter as a section name because the dmd object-file section names are far too long
		objectfileContent += "section '" + str(self._sectionCounter) + "' " + "executable" + "\n"

		section = informationFollower.sections[sectionName]

		for iterationContent in section.content:
			if iterationContent["type"] == EnumSectionContentType.MEMONIC:
				objectfileContent += iterationContent["data"]["memonic"] + " " + iterationContent["data"]["params"] + "\n"
			elif iterationContent["type"] == EnumSectionContentType.LABEL:
				objectfileContent +=  iterationContent["data"]["labelname"] + ":" + "\n"

		return objectfileContent

	# LEGACY

	def _getStringOfUsedDataLabels(self, labelNames, informationFollower):
		# TODO< alignment on 16 bytes >
		sectionString = "section '" + ".TEXT" + "' data" + "\n"

		for iterationLabelName in labelNames:
			sectionString = sectionString + iterationLabelName + ":" + "\n"

			print("[VERBOSE]==:" + "_getStringOfUsedDataLabels()" + " " + "labelName" + " " + str(iterationLabelName))

			adressedElements = self._getElementsTillEndOrNextLabel(iterationLabelName, informationFollower, ".DATA")

			#print("[VERBOSE]==:" + "_getStringOfUsedDataLabels()" + " " + "adressedElements" + " " + str(adressedElements))

			for iterationContent in adressedElements:
				if iterationContent["type"] == EnumSectionContentType.DATADOUBLEWORD:
					sectionString = sectionString + "dd "
				elif iterationContent["type"] == EnumSectionContentType.DATABYTE:
					sectionString = sectionString + "db "
				elif iterationContent["type"] == EnumSectionContentType.DATAWORD:
					sectionString = sectionString + "dw "

				# HACK< repacing FLAT: with nothing >
				# because fasm won't accept it
				sectionString = sectionString + ",".join(iterationContent["data"]["elements"]).replace("FLAT:", "")
				sectionString = sectionString + "\n"

		return sectionString

	# LEGACY

	def _getAllUndefinedReferencedLabelnamesForAllSections(self, sectionNames, informationFollower, knownLabels):
		undefinedLabelnames = set()

		for iterationSectionName in sectionNames:
			undefinedLabelnames = undefinedLabelnames | self._getAllUndefinedReferencedLabelnames(iterationSectionName, informationFollower, knownLabels)

		return undefinedLabelnames

	# LEGACY

	# 
	# 
	# \param knownLabels must be a set
	# \result is a set
	def _getAllUndefinedReferencedLabelnames(self, sectionName, informationFollower, knownLabels):
		allLabelNames = self._getAllReferencedLabelnames(sectionName, informationFollower)

		# we return the set allLabelNames subtracted with knownLabels
		return allLabelNames - knownLabels

	# LEGACY
	# just a wrapper for the legacy code which doesn't differentiate between section types
	def _getAllReferencedLabelnames(self, sectionName, informationFollower):
		return self._getAllReferencedLabelnames2(informationFollower.sections[sectionName])

	# LEGACY

	def _getAllReferencedLabelnames2(self, sectionInfo):
		referencedLabelsnames = set()

		section = sectionInfo

		for iterationContent in section.content:
			# assert is valid because it is forbidden to find data stuff in executable code
			if iterationContent["type"] != EnumSectionContentType.MEMONIC:
				continue

			# we are here if it is a memonic

			memonic = iterationContent["data"]["memonic"]
			params = iterationContent["data"]["params"]

			if memonic == "mov":
				# we are here if it is a mov

				regexResultRegPtr = self._regexMovregPtr.search(params)
				regexResultRegLabel = self._regexMovRegLabel.search(params)

				if regexResultRegPtr != None:
					memonicSourceAddress = regexResultRegPtr.groupdict()["srcAddress"]

					if memonicSourceAddress[0] != "?":
						continue

					referencedLabelsnames.add(memonicSourceAddress)

				elif regexResultRegLabel != None:
					rightOperand = regexResultRegLabel.groupdict()["labelname"]

					# we sort out common registers because they can also swim in
					# TODO 64bit< we have far more registers >
					if rightOperand[:3] in ["eax", "ebx", "ecx", "edx", "esi", "edi", "esp", "ebp"]:
						continue

					memonicLabel = rightOperand

					referencedLabelsnames.add(memonicLabel)

			elif memonic == "push":
				# we are here if it is a push

				regexResultPtr = self._regexPtr.search(params)

				if regexResultPtr == None:
					continue

				# we are here if the regex matches

				memonicSourceAddress = regexResultPtr.groupdict()["srcAddress"]

				if memonicSourceAddress[0] != "?":
					continue

				referencedLabelsnames.add(memonicSourceAddress)

			elif memonic == "fld" or memonic == "fmul" or memonic == "fldcw":
				regexResultPtr = self._regexPtr.search(iterationContent["data"]["params"])
						
				ptrAddress = regexResultPtr.groupdict()["srcAddress"]

				regexResultLabel = self._regexLabel.search(ptrAddress)
				isLabel = regexResultLabel != None and iterationContent["data"]["params"] not in ["eax", "ebx", "ecx", "edx", "esi", "edi", "esp", "ebp"]

				if isLabel:
					referencedLabelsnames.add(ptrAddress)


			###elif memonic == "call":
			###	print("CALL params:" + str(" ".join(params)))

		return referencedLabelsnames

	# LEGACY

	# tries to find more labels (which are not until now defined) in the supplied section
	# is actually used to search recursivly for undefined symbols until all are known
	# after this all referenced data parts are written out
	#
	# \param knownLabels is a set
	#
	# \result is a set with new labels
	def _getUnknownLabelsByLabel(self, label, informationFollower, sectionName, knownLabels):
		unknownLabels = []

		elementsAfterLabel = self._getElementsTillEndOrNextLabel(label, informationFollower, sectionName)

		for iterationElement in elementsAfterLabel:
			# NOTE 64bit< this depends on the wordsize, is on 64 bit systems different (dd+dq?) >
			if iterationElement["type"] != EnumSectionContentType.DATADOUBLEWORD:
				continue

			# we are here when it are dwords

			for iterationValueString in iterationElement["data"]["elements"]:
				# NOTE< we depend here on FLAT: to detect if it is a label >
				if len(iterationValueString) > 5 and iterationValueString[:5] == "FLAT:":
					labelName = iterationValueString[5:]

					if labelName not in knownLabels:
						unknownLabels.append(labelName)

		return unknownLabels

	# LEGACY

	# is a wrapper around the non-legacy version

	def _getElementsTillEndOrNextLabel(self, label, informationFollower, sectionName):
		sectionInfo = informationFollower.sections[sectionName]

		return self._getElementsOfSectionForLabel(label, sectionInfo, EnumTerminationType.TILLNEXTJUMP)

	# LEGACY no legacy

	# \param label the name of the startlabel
	# \param sectionInfo ...
	# \param terminationType value from EnumTerminationType

	def _getElementsOfSectionForLabel(self, label, sectionInfo, terminationType):
		class EnumState(object):
			SEARCHENTRY = 0
			READ = 1

		state = EnumState.SEARCHENTRY
		resultElements = []

		for iterationContent in sectionInfo.content:
			if state == EnumState.SEARCHENTRY:
				if iterationContent["type"] == EnumSectionContentType.LABEL and \
				   iterationContent["data"]["labelname"] == label:
					state = EnumState.READ
					continue

				continue

			elif state == EnumState.READ:
				if iterationContent["type"] == EnumSectionContentType.LABEL and terminationType == EnumTerminationType.TILLNEXTJUMP:
					break

				# if we are here it is not a label, so we can store it
				resultElements.append(iterationContent)

		return resultElements


	# LEGACY

	# \param  unknownLabelsSet is a set or a list with all unknown labels which should be recursivly walked
	def _getAllReachableLabels(self, unknownLabelsSet, informationFollower):
		# set with all labels where we checked the dependencies
		checkedLabelsSet = set()

		remainingUnknownLabelsSet = set(list(unknownLabelsSet))

		while len(list(remainingUnknownLabelsSet)) > 0:
			currentLabelName = list(remainingUnknownLabelsSet)[0]
			remainingUnknownLabelsSet = set(list(remainingUnknownLabelsSet)[1:])

			checkedLabelsSet.add(currentLabelName)

			resultUnknownLabelsAsList = self._getUnknownLabelsByLabel(currentLabelName, informationFollower, ".DATA", checkedLabelsSet)

			remainingUnknownLabelsSet = remainingUnknownLabelsSet | set(resultUnknownLabelsAsList)

		return list(checkedLabelsSet)

	# LEGACY nolegacy

	# \result is a dict with the sectionnames as the key and a dict as a value with
	#         "labels" is a dict with Labels, values are the referencing status
	#         "sectionInfo" is the sectionInfo object
	def _getLabelsOfAllSections(self, informationFollower):
		# filter from sectionContent only the labels
		def filterLabels(sectionContent):
			#resultElements = []

			#for iterationContent in sectionContent:
			#	if iterationContent["type"] == EnumSectionContentType.LABEL:
			#		resultElements.append(iterationContent)

			#return resultElements

			return [iterationContent   for iterationContent in sectionContent   if iterationContent["type"] == EnumSectionContentType.LABEL]

		def getLabelNames(elements):
			return [element["data"]["labelname"] for element in elements]

		# result is a list
		def getLabelsOfSection(sectionInfo):
			return getLabelNames(filterLabels(informationFollower.sections[sectionInfo.name].content))

		# converts a list with the label names to a dict with he value false
		def convertLabelNamesToDict(labelNames):
			dictLabels = {}

			for labelName in labelNames:
				dictLabels[labelName] = EnumLabelType.NOTUSED

			return dictLabels

		resultDict = {}

		for iterationSectionName in informationFollower.sections.keys():
			iterationSectionInfo = informationFollower.sections[iterationSectionName]

			element = {
				"labels":convertLabelNamesToDict(getLabelsOfSection(iterationSectionInfo)),
				"sectionInfo":iterationSectionInfo
			}

			resultDict[iterationSectionName] = element

		return resultDict

	# LEGACY

	# filters the labels (which should only lie in the .DATA section) for "alien" labels which are external
	# is needed because dmd stores some exception handling stuff in the .DATA section
	# which sadly gets included (only a few bytes per function)
	@staticmethod
	def _filterLabels(labels):
		result = []

		for iterationLabel in labels:
			if iterationLabel[0] == "?":
				result.append(iterationLabel)

		return result

# wrapper for debugging
def translate(inputObjectFileAssemblyName, outputObjectFileAssemblyName, exportedSections, sectionsAreSymbols):
	if False: #sectionsAreSymbols:
		pdb.runcall(translate2, inputObjectFileAssemblyName, outputObjectFileAssemblyName, exportedSections, sectionsAreSymbols)
	else:
		translate2(inputObjectFileAssemblyName, outputObjectFileAssemblyName, exportedSections, sectionsAreSymbols)

# TODO< make sectionsAreSymbols standard >
# (need to rewrite all *_exported.txt files)
def translate2(inputObjectFileAssemblyName, outputObjectFileAssemblyName, exportedSections, sectionsAreSymbols):
	linesWithoutNewline = []

	fileHandle = open(inputObjectFileAssemblyName, "r")
	outputObjectFileHandle = open(outputObjectFileAssemblyName, "w")

	informationFollower = StorageInformationFollower()

	disecter = Dissecter()
	disecter.informationFollower = informationFollower


	for line in fileHandle.readlines():
		linesWithoutNewline.append(line[:-1])

	disecter.parse(linesWithoutNewline)


	writeOut = ObjectWriteOut()
	writeOut.config["forceExport"] = []


	# TODO< rewrite this >
	if sectionsAreSymbols:
		objectFileContent = writeOut.getStringOfWrittenOutObjectFile(exportedSections, informationFollower)
	else:
		objectFileContent = writeOut.getStringOfWrittenOutObjectFileLegacy(exportedSections, informationFollower)

	outputObjectFileHandle.write(objectFileContent)
	outputObjectFileHandle.close()
