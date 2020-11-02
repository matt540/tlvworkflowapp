//
//	SellerListData.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class SellerListData : NSObject, NSCoding{

	var address : String!
	var agentName : String!
	var displayname : String!
	var email : String!
	var firstname : String!
	var id : Int!
	var lastname : String!
	var pendingCount : String!
	var phone : String!
	var productQuotationId : Int!
	var data : [SellerListData]!
	var recordsFiltered : Int!
	var recordsTotal : Int!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		address = dictionary["address"] as? String
		agentName = dictionary["agent_name"] as? String
		displayname = dictionary["displayname"] as? String
		email = dictionary["email"] as? String
		firstname = dictionary["firstname"] as? String
		id = dictionary["id"] as? Int
		lastname = dictionary["lastname"] as? String
		pendingCount = dictionary["pending_count"] as? String
		phone = dictionary["phone"] as? String
		productQuotationId = dictionary["product_quotation_id"] as? Int
		data = [SellerListData]()
		if let dataArray = dictionary["data"] as? [[String:Any]]{
			for dic in dataArray{
				let value = SellerListData(fromDictionary: dic)
				data.append(value)
			}
		}
		recordsFiltered = dictionary["recordsFiltered"] as? Int
		recordsTotal = dictionary["recordsTotal"] as? Int
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if address != nil{
			dictionary["address"] = address
		}
		if agentName != nil{
			dictionary["agent_name"] = agentName
		}
		if displayname != nil{
			dictionary["displayname"] = displayname
		}
		if email != nil{
			dictionary["email"] = email
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
		if pendingCount != nil{
			dictionary["pending_count"] = pendingCount
		}
		if phone != nil{
			dictionary["phone"] = phone
		}
		if productQuotationId != nil{
			dictionary["product_quotation_id"] = productQuotationId
		}
		if data != nil{
			var dictionaryElements = [[String:Any]]()
			for dataElement in data {
				dictionaryElements.append(dataElement.toDictionary())
			}
			dictionary["data"] = dictionaryElements
		}
		if recordsFiltered != nil{
			dictionary["recordsFiltered"] = recordsFiltered
		}
		if recordsTotal != nil{
			dictionary["recordsTotal"] = recordsTotal
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         address = aDecoder.decodeObject(forKey: "address") as? String
         agentName = aDecoder.decodeObject(forKey: "agent_name") as? String
         displayname = aDecoder.decodeObject(forKey: "displayname") as? String
         email = aDecoder.decodeObject(forKey: "email") as? String
         firstname = aDecoder.decodeObject(forKey: "firstname") as? String
         id = aDecoder.decodeObject(forKey: "id") as? Int
         lastname = aDecoder.decodeObject(forKey: "lastname") as? String
         pendingCount = aDecoder.decodeObject(forKey: "pending_count") as? String
         phone = aDecoder.decodeObject(forKey: "phone") as? String
         productQuotationId = aDecoder.decodeObject(forKey: "product_quotation_id") as? Int
         data = aDecoder.decodeObject(forKey :"data") as? [SellerListData]
         recordsFiltered = aDecoder.decodeObject(forKey: "recordsFiltered") as? Int
         recordsTotal = aDecoder.decodeObject(forKey: "recordsTotal") as? Int

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if address != nil{
			aCoder.encode(address, forKey: "address")
		}
		if agentName != nil{
			aCoder.encode(agentName, forKey: "agent_name")
		}
		if displayname != nil{
			aCoder.encode(displayname, forKey: "displayname")
		}
		if email != nil{
			aCoder.encode(email, forKey: "email")
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
		if pendingCount != nil{
			aCoder.encode(pendingCount, forKey: "pending_count")
		}
		if phone != nil{
			aCoder.encode(phone, forKey: "phone")
		}
		if productQuotationId != nil{
			aCoder.encode(productQuotationId, forKey: "product_quotation_id")
		}
		if data != nil{
			aCoder.encode(data, forKey: "data")
		}
		if recordsFiltered != nil{
			aCoder.encode(recordsFiltered, forKey: "recordsFiltered")
		}
		if recordsTotal != nil{
			aCoder.encode(recordsTotal, forKey: "recordsTotal")
		}

	}

}