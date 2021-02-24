//
//	ProductData.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class ProductData : NSObject, NSCoding{

	var approvedCreatedAt : String!
	var copyrightCreatedAt : String!
	var depth : String!
	var forProductionCreatedAt : ProductForProductionCreatedAt!
	var height : String!
	var id : Int!
	var image : String!
	var imagesFrom : Int!
	var isCopyright : Int!
	var isProductForProduction : Int!
	var isSendMail : String!
	var length : String!
	var name : String!
	var price : String!
	var sku : String!
	var statusId : String!
	var statusValue : String!
	var tlvPrice : String!
	var tlvSuggestedPriceMax : String!
	var tlvSuggestedPriceMin : String!
	var weight : String!
	var width : String!
	var data : [ProductData]!
	var recordsFiltered : String!
	var recordsTotal : String!
    var isArchive: Bool = false
    var isDelete: Bool = false
    var isSubmit: Bool = false
    var isDownloaded: Bool = false
	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		approvedCreatedAt = dictionary["approved_created_at"] as? String
		copyrightCreatedAt = dictionary["copyright_created_at"] as? String
		depth = dictionary["depth"] as? String
		if let forProductionCreatedAtData = dictionary["for_production_created_at"] as? [String:Any]{
			forProductionCreatedAt = ProductForProductionCreatedAt(fromDictionary: forProductionCreatedAtData)
		}
		height = dictionary["height"] as? String
		id = dictionary["id"] as? Int
		image = dictionary["image"] as? String
		imagesFrom = dictionary["images_from"] as? Int
		isCopyright = dictionary["is_copyright"] as? Int
		isProductForProduction = dictionary["is_product_for_production"] as? Int
		isSendMail = dictionary["is_send_mail"] as? String
		length = dictionary["length"] as? String
		name = dictionary["name"] as? String
		price = dictionary["price"] as? String
		sku = dictionary["sku"] as? String
		statusId = dictionary["status_id"] as? String
		statusValue = dictionary["status_value"] as? String
		tlvPrice = dictionary["tlv_price"] as? String
		tlvSuggestedPriceMax = dictionary["tlv_suggested_price_max"] as? String
		tlvSuggestedPriceMin = dictionary["tlv_suggested_price_min"] as? String
		weight = dictionary["weight"] as? String
		width = dictionary["width"] as? String
		data = [ProductData]()
		if let dataArray = dictionary["data"] as? [[String:Any]]{
			for dic in dataArray{
				let value = ProductData(fromDictionary: dic)
				data.append(value)
			}
		}
		recordsFiltered = dictionary["recordsFiltered"] as? String
		recordsTotal = dictionary["recordsTotal"] as? String
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if approvedCreatedAt != nil{
			dictionary["approved_created_at"] = approvedCreatedAt
		}
		if copyrightCreatedAt != nil{
			dictionary["copyright_created_at"] = copyrightCreatedAt
		}
		if depth != nil{
			dictionary["depth"] = depth
		}
		if forProductionCreatedAt != nil{
			dictionary["for_production_created_at"] = forProductionCreatedAt.toDictionary()
		}
		if height != nil{
			dictionary["height"] = height
		}
		if id != nil{
			dictionary["id"] = id
		}
		if image != nil{
			dictionary["image"] = image
		}
		if imagesFrom != nil{
			dictionary["images_from"] = imagesFrom
		}
		if isCopyright != nil{
			dictionary["is_copyright"] = isCopyright
		}
		if isProductForProduction != nil{
			dictionary["is_product_for_production"] = isProductForProduction
		}
		if isSendMail != nil{
			dictionary["is_send_mail"] = isSendMail
		}
		if length != nil{
			dictionary["length"] = length
		}
		if name != nil{
			dictionary["name"] = name
		}
		if price != nil{
			dictionary["price"] = price
		}
		if sku != nil{
			dictionary["sku"] = sku
		}
		if statusId != nil{
			dictionary["status_id"] = statusId
		}
		if statusValue != nil{
			dictionary["status_value"] = statusValue
		}
		if tlvPrice != nil{
			dictionary["tlv_price"] = tlvPrice
		}
		if tlvSuggestedPriceMax != nil{
			dictionary["tlv_suggested_price_max"] = tlvSuggestedPriceMax
		}
		if tlvSuggestedPriceMin != nil{
			dictionary["tlv_suggested_price_min"] = tlvSuggestedPriceMin
		}
		if weight != nil{
			dictionary["weight"] = weight
		}
		if width != nil{
			dictionary["width"] = width
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
         approvedCreatedAt = aDecoder.decodeObject(forKey: "approved_created_at") as? String
         copyrightCreatedAt = aDecoder.decodeObject(forKey: "copyright_created_at") as? String
         depth = aDecoder.decodeObject(forKey: "depth") as? String
         forProductionCreatedAt = aDecoder.decodeObject(forKey: "for_production_created_at") as? ProductForProductionCreatedAt
         height = aDecoder.decodeObject(forKey: "height") as? String
         id = aDecoder.decodeObject(forKey: "id") as? Int
         image = aDecoder.decodeObject(forKey: "image") as? String
         imagesFrom = aDecoder.decodeObject(forKey: "images_from") as? Int
         isCopyright = aDecoder.decodeObject(forKey: "is_copyright") as? Int
         isProductForProduction = aDecoder.decodeObject(forKey: "is_product_for_production") as? Int
         isSendMail = aDecoder.decodeObject(forKey: "is_send_mail") as? String
         length = aDecoder.decodeObject(forKey: "length") as? String
         name = aDecoder.decodeObject(forKey: "name") as? String
         price = aDecoder.decodeObject(forKey: "price") as? String
         sku = aDecoder.decodeObject(forKey: "sku") as? String
         statusId = aDecoder.decodeObject(forKey: "status_id") as? String
         statusValue = aDecoder.decodeObject(forKey: "status_value") as? String
         tlvPrice = aDecoder.decodeObject(forKey: "tlv_price") as? String
         tlvSuggestedPriceMax = aDecoder.decodeObject(forKey: "tlv_suggested_price_max") as? String
         tlvSuggestedPriceMin = aDecoder.decodeObject(forKey: "tlv_suggested_price_min") as? String
         weight = aDecoder.decodeObject(forKey: "weight") as? String
         width = aDecoder.decodeObject(forKey: "width") as? String
         data = aDecoder.decodeObject(forKey :"data") as? [ProductData]
         recordsFiltered = aDecoder.decodeObject(forKey: "recordsFiltered") as? String
         recordsTotal = aDecoder.decodeObject(forKey: "recordsTotal") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if approvedCreatedAt != nil{
			aCoder.encode(approvedCreatedAt, forKey: "approved_created_at")
		}
		if copyrightCreatedAt != nil{
			aCoder.encode(copyrightCreatedAt, forKey: "copyright_created_at")
		}
		if depth != nil{
			aCoder.encode(depth, forKey: "depth")
		}
		if forProductionCreatedAt != nil{
			aCoder.encode(forProductionCreatedAt, forKey: "for_production_created_at")
		}
		if height != nil{
			aCoder.encode(height, forKey: "height")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if image != nil{
			aCoder.encode(image, forKey: "image")
		}
		if imagesFrom != nil{
			aCoder.encode(imagesFrom, forKey: "images_from")
		}
		if isCopyright != nil{
			aCoder.encode(isCopyright, forKey: "is_copyright")
		}
		if isProductForProduction != nil{
			aCoder.encode(isProductForProduction, forKey: "is_product_for_production")
		}
		if isSendMail != nil{
			aCoder.encode(isSendMail, forKey: "is_send_mail")
		}
		if length != nil{
			aCoder.encode(length, forKey: "length")
		}
		if name != nil{
			aCoder.encode(name, forKey: "name")
		}
		if price != nil{
			aCoder.encode(price, forKey: "price")
		}
		if sku != nil{
			aCoder.encode(sku, forKey: "sku")
		}
		if statusId != nil{
			aCoder.encode(statusId, forKey: "status_id")
		}
		if statusValue != nil{
			aCoder.encode(statusValue, forKey: "status_value")
		}
		if tlvPrice != nil{
			aCoder.encode(tlvPrice, forKey: "tlv_price")
		}
		if tlvSuggestedPriceMax != nil{
			aCoder.encode(tlvSuggestedPriceMax, forKey: "tlv_suggested_price_max")
		}
		if tlvSuggestedPriceMin != nil{
			aCoder.encode(tlvSuggestedPriceMin, forKey: "tlv_suggested_price_min")
		}
		if weight != nil{
			aCoder.encode(weight, forKey: "weight")
		}
		if width != nil{
			aCoder.encode(width, forKey: "width")
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
