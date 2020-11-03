//
//	AddProductData.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class AddProductData : NSObject, NSCoding{

	var age : [AddProductAge]!
	var categories : [AddProductCategory]!
	var pickupLocations : [AddProductPickupLocation]!
	var sellers : [AddProductSeller]!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		age = [AddProductAge]()
		if let ageArray = dictionary["age"] as? [[String:Any]]{
			for dic in ageArray{
				let value = AddProductAge(fromDictionary: dic)
				age.append(value)
			}
		}
		categories = [AddProductCategory]()
		if let categoriesArray = dictionary["categories"] as? [[String:Any]]{
			for dic in categoriesArray{
				let value = AddProductCategory(fromDictionary: dic)
				categories.append(value)
			}
		}
		pickupLocations = [AddProductPickupLocation]()
		if let pickupLocationsArray = dictionary["pickup_locations"] as? [[String:Any]]{
			for dic in pickupLocationsArray{
				let value = AddProductPickupLocation(fromDictionary: dic)
				pickupLocations.append(value)
			}
		}
		sellers = [AddProductSeller]()
		if let sellersArray = dictionary["sellers"] as? [[String:Any]]{
			for dic in sellersArray{
				let value = AddProductSeller(fromDictionary: dic)
				sellers.append(value)
			}
		}
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if age != nil{
			var dictionaryElements = [[String:Any]]()
			for ageElement in age {
				dictionaryElements.append(ageElement.toDictionary())
			}
			dictionary["age"] = dictionaryElements
		}
		if categories != nil{
			var dictionaryElements = [[String:Any]]()
			for categoriesElement in categories {
				dictionaryElements.append(categoriesElement.toDictionary())
			}
			dictionary["categories"] = dictionaryElements
		}
		if pickupLocations != nil{
			var dictionaryElements = [[String:Any]]()
			for pickupLocationsElement in pickupLocations {
				dictionaryElements.append(pickupLocationsElement.toDictionary())
			}
			dictionary["pickup_locations"] = dictionaryElements
		}
		if sellers != nil{
			var dictionaryElements = [[String:Any]]()
			for sellersElement in sellers {
				dictionaryElements.append(sellersElement.toDictionary())
			}
			dictionary["sellers"] = dictionaryElements
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         age = aDecoder.decodeObject(forKey :"age") as? [AddProductAge]
         categories = aDecoder.decodeObject(forKey :"categories") as? [AddProductCategory]
         pickupLocations = aDecoder.decodeObject(forKey :"pickup_locations") as? [AddProductPickupLocation]
         sellers = aDecoder.decodeObject(forKey :"sellers") as? [AddProductSeller]

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if age != nil{
			aCoder.encode(age, forKey: "age")
		}
		if categories != nil{
			aCoder.encode(categories, forKey: "categories")
		}
		if pickupLocations != nil{
			aCoder.encode(pickupLocations, forKey: "pickup_locations")
		}
		if sellers != nil{
			aCoder.encode(sellers, forKey: "sellers")
		}

	}

}