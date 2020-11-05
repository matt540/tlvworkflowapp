//
//	AddProductPickupLocation.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class AddProductPickupLocation : NSObject, NSCoding{

	var createdAt : AddProductCreatedAt!
	var deletedAt : AnyObject!
	var id : Int!
	var keyText : AnyObject!
	var selectId : AddProductSelectId!
	var sellerId : AnyObject!
	var updatedAt : AddProductCreatedAt!
	var valueText : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		if let createdAtData = dictionary["created_at"] as? [String:Any]{
			createdAt = AddProductCreatedAt(fromDictionary: createdAtData)
		}
		deletedAt = dictionary["deletedAt"] as? AnyObject
		id = dictionary["id"] as? Int
		keyText = dictionary["key_text"] as? AnyObject
		if let selectIdData = dictionary["select_id"] as? [String:Any]{
			selectId = AddProductSelectId(fromDictionary: selectIdData)
		}
		sellerId = dictionary["seller_id"] as? AnyObject
		if let updatedAtData = dictionary["updated_at"] as? [String:Any]{
			updatedAt = AddProductCreatedAt(fromDictionary: updatedAtData)
		}
		valueText = dictionary["value_text"] as? String
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
		if keyText != nil{
			dictionary["key_text"] = keyText
		}
		if selectId != nil{
			dictionary["select_id"] = selectId.toDictionary()
		}
		if sellerId != nil{
			dictionary["seller_id"] = sellerId
		}
		if updatedAt != nil{
			dictionary["updated_at"] = updatedAt.toDictionary()
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
         createdAt = aDecoder.decodeObject(forKey: "created_at") as? AddProductCreatedAt
         deletedAt = aDecoder.decodeObject(forKey: "deletedAt") as? AnyObject
         id = aDecoder.decodeObject(forKey: "id") as? Int
         keyText = aDecoder.decodeObject(forKey: "key_text") as? AnyObject
         selectId = aDecoder.decodeObject(forKey: "select_id") as? AddProductSelectId
         sellerId = aDecoder.decodeObject(forKey: "seller_id") as? AnyObject
         updatedAt = aDecoder.decodeObject(forKey: "updated_at") as? AddProductCreatedAt
         valueText = aDecoder.decodeObject(forKey: "value_text") as? String

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
		if keyText != nil{
			aCoder.encode(keyText, forKey: "key_text")
		}
		if selectId != nil{
			aCoder.encode(selectId, forKey: "select_id")
		}
		if sellerId != nil{
			aCoder.encode(sellerId, forKey: "seller_id")
		}
		if updatedAt != nil{
			aCoder.encode(updatedAt, forKey: "updated_at")
		}
		if valueText != nil{
			aCoder.encode(valueText, forKey: "value_text")
		}

	}

}