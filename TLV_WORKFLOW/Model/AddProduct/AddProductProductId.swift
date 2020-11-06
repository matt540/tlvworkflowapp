//
//	AddProductProductId.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class AddProductProductId : NSObject, NSCoding{

	var age : AddProductAge!
	var approvedDate : AddProductCreatedAt!
	var brand : AddProductSubcategory!
	var brandLocal : String!
	var category : AnyObject!
	var categoryLocal : String!
	var city : String!
	var con : AnyObject!
	var conditionLocal : String!
	var createdAt : AddProductCreatedAt!
	var deletedAt : AnyObject!
	var descriptionField : String!
	var flatRatePackagingFee : String!
	var id : Int!
	var image : String!
	var isTouched : Int!
	var itemTypeLocal : String!
	var localPickupAvailable : Bool!
	var location : String!
	var name : String!
	var note : String!
	var petFree : String!
	var pickUpLocation : AddProductPickupLocation!
	var price : String!
	var productCategory : [AddProductSubcategory]!
	var productCollection : [AnyObject]!
	var productColor : [AddProductSubcategory]!
	var productCon : [AddProductSubcategory]!
	var productLook : [AnyObject]!
	var productMaterials : [AddProductSubcategory]!
	var productPendingImages : [AddProductProductPendingImage]!
	var productRoom : [AnyObject]!
	var quantity : String!
	var sellerFirstname : String!
	var sellerLastname : String!
	var sellerid : AddProductSellerid!
	var shipCat : String!
	var shipMaterial : Bool!
	var shipSize : String!
	var sku : String!
	var state : String!
	var tlvPrice : String!
	var tlvSuggestedPriceMax : String!
	var tlvSuggestedPriceMin : String!
	var updatedAt : AddProductCreatedAt!
	var wpImageUrl : String!
	var wpProductId : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		if let ageData = dictionary["age"] as? [String:Any]{
			age = AddProductAge(fromDictionary: ageData)
		}
		if let approvedDateData = dictionary["approved_date"] as? [String:Any]{
			approvedDate = AddProductCreatedAt(fromDictionary: approvedDateData)
		}
		if let brandData = dictionary["brand"] as? [String:Any]{
			brand = AddProductSubcategory(fromDictionary: brandData)
		}
		brandLocal = dictionary["brand_local"] as? String
		category = dictionary["category"] as? AnyObject
		categoryLocal = dictionary["category_local"] as? String
		city = dictionary["city"] as? String
		con = dictionary["con"] as? AnyObject
		conditionLocal = dictionary["condition_local"] as? String
		if let createdAtData = dictionary["created_at"] as? [String:Any]{
			createdAt = AddProductCreatedAt(fromDictionary: createdAtData)
		}
		deletedAt = dictionary["deletedAt"] as? AnyObject
		descriptionField = dictionary["description"] as? String
		flatRatePackagingFee = dictionary["flat_rate_packaging_fee"] as? String
		id = dictionary["id"] as? Int
		image = dictionary["image"] as? String
		isTouched = dictionary["is_touched"] as? Int
		itemTypeLocal = dictionary["item_type_local"] as? String
		localPickupAvailable = dictionary["local_pickup_available"] as? Bool
		location = dictionary["location"] as? String
		name = dictionary["name"] as? String
		note = dictionary["note"] as? String
		petFree = dictionary["pet_free"] as? String
		if let pickUpLocationData = dictionary["pick_up_location"] as? [String:Any]{
			pickUpLocation = AddProductPickupLocation(fromDictionary: pickUpLocationData)
		}
		price = dictionary["price"] as? String
		productCategory = [AddProductSubcategory]()
		if let productCategoryArray = dictionary["product_category"] as? [[String:Any]]{
			for dic in productCategoryArray{
				let value = AddProductSubcategory(fromDictionary: dic)
				productCategory.append(value)
			}
		}
		productCollection = dictionary["product_collection"] as? [AnyObject]
		productColor = [AddProductSubcategory]()
		if let productColorArray = dictionary["product_color"] as? [[String:Any]]{
			for dic in productColorArray{
				let value = AddProductSubcategory(fromDictionary: dic)
				productColor.append(value)
			}
		}
		productCon = [AddProductSubcategory]()
		if let productConArray = dictionary["product_con"] as? [[String:Any]]{
			for dic in productConArray{
				let value = AddProductSubcategory(fromDictionary: dic)
				productCon.append(value)
			}
		}
		productLook = dictionary["product_look"] as? [AnyObject]
		productMaterials = [AddProductSubcategory]()
		if let productMaterialsArray = dictionary["product_materials"] as? [[String:Any]]{
			for dic in productMaterialsArray{
				let value = AddProductSubcategory(fromDictionary: dic)
				productMaterials.append(value)
			}
		}
		productPendingImages = [AddProductProductPendingImage]()
		if let productPendingImagesArray = dictionary["product_pending_images"] as? [[String:Any]]{
			for dic in productPendingImagesArray{
				let value = AddProductProductPendingImage(fromDictionary: dic)
				productPendingImages.append(value)
			}
		}
		productRoom = dictionary["product_room"] as? [AnyObject]
		quantity = dictionary["quantity"] as? String
		sellerFirstname = dictionary["seller_firstname"] as? String
		sellerLastname = dictionary["seller_lastname"] as? String
		if let selleridData = dictionary["sellerid"] as? [String:Any]{
			sellerid = AddProductSellerid(fromDictionary: selleridData)
		}
		shipCat = dictionary["ship_cat"] as? String
		shipMaterial = dictionary["ship_material"] as? Bool
		shipSize = dictionary["ship_size"] as? String
		sku = dictionary["sku"] as? String
		state = dictionary["state"] as? String
		tlvPrice = dictionary["tlv_price"] as? String
		tlvSuggestedPriceMax = dictionary["tlv_suggested_price_max"] as? String
		tlvSuggestedPriceMin = dictionary["tlv_suggested_price_min"] as? String
		if let updatedAtData = dictionary["updated_at"] as? [String:Any]{
			updatedAt = AddProductCreatedAt(fromDictionary: updatedAtData)
		}
		wpImageUrl = dictionary["wp_image_url"] as? String
		wpProductId = dictionary["wp_product_id"] as? String
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if age != nil{
			dictionary["age"] = age.toDictionary()
		}
		if approvedDate != nil{
			dictionary["approved_date"] = approvedDate.toDictionary()
		}
		if brand != nil{
			dictionary["brand"] = brand.toDictionary()
		}
		if brandLocal != nil{
			dictionary["brand_local"] = brandLocal
		}
		if category != nil{
			dictionary["category"] = category
		}
		if categoryLocal != nil{
			dictionary["category_local"] = categoryLocal
		}
		if city != nil{
			dictionary["city"] = city
		}
		if con != nil{
			dictionary["con"] = con
		}
		if conditionLocal != nil{
			dictionary["condition_local"] = conditionLocal
		}
		if createdAt != nil{
			dictionary["created_at"] = createdAt.toDictionary()
		}
		if deletedAt != nil{
			dictionary["deletedAt"] = deletedAt
		}
		if descriptionField != nil{
			dictionary["description"] = descriptionField
		}
		if flatRatePackagingFee != nil{
			dictionary["flat_rate_packaging_fee"] = flatRatePackagingFee
		}
		if id != nil{
			dictionary["id"] = id
		}
		if image != nil{
			dictionary["image"] = image
		}
		if isTouched != nil{
			dictionary["is_touched"] = isTouched
		}
		if itemTypeLocal != nil{
			dictionary["item_type_local"] = itemTypeLocal
		}
		if localPickupAvailable != nil{
			dictionary["local_pickup_available"] = localPickupAvailable
		}
		if location != nil{
			dictionary["location"] = location
		}
		if name != nil{
			dictionary["name"] = name
		}
		if note != nil{
			dictionary["note"] = note
		}
		if petFree != nil{
			dictionary["pet_free"] = petFree
		}
		if pickUpLocation != nil{
			dictionary["pick_up_location"] = pickUpLocation.toDictionary()
		}
		if price != nil{
			dictionary["price"] = price
		}
		if productCategory != nil{
			var dictionaryElements = [[String:Any]]()
			for productCategoryElement in productCategory {
				dictionaryElements.append(productCategoryElement.toDictionary())
			}
			dictionary["product_category"] = dictionaryElements
		}
		if productCollection != nil{
			dictionary["product_collection"] = productCollection
		}
		if productColor != nil{
			var dictionaryElements = [[String:Any]]()
			for productColorElement in productColor {
				dictionaryElements.append(productColorElement.toDictionary())
			}
			dictionary["product_color"] = dictionaryElements
		}
		if productCon != nil{
			var dictionaryElements = [[String:Any]]()
			for productConElement in productCon {
				dictionaryElements.append(productConElement.toDictionary())
			}
			dictionary["product_con"] = dictionaryElements
		}
		if productLook != nil{
			dictionary["product_look"] = productLook
		}
		if productMaterials != nil{
			var dictionaryElements = [[String:Any]]()
			for productMaterialsElement in productMaterials {
				dictionaryElements.append(productMaterialsElement.toDictionary())
			}
			dictionary["product_materials"] = dictionaryElements
		}
		if productPendingImages != nil{
			var dictionaryElements = [[String:Any]]()
			for productPendingImagesElement in productPendingImages {
				dictionaryElements.append(productPendingImagesElement.toDictionary())
			}
			dictionary["product_pending_images"] = dictionaryElements
		}
		if productRoom != nil{
			dictionary["product_room"] = productRoom
		}
		if quantity != nil{
			dictionary["quantity"] = quantity
		}
		if sellerFirstname != nil{
			dictionary["seller_firstname"] = sellerFirstname
		}
		if sellerLastname != nil{
			dictionary["seller_lastname"] = sellerLastname
		}
		if sellerid != nil{
			dictionary["sellerid"] = sellerid.toDictionary()
		}
		if shipCat != nil{
			dictionary["ship_cat"] = shipCat
		}
		if shipMaterial != nil{
			dictionary["ship_material"] = shipMaterial
		}
		if shipSize != nil{
			dictionary["ship_size"] = shipSize
		}
		if sku != nil{
			dictionary["sku"] = sku
		}
		if state != nil{
			dictionary["state"] = state
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
		if updatedAt != nil{
			dictionary["updated_at"] = updatedAt.toDictionary()
		}
		if wpImageUrl != nil{
			dictionary["wp_image_url"] = wpImageUrl
		}
		if wpProductId != nil{
			dictionary["wp_product_id"] = wpProductId
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         age = aDecoder.decodeObject(forKey: "age") as? AddProductAge
         approvedDate = aDecoder.decodeObject(forKey: "approved_date") as? AddProductCreatedAt
         brand = aDecoder.decodeObject(forKey: "brand") as? AddProductSubcategory
         brandLocal = aDecoder.decodeObject(forKey: "brand_local") as? String
         category = aDecoder.decodeObject(forKey: "category") as? AnyObject
         categoryLocal = aDecoder.decodeObject(forKey: "category_local") as? String
         city = aDecoder.decodeObject(forKey: "city") as? String
         con = aDecoder.decodeObject(forKey: "con") as? AnyObject
         conditionLocal = aDecoder.decodeObject(forKey: "condition_local") as? String
         createdAt = aDecoder.decodeObject(forKey: "created_at") as? AddProductCreatedAt
         deletedAt = aDecoder.decodeObject(forKey: "deletedAt") as? AnyObject
         descriptionField = aDecoder.decodeObject(forKey: "description") as? String
         flatRatePackagingFee = aDecoder.decodeObject(forKey: "flat_rate_packaging_fee") as? String
         id = aDecoder.decodeObject(forKey: "id") as? Int
         image = aDecoder.decodeObject(forKey: "image") as? String
         isTouched = aDecoder.decodeObject(forKey: "is_touched") as? Int
         itemTypeLocal = aDecoder.decodeObject(forKey: "item_type_local") as? String
         localPickupAvailable = aDecoder.decodeObject(forKey: "local_pickup_available") as? Bool
         location = aDecoder.decodeObject(forKey: "location") as? String
         name = aDecoder.decodeObject(forKey: "name") as? String
         note = aDecoder.decodeObject(forKey: "note") as? String
         petFree = aDecoder.decodeObject(forKey: "pet_free") as? String
         pickUpLocation = aDecoder.decodeObject(forKey: "pick_up_location") as? AddProductPickupLocation
         price = aDecoder.decodeObject(forKey: "price") as? String
         productCategory = aDecoder.decodeObject(forKey :"product_category") as? [AddProductSubcategory]
         productCollection = aDecoder.decodeObject(forKey: "product_collection") as? [AnyObject]
         productColor = aDecoder.decodeObject(forKey :"product_color") as? [AddProductSubcategory]
         productCon = aDecoder.decodeObject(forKey :"product_con") as? [AddProductSubcategory]
         productLook = aDecoder.decodeObject(forKey: "product_look") as? [AnyObject]
         productMaterials = aDecoder.decodeObject(forKey :"product_materials") as? [AddProductSubcategory]
         productPendingImages = aDecoder.decodeObject(forKey :"product_pending_images") as? [AddProductProductPendingImage]
         productRoom = aDecoder.decodeObject(forKey: "product_room") as? [AnyObject]
         quantity = aDecoder.decodeObject(forKey: "quantity") as? String
         sellerFirstname = aDecoder.decodeObject(forKey: "seller_firstname") as? String
         sellerLastname = aDecoder.decodeObject(forKey: "seller_lastname") as? String
         sellerid = aDecoder.decodeObject(forKey: "sellerid") as? AddProductSellerid
         shipCat = aDecoder.decodeObject(forKey: "ship_cat") as? String
         shipMaterial = aDecoder.decodeObject(forKey: "ship_material") as? Bool
         shipSize = aDecoder.decodeObject(forKey: "ship_size") as? String
         sku = aDecoder.decodeObject(forKey: "sku") as? String
         state = aDecoder.decodeObject(forKey: "state") as? String
         tlvPrice = aDecoder.decodeObject(forKey: "tlv_price") as? String
         tlvSuggestedPriceMax = aDecoder.decodeObject(forKey: "tlv_suggested_price_max") as? String
         tlvSuggestedPriceMin = aDecoder.decodeObject(forKey: "tlv_suggested_price_min") as? String
         updatedAt = aDecoder.decodeObject(forKey: "updated_at") as? AddProductCreatedAt
         wpImageUrl = aDecoder.decodeObject(forKey: "wp_image_url") as? String
         wpProductId = aDecoder.decodeObject(forKey: "wp_product_id") as? String

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
		if approvedDate != nil{
			aCoder.encode(approvedDate, forKey: "approved_date")
		}
		if brand != nil{
			aCoder.encode(brand, forKey: "brand")
		}
		if brandLocal != nil{
			aCoder.encode(brandLocal, forKey: "brand_local")
		}
		if category != nil{
			aCoder.encode(category, forKey: "category")
		}
		if categoryLocal != nil{
			aCoder.encode(categoryLocal, forKey: "category_local")
		}
		if city != nil{
			aCoder.encode(city, forKey: "city")
		}
		if con != nil{
			aCoder.encode(con, forKey: "con")
		}
		if conditionLocal != nil{
			aCoder.encode(conditionLocal, forKey: "condition_local")
		}
		if createdAt != nil{
			aCoder.encode(createdAt, forKey: "created_at")
		}
		if deletedAt != nil{
			aCoder.encode(deletedAt, forKey: "deletedAt")
		}
		if descriptionField != nil{
			aCoder.encode(descriptionField, forKey: "description")
		}
		if flatRatePackagingFee != nil{
			aCoder.encode(flatRatePackagingFee, forKey: "flat_rate_packaging_fee")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if image != nil{
			aCoder.encode(image, forKey: "image")
		}
		if isTouched != nil{
			aCoder.encode(isTouched, forKey: "is_touched")
		}
		if itemTypeLocal != nil{
			aCoder.encode(itemTypeLocal, forKey: "item_type_local")
		}
		if localPickupAvailable != nil{
			aCoder.encode(localPickupAvailable, forKey: "local_pickup_available")
		}
		if location != nil{
			aCoder.encode(location, forKey: "location")
		}
		if name != nil{
			aCoder.encode(name, forKey: "name")
		}
		if note != nil{
			aCoder.encode(note, forKey: "note")
		}
		if petFree != nil{
			aCoder.encode(petFree, forKey: "pet_free")
		}
		if pickUpLocation != nil{
			aCoder.encode(pickUpLocation, forKey: "pick_up_location")
		}
		if price != nil{
			aCoder.encode(price, forKey: "price")
		}
		if productCategory != nil{
			aCoder.encode(productCategory, forKey: "product_category")
		}
		if productCollection != nil{
			aCoder.encode(productCollection, forKey: "product_collection")
		}
		if productColor != nil{
			aCoder.encode(productColor, forKey: "product_color")
		}
		if productCon != nil{
			aCoder.encode(productCon, forKey: "product_con")
		}
		if productLook != nil{
			aCoder.encode(productLook, forKey: "product_look")
		}
		if productMaterials != nil{
			aCoder.encode(productMaterials, forKey: "product_materials")
		}
		if productPendingImages != nil{
			aCoder.encode(productPendingImages, forKey: "product_pending_images")
		}
		if productRoom != nil{
			aCoder.encode(productRoom, forKey: "product_room")
		}
		if quantity != nil{
			aCoder.encode(quantity, forKey: "quantity")
		}
		if sellerFirstname != nil{
			aCoder.encode(sellerFirstname, forKey: "seller_firstname")
		}
		if sellerLastname != nil{
			aCoder.encode(sellerLastname, forKey: "seller_lastname")
		}
		if sellerid != nil{
			aCoder.encode(sellerid, forKey: "sellerid")
		}
		if shipCat != nil{
			aCoder.encode(shipCat, forKey: "ship_cat")
		}
		if shipMaterial != nil{
			aCoder.encode(shipMaterial, forKey: "ship_material")
		}
		if shipSize != nil{
			aCoder.encode(shipSize, forKey: "ship_size")
		}
		if sku != nil{
			aCoder.encode(sku, forKey: "sku")
		}
		if state != nil{
			aCoder.encode(state, forKey: "state")
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
		if updatedAt != nil{
			aCoder.encode(updatedAt, forKey: "updated_at")
		}
		if wpImageUrl != nil{
			aCoder.encode(wpImageUrl, forKey: "wp_image_url")
		}
		if wpProductId != nil{
			aCoder.encode(wpProductId, forKey: "wp_product_id")
		}

	}

}
