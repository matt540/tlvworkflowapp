//
//	AddProductSubcategory.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class AddProductSubcategory : NSObject, NSCoding{

	var categoryStoragePrice : String!
	var createdAt : AddProductCreatedAt!
	var deletedAt : AnyObject!
	var id : Int!
	var isEnable : Int!
	var orderValue : Int!
	var subCategoryName : String!
	var updatedAt : AddProductCreatedAt!
	var wpTermId : String!
    var isCategorySelected : Bool = false

	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		categoryStoragePrice = dictionary["category_storage_price"] as? String
		if let createdAtData = dictionary["created_at"] as? [String:Any]{
			createdAt = AddProductCreatedAt(fromDictionary: createdAtData)
		}
		deletedAt = dictionary["deletedAt"] as? AnyObject
		id = dictionary["id"] as? Int
		isEnable = dictionary["is_enable"] as? Int
		orderValue = dictionary["order_value"] as? Int
		subCategoryName = dictionary["sub_category_name"] as? String
		if let updatedAtData = dictionary["updated_at"] as? [String:Any]{
			updatedAt = AddProductCreatedAt(fromDictionary: updatedAtData)
		}
		wpTermId = dictionary["wp_term_id"] as? String
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if categoryStoragePrice != nil{
			dictionary["category_storage_price"] = categoryStoragePrice
		}
		if createdAt != nil{
			dictionary["created_at"] = createdAt.toDictionary()
		}
		if deletedAt != nil{
			dictionary["deletedAt"] = deletedAt
		}
		if id != nil{
			dictionary["id"] = id
		}
		if isEnable != nil{
			dictionary["is_enable"] = isEnable
		}
		if orderValue != nil{
			dictionary["order_value"] = orderValue
		}
		if subCategoryName != nil{
			dictionary["sub_category_name"] = subCategoryName
		}
		if updatedAt != nil{
			dictionary["updated_at"] = updatedAt.toDictionary()
		}
		if wpTermId != nil{
			dictionary["wp_term_id"] = wpTermId
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         categoryStoragePrice = aDecoder.decodeObject(forKey: "category_storage_price") as? String
         createdAt = aDecoder.decodeObject(forKey: "created_at") as? AddProductCreatedAt
         deletedAt = aDecoder.decodeObject(forKey: "deletedAt") as? AnyObject
         id = aDecoder.decodeObject(forKey: "id") as? Int
         isEnable = aDecoder.decodeObject(forKey: "is_enable") as? Int
         orderValue = aDecoder.decodeObject(forKey: "order_value") as? Int
         subCategoryName = aDecoder.decodeObject(forKey: "sub_category_name") as? String
         updatedAt = aDecoder.decodeObject(forKey: "updated_at") as? AddProductCreatedAt
         wpTermId = aDecoder.decodeObject(forKey: "wp_term_id") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if categoryStoragePrice != nil{
			aCoder.encode(categoryStoragePrice, forKey: "category_storage_price")
		}
		if createdAt != nil{
			aCoder.encode(createdAt, forKey: "created_at")
		}
		if deletedAt != nil{
			aCoder.encode(deletedAt, forKey: "deletedAt")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if isEnable != nil{
			aCoder.encode(isEnable, forKey: "is_enable")
		}
		if orderValue != nil{
			aCoder.encode(orderValue, forKey: "order_value")
		}
		if subCategoryName != nil{
			aCoder.encode(subCategoryName, forKey: "sub_category_name")
		}
		if updatedAt != nil{
			aCoder.encode(updatedAt, forKey: "updated_at")
		}
		if wpTermId != nil{
			aCoder.encode(wpTermId, forKey: "wp_term_id")
		}

	}

}
