//
//	ProductForProductionCreatedAt.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class ProductForProductionCreatedAt : NSObject, NSCoding{

	var date : String!
	var timezone : String!
	var timezoneType : Int!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		date = dictionary["date"] as? String
		timezone = dictionary["timezone"] as? String
		timezoneType = dictionary["timezone_type"] as? Int
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if date != nil{
			dictionary["date"] = date
		}
		if timezone != nil{
			dictionary["timezone"] = timezone
		}
		if timezoneType != nil{
			dictionary["timezone_type"] = timezoneType
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         date = aDecoder.decodeObject(forKey: "date") as? String
         timezone = aDecoder.decodeObject(forKey: "timezone") as? String
         timezoneType = aDecoder.decodeObject(forKey: "timezone_type") as? Int

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if date != nil{
			aCoder.encode(date, forKey: "date")
		}
		if timezone != nil{
			aCoder.encode(timezone, forKey: "timezone")
		}
		if timezoneType != nil{
			aCoder.encode(timezoneType, forKey: "timezone_type")
		}

	}

}