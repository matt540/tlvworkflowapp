//
//	PickUPLocationData.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class PickUPLocationData : NSObject, NSCoding{

	var id : Int!
	var keyText : [PickUPLocationKeyText]!
	var valueText : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		id = dictionary["id"] as? Int
		keyText = [PickUPLocationKeyText]()
		if let keyTextArray = dictionary["key_text"] as? [[String:Any]]{
			for dic in keyTextArray{
				let value = PickUPLocationKeyText(fromDictionary: dic)
				keyText.append(value)
			}
		}
		valueText = dictionary["value_text"] as? String
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if id != nil{
			dictionary["id"] = id
		}
		if keyText != nil{
			var dictionaryElements = [[String:Any]]()
			for keyTextElement in keyText {
				dictionaryElements.append(keyTextElement.toDictionary())
			}
			dictionary["key_text"] = dictionaryElements
		}
		if valueText != nil{
			dictionary["value_text"] = valueText
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         id = aDecoder.decodeObject(forKey: "id") as? Int
         keyText = aDecoder.decodeObject(forKey :"key_text") as? [PickUPLocationKeyText]
         valueText = aDecoder.decodeObject(forKey: "value_text") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if keyText != nil{
			aCoder.encode(keyText, forKey: "key_text")
		}
		if valueText != nil{
			aCoder.encode(valueText, forKey: "value_text")
		}

	}

}