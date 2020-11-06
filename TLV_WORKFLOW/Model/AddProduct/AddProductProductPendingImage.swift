//
//	AddProductProductPendingImage.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class AddProductProductPendingImage : NSObject, NSCoding{

	var createdAt : AddProductCreatedAt!
	var deletedAt : AnyObject!
	var id : Int!
	var name : String!
	var priority : Int!
	var updatedAt : AddProductCreatedAt!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		if let createdAtData = dictionary["created_at"] as? [String:Any]{
			createdAt = AddProductCreatedAt(fromDictionary: createdAtData)
		}
		deletedAt = dictionary["deletedAt"] as? AnyObject
		id = dictionary["id"] as? Int
		name = dictionary["name"] as? String
		priority = dictionary["priority"] as? Int
		if let updatedAtData = dictionary["updated_at"] as? [String:Any]{
			updatedAt = AddProductCreatedAt(fromDictionary: updatedAtData)
		}
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if createdAt != nil{
			dictionary["created_at"] = createdAt.toDictionary()
		}
		if deletedAt != nil{
			dictionary["deletedAt"] = deletedAt
		}
		if id != nil{
			dictionary["id"] = id
		}
		if name != nil{
			dictionary["name"] = name
		}
		if priority != nil{
			dictionary["priority"] = priority
		}
		if updatedAt != nil{
			dictionary["updated_at"] = updatedAt.toDictionary()
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         createdAt = aDecoder.decodeObject(forKey: "created_at") as? AddProductCreatedAt
         deletedAt = aDecoder.decodeObject(forKey: "deletedAt") as? AnyObject
         id = aDecoder.decodeObject(forKey: "id") as? Int
         name = aDecoder.decodeObject(forKey: "name") as? String
         priority = aDecoder.decodeObject(forKey: "priority") as? Int
         updatedAt = aDecoder.decodeObject(forKey: "updated_at") as? AddProductCreatedAt

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if createdAt != nil{
			aCoder.encode(createdAt, forKey: "created_at")
		}
		if deletedAt != nil{
			aCoder.encode(deletedAt, forKey: "deletedAt")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if name != nil{
			aCoder.encode(name, forKey: "name")
		}
		if priority != nil{
			aCoder.encode(priority, forKey: "priority")
		}
		if updatedAt != nil{
			aCoder.encode(updatedAt, forKey: "updated_at")
		}

	}

}