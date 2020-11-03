//
//	AddProductCategory.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class AddProductCategory : NSObject, NSCoding{

	var categoryName : String!
	var id : Int!
	var subcategories : [AddProductSubcategory]!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		categoryName = dictionary["category_name"] as? String
		id = dictionary["id"] as? Int
		subcategories = [AddProductSubcategory]()
		if let subcategoriesArray = dictionary["subcategories"] as? [[String:Any]]{
			for dic in subcategoriesArray{
				let value = AddProductSubcategory(fromDictionary: dic)
				subcategories.append(value)
			}
		}
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if categoryName != nil{
			dictionary["category_name"] = categoryName
		}
		if id != nil{
			dictionary["id"] = id
		}
		if subcategories != nil{
			var dictionaryElements = [[String:Any]]()
			for subcategoriesElement in subcategories {
				dictionaryElements.append(subcategoriesElement.toDictionary())
			}
			dictionary["subcategories"] = dictionaryElements
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         categoryName = aDecoder.decodeObject(forKey: "category_name") as? String
         id = aDecoder.decodeObject(forKey: "id") as? Int
         subcategories = aDecoder.decodeObject(forKey :"subcategories") as? [AddProductSubcategory]

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if categoryName != nil{
			aCoder.encode(categoryName, forKey: "category_name")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if subcategories != nil{
			aCoder.encode(subcategories, forKey: "subcategories")
		}

	}

}