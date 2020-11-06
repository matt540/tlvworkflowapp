//
//	AddProductKeyText.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class AddProductKeyText : NSObject, NSCoding{

	var city : String!
	var state : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		city = dictionary["city"] as? String
		state = dictionary["state"] as? String
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if city != nil{
			dictionary["city"] = city
		}
		if state != nil{
			dictionary["state"] = state
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         city = aDecoder.decodeObject(forKey: "city") as? String
         state = aDecoder.decodeObject(forKey: "state") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if city != nil{
			aCoder.encode(city, forKey: "city")
		}
		if state != nil{
			aCoder.encode(state, forKey: "state")
		}

	}

}