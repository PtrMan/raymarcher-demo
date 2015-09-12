class EnumSectionContentType(object):
	LABEL = 0
	MEMONIC = 1
	DATABYTE = 2
	DATADOUBLEWORD = 3
	DATAWORD = 4

def _getStringOfElements(elements):
	objectFileString = ""

	elements = [{'type': 2, 'data': {'elements': ['83H', '0FAH', '9AH', '27H', '81H', '49H', '0CEH', '11H']}}]

	for iterationElement in elements:
		objectFileString += "\n\n\n"
		objectFileString += str(iterationElement)

		if iterationElement["type"] == EnumSectionContentType.MEMONIC:
			objectFileString += iterationElement["data"]["memonic"] + " " + iterationElement["data"]["params"] + "\n"
		elif iterationElement["type"] == EnumSectionContentType.LABEL:
			objectFileString +=  iterationElement["data"]["labelname"] + ":" + "\n"
		elif iterationElement["type"] == EnumSectionContentType.DATABYTE:
			#iterationElement["type"] == EnumSectionContentType.DATAWORD or \
			#iterationElement["type"] == EnumSectionContentType.DATADOUBLEWORD:

			objectFileString += "INSIDE" + "\n"

			objectFileString += str(iterationElement["type"] == EnumSectionContentType.DATADOUBLEWORD) + "\n"
			objectFileString += str(iterationElement["type"] == EnumSectionContentType.DATAWORD) + "\n"
			objectFileString += str(iterationElement["type"] == EnumSectionContentType.DATABYTE) + "\n"

			if   iterationElement["type"] == EnumSectionContentType.DATADOUBLEWORD:
				objectFileString += objectFileString + "dd "
			elif iterationElement["type"] == EnumSectionContentType.DATABYTE:
				objectFileString += objectFileString + "db "
			elif iterationElement["type"] == EnumSectionContentType.DATAWORD:
				objectFileString += objectFileString + "dw "

			objectFileString += objectFileString + "+++"

			# HACK< repacing FLAT: with nothing >
			# because fasm won't accept it
			objectFileString += objectFileString + ",".join(iterationElement["data"]["elements"]).replace("FLAT:", "")
			objectFileString += objectFileString + "\n"
		else:
			assert(False, "Should be unreachable!")

	return objectFileString

print(_getStringOfElements(None))
