//
//	AddProductSeller.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class AddProductSeller : NSObject, NSCoding{

	var displayname : String!
	var firstname : String!
	var id : Int!
	var lastname : String!
	var wpSellerId : Int!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		displayname = dictionary["displayname"] as? String
		firstname = dictionary["firstname"] as? String
		id = dictionary["id"] as? Int
		lastname = dictionary["lastname"] as? String
		wpSellerId = dictionary["wp_seller_id"] as? Int
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if displayname != nil{
			dictionary["displayname"] = displayname
		}
		if firstname != nil{
			dictionary["firstname"] = firstname
		}
		if id != nil{
			dictionary["id"] = id
		}
		if lastname != nil{
			dictionary["lastname"] = lastname
		}
		if wpSellerId != nil{
			dictionary["wp_seller_id"] = wpSellerId
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         displayname = aDecoder.decodeObject(forKey: "displayname") as? String
         firstname = aDecoder.decodeObject(forKey: "firstname") as? String
         id = aDecoder.decodeObject(forKey: "id") as? Int
         lastname = aDecoder.decodeObject(forKey: "lastname") as? String
         wpSellerId = aDecoder.decodeObject(forKey: "wp_seller_id") as? Int

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if displayname != nil{
			aCoder.encode(displayname, forKey: "displayname")
		}
		if firstname != nil{
			aCoder.encode(firstname, forKey: "firstname")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if lastname != nil{
			aCoder.encode(lastname, forKey: "lastname")
		}
		if wpSellerId != nil{
			aCoder.encode(wpSellerId, forKey: "wp_seller_id")
		}

	}

}