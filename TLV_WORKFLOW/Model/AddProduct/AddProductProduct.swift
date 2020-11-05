//
//	AddProductProduct.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class AddProductProduct : NSObject, NSCoding{

	var approvedCreatedAt : AnyObject!
	var armHeight : String!
	var commission : String!
	var conditionNote : String!
	var copyrightCreatedAt : AnyObject!
	var createdAt : AddProductCreatedAt!
	var curatorCommission : String!
	var curatorName : String!
	var deletedAt : AnyObject!
	var deliveryDescription : String!
	var deliveryOption : String!
	var depth : String!
	var dimensionDescription : String!
	var dimensions : String!
	var forAwaitingContractCreatedAt : AnyObject!
	var forPricingCreatedAt : AnyObject!
	var forProductionCreatedAt : AnyObject!
	var forProposalForProductionCreatedAt : AnyObject!
	var height : String!
	var id : Int!
	var imagesFrom : Int!
	var inQueue : String!
	var isArchived : Int!
	var isAwaitingContract : Int!
	var isCopyright : Int!
	var isProductForPricing : Int!
	var isProductForProduction : Int!
	var isProposalForProduction : Int!
	var isScheduled : String!
	var isSendMail : String!
	var isStorageProposal : Int!
	var isUpdatedDetails : Int!
	var length : String!
	var manageStock : String!
	var menuOrder : String!
	var note : String!
	var price : String!
	var productId : AddProductProductId!
	var quantity : String!
	var rejectToAuction : Int!
	var seatHeight : String!
	var shippingClass : String!
	var sortDescription : String!
	var stockStatus : String!
	var storagePricing : String!
	var stripePlanId : String!
	var stripeSubscriptionsId : String!
	var taxClass : String!
	var taxStatus : String!
	var tlvPrice : String!
	var tlvSuggestedPrice : String!
	var tlvSuggestedPriceMax : String!
	var tlvSuggestedPriceMin : String!
	var units : String!
	var updatedAt : AddProductCreatedAt!
	var weight : String!
	var width : String!
	var wpProductId : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		approvedCreatedAt = dictionary["approved_created_at"] as? AnyObject
		armHeight = dictionary["arm_height"] as? String
		commission = dictionary["commission"] as? String
		conditionNote = dictionary["condition_note"] as? String
		copyrightCreatedAt = dictionary["copyright_created_at"] as? AnyObject
		if let createdAtData = dictionary["created_at"] as? [String:Any]{
			createdAt = AddProductCreatedAt(fromDictionary: createdAtData)
		}
		curatorCommission = dictionary["curator_commission"] as? String
		curatorName = dictionary["curator_name"] as? String
		deletedAt = dictionary["deletedAt"] as? AnyObject
		deliveryDescription = dictionary["delivery_description"] as? String
		deliveryOption = dictionary["delivery_option"] as? String
		depth = dictionary["depth"] as? String
		dimensionDescription = dictionary["dimension_description"] as? String
		dimensions = dictionary["dimensions"] as? String
		forAwaitingContractCreatedAt = dictionary["for_awaiting_contract_created_at"] as? AnyObject
		forPricingCreatedAt = dictionary["for_pricing_created_at"] as? AnyObject
		forProductionCreatedAt = dictionary["for_production_created_at"] as? AnyObject
		forProposalForProductionCreatedAt = dictionary["for_proposal_for_production_created_at"] as? AnyObject
		height = dictionary["height"] as? String
		id = dictionary["id"] as? Int
		imagesFrom = dictionary["images_from"] as? Int
		inQueue = dictionary["in_queue"] as? String
		isArchived = dictionary["is_archived"] as? Int
		isAwaitingContract = dictionary["is_awaiting_contract"] as? Int
		isCopyright = dictionary["is_copyright"] as? Int
		isProductForPricing = dictionary["is_product_for_pricing"] as? Int
		isProductForProduction = dictionary["is_product_for_production"] as? Int
		isProposalForProduction = dictionary["is_proposal_for_production"] as? Int
		isScheduled = dictionary["is_scheduled"] as? String
		isSendMail = dictionary["is_send_mail"] as? String
		isStorageProposal = dictionary["is_storage_proposal"] as? Int
		isUpdatedDetails = dictionary["is_updated_details"] as? Int
		length = dictionary["length"] as? String
		manageStock = dictionary["manage_stock"] as? String
		menuOrder = dictionary["menu_order"] as? String
		note = dictionary["note"] as? String
		price = dictionary["price"] as? String
		if let productIdData = dictionary["product_id"] as? [String:Any]{
			productId = AddProductProductId(fromDictionary: productIdData)
		}
		quantity = dictionary["quantity"] as? String
		rejectToAuction = dictionary["reject_to_auction"] as? Int
		seatHeight = dictionary["seat_height"] as? String
		shippingClass = dictionary["shipping_class"] as? String
		sortDescription = dictionary["sort_description"] as? String
		stockStatus = dictionary["stock_status"] as? String
		storagePricing = dictionary["storage_pricing"] as? String
		stripePlanId = dictionary["stripe_plan_id"] as? String
		stripeSubscriptionsId = dictionary["stripe_subscriptions_id"] as? String
		taxClass = dictionary["tax_class"] as? String
		taxStatus = dictionary["tax_status"] as? String
		tlvPrice = dictionary["tlv_price"] as? String
		tlvSuggestedPrice = dictionary["tlv_suggested_price"] as? String
		tlvSuggestedPriceMax = dictionary["tlv_suggested_price_max"] as? String
		tlvSuggestedPriceMin = dictionary["tlv_suggested_price_min"] as? String
		units = dictionary["units"] as? String
		if let updatedAtData = dictionary["updated_at"] as? [String:Any]{
			updatedAt = AddProductCreatedAt(fromDictionary: updatedAtData)
		}
		weight = dictionary["weight"] as? String
		width = dictionary["width"] as? String
		wpProductId = dictionary["wp_product_id"] as? String
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
		if armHeight != nil{
			dictionary["arm_height"] = armHeight
		}
		if commission != nil{
			dictionary["commission"] = commission
		}
		if conditionNote != nil{
			dictionary["condition_note"] = conditionNote
		}
		if copyrightCreatedAt != nil{
			dictionary["copyright_created_at"] = copyrightCreatedAt
		}
		if createdAt != nil{
			dictionary["created_at"] = createdAt.toDictionary()
		}
		if curatorCommission != nil{
			dictionary["curator_commission"] = curatorCommission
		}
		if curatorName != nil{
			dictionary["curator_name"] = curatorName
		}
		if deletedAt != nil{
			dictionary["deletedAt"] = deletedAt
		}
		if deliveryDescription != nil{
			dictionary["delivery_description"] = deliveryDescription
		}
		if deliveryOption != nil{
			dictionary["delivery_option"] = deliveryOption
		}
		if depth != nil{
			dictionary["depth"] = depth
		}
		if dimensionDescription != nil{
			dictionary["dimension_description"] = dimensionDescription
		}
		if dimensions != nil{
			dictionary["dimensions"] = dimensions
		}
		if forAwaitingContractCreatedAt != nil{
			dictionary["for_awaiting_contract_created_at"] = forAwaitingContractCreatedAt
		}
		if forPricingCreatedAt != nil{
			dictionary["for_pricing_created_at"] = forPricingCreatedAt
		}
		if forProductionCreatedAt != nil{
			dictionary["for_production_created_at"] = forProductionCreatedAt
		}
		if forProposalForProductionCreatedAt != nil{
			dictionary["for_proposal_for_production_created_at"] = forProposalForProductionCreatedAt
		}
		if height != nil{
			dictionary["height"] = height
		}
		if id != nil{
			dictionary["id"] = id
		}
		if imagesFrom != nil{
			dictionary["images_from"] = imagesFrom
		}
		if inQueue != nil{
			dictionary["in_queue"] = inQueue
		}
		if isArchived != nil{
			dictionary["is_archived"] = isArchived
		}
		if isAwaitingContract != nil{
			dictionary["is_awaiting_contract"] = isAwaitingContract
		}
		if isCopyright != nil{
			dictionary["is_copyright"] = isCopyright
		}
		if isProductForPricing != nil{
			dictionary["is_product_for_pricing"] = isProductForPricing
		}
		if isProductForProduction != nil{
			dictionary["is_product_for_production"] = isProductForProduction
		}
		if isProposalForProduction != nil{
			dictionary["is_proposal_for_production"] = isProposalForProduction
		}
		if isScheduled != nil{
			dictionary["is_scheduled"] = isScheduled
		}
		if isSendMail != nil{
			dictionary["is_send_mail"] = isSendMail
		}
		if isStorageProposal != nil{
			dictionary["is_storage_proposal"] = isStorageProposal
		}
		if isUpdatedDetails != nil{
			dictionary["is_updated_details"] = isUpdatedDetails
		}
		if length != nil{
			dictionary["length"] = length
		}
		if manageStock != nil{
			dictionary["manage_stock"] = manageStock
		}
		if menuOrder != nil{
			dictionary["menu_order"] = menuOrder
		}
		if note != nil{
			dictionary["note"] = note
		}
		if price != nil{
			dictionary["price"] = price
		}
		if productId != nil{
			dictionary["product_id"] = productId.toDictionary()
		}
		if quantity != nil{
			dictionary["quantity"] = quantity
		}
		if rejectToAuction != nil{
			dictionary["reject_to_auction"] = rejectToAuction
		}
		if seatHeight != nil{
			dictionary["seat_height"] = seatHeight
		}
		if shippingClass != nil{
			dictionary["shipping_class"] = shippingClass
		}
		if sortDescription != nil{
			dictionary["sort_description"] = sortDescription
		}
		if stockStatus != nil{
			dictionary["stock_status"] = stockStatus
		}
		if storagePricing != nil{
			dictionary["storage_pricing"] = storagePricing
		}
		if stripePlanId != nil{
			dictionary["stripe_plan_id"] = stripePlanId
		}
		if stripeSubscriptionsId != nil{
			dictionary["stripe_subscriptions_id"] = stripeSubscriptionsId
		}
		if taxClass != nil{
			dictionary["tax_class"] = taxClass
		}
		if taxStatus != nil{
			dictionary["tax_status"] = taxStatus
		}
		if tlvPrice != nil{
			dictionary["tlv_price"] = tlvPrice
		}
		if tlvSuggestedPrice != nil{
			dictionary["tlv_suggested_price"] = tlvSuggestedPrice
		}
		if tlvSuggestedPriceMax != nil{
			dictionary["tlv_suggested_price_max"] = tlvSuggestedPriceMax
		}
		if tlvSuggestedPriceMin != nil{
			dictionary["tlv_suggested_price_min"] = tlvSuggestedPriceMin
		}
		if units != nil{
			dictionary["units"] = units
		}
		if updatedAt != nil{
			dictionary["updated_at"] = updatedAt.toDictionary()
		}
		if weight != nil{
			dictionary["weight"] = weight
		}
		if width != nil{
			dictionary["width"] = width
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
         approvedCreatedAt = aDecoder.decodeObject(forKey: "approved_created_at") as? AnyObject
         armHeight = aDecoder.decodeObject(forKey: "arm_height") as? String
         commission = aDecoder.decodeObject(forKey: "commission") as? String
         conditionNote = aDecoder.decodeObject(forKey: "condition_note") as? String
         copyrightCreatedAt = aDecoder.decodeObject(forKey: "copyright_created_at") as? AnyObject
         createdAt = aDecoder.decodeObject(forKey: "created_at") as? AddProductCreatedAt
         curatorCommission = aDecoder.decodeObject(forKey: "curator_commission") as? String
         curatorName = aDecoder.decodeObject(forKey: "curator_name") as? String
         deletedAt = aDecoder.decodeObject(forKey: "deletedAt") as? AnyObject
         deliveryDescription = aDecoder.decodeObject(forKey: "delivery_description") as? String
         deliveryOption = aDecoder.decodeObject(forKey: "delivery_option") as? String
         depth = aDecoder.decodeObject(forKey: "depth") as? String
         dimensionDescription = aDecoder.decodeObject(forKey: "dimension_description") as? String
         dimensions = aDecoder.decodeObject(forKey: "dimensions") as? String
         forAwaitingContractCreatedAt = aDecoder.decodeObject(forKey: "for_awaiting_contract_created_at") as? AnyObject
         forPricingCreatedAt = aDecoder.decodeObject(forKey: "for_pricing_created_at") as? AnyObject
         forProductionCreatedAt = aDecoder.decodeObject(forKey: "for_production_created_at") as? AnyObject
         forProposalForProductionCreatedAt = aDecoder.decodeObject(forKey: "for_proposal_for_production_created_at") as? AnyObject
         height = aDecoder.decodeObject(forKey: "height") as? String
         id = aDecoder.decodeObject(forKey: "id") as? Int
         imagesFrom = aDecoder.decodeObject(forKey: "images_from") as? Int
         inQueue = aDecoder.decodeObject(forKey: "in_queue") as? String
         isArchived = aDecoder.decodeObject(forKey: "is_archived") as? Int
         isAwaitingContract = aDecoder.decodeObject(forKey: "is_awaiting_contract") as? Int
         isCopyright = aDecoder.decodeObject(forKey: "is_copyright") as? Int
         isProductForPricing = aDecoder.decodeObject(forKey: "is_product_for_pricing") as? Int
         isProductForProduction = aDecoder.decodeObject(forKey: "is_product_for_production") as? Int
         isProposalForProduction = aDecoder.decodeObject(forKey: "is_proposal_for_production") as? Int
         isScheduled = aDecoder.decodeObject(forKey: "is_scheduled") as? String
         isSendMail = aDecoder.decodeObject(forKey: "is_send_mail") as? String
         isStorageProposal = aDecoder.decodeObject(forKey: "is_storage_proposal") as? Int
         isUpdatedDetails = aDecoder.decodeObject(forKey: "is_updated_details") as? Int
         length = aDecoder.decodeObject(forKey: "length") as? String
         manageStock = aDecoder.decodeObject(forKey: "manage_stock") as? String
         menuOrder = aDecoder.decodeObject(forKey: "menu_order") as? String
         note = aDecoder.decodeObject(forKey: "note") as? String
         price = aDecoder.decodeObject(forKey: "price") as? String
         productId = aDecoder.decodeObject(forKey: "product_id") as? AddProductProductId
         quantity = aDecoder.decodeObject(forKey: "quantity") as? String
         rejectToAuction = aDecoder.decodeObject(forKey: "reject_to_auction") as? Int
         seatHeight = aDecoder.decodeObject(forKey: "seat_height") as? String
         shippingClass = aDecoder.decodeObject(forKey: "shipping_class") as? String
         sortDescription = aDecoder.decodeObject(forKey: "sort_description") as? String
         stockStatus = aDecoder.decodeObject(forKey: "stock_status") as? String
         storagePricing = aDecoder.decodeObject(forKey: "storage_pricing") as? String
         stripePlanId = aDecoder.decodeObject(forKey: "stripe_plan_id") as? String
         stripeSubscriptionsId = aDecoder.decodeObject(forKey: "stripe_subscriptions_id") as? String
         taxClass = aDecoder.decodeObject(forKey: "tax_class") as? String
         taxStatus = aDecoder.decodeObject(forKey: "tax_status") as? String
         tlvPrice = aDecoder.decodeObject(forKey: "tlv_price") as? String
         tlvSuggestedPrice = aDecoder.decodeObject(forKey: "tlv_suggested_price") as? String
         tlvSuggestedPriceMax = aDecoder.decodeObject(forKey: "tlv_suggested_price_max") as? String
         tlvSuggestedPriceMin = aDecoder.decodeObject(forKey: "tlv_suggested_price_min") as? String
         units = aDecoder.decodeObject(forKey: "units") as? String
         updatedAt = aDecoder.decodeObject(forKey: "updated_at") as? AddProductCreatedAt
         weight = aDecoder.decodeObject(forKey: "weight") as? String
         width = aDecoder.decodeObject(forKey: "width") as? String
         wpProductId = aDecoder.decodeObject(forKey: "wp_product_id") as? String

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
		if armHeight != nil{
			aCoder.encode(armHeight, forKey: "arm_height")
		}
		if commission != nil{
			aCoder.encode(commission, forKey: "commission")
		}
		if conditionNote != nil{
			aCoder.encode(conditionNote, forKey: "condition_note")
		}
		if copyrightCreatedAt != nil{
			aCoder.encode(copyrightCreatedAt, forKey: "copyright_created_at")
		}
		if createdAt != nil{
			aCoder.encode(createdAt, forKey: "created_at")
		}
		if curatorCommission != nil{
			aCoder.encode(curatorCommission, forKey: "curator_commission")
		}
		if curatorName != nil{
			aCoder.encode(curatorName, forKey: "curator_name")
		}
		if deletedAt != nil{
			aCoder.encode(deletedAt, forKey: "deletedAt")
		}
		if deliveryDescription != nil{
			aCoder.encode(deliveryDescription, forKey: "delivery_description")
		}
		if deliveryOption != nil{
			aCoder.encode(deliveryOption, forKey: "delivery_option")
		}
		if depth != nil{
			aCoder.encode(depth, forKey: "depth")
		}
		if dimensionDescription != nil{
			aCoder.encode(dimensionDescription, forKey: "dimension_description")
		}
		if dimensions != nil{
			aCoder.encode(dimensions, forKey: "dimensions")
		}
		if forAwaitingContractCreatedAt != nil{
			aCoder.encode(forAwaitingContractCreatedAt, forKey: "for_awaiting_contract_created_at")
		}
		if forPricingCreatedAt != nil{
			aCoder.encode(forPricingCreatedAt, forKey: "for_pricing_created_at")
		}
		if forProductionCreatedAt != nil{
			aCoder.encode(forProductionCreatedAt, forKey: "for_production_created_at")
		}
		if forProposalForProductionCreatedAt != nil{
			aCoder.encode(forProposalForProductionCreatedAt, forKey: "for_proposal_for_production_created_at")
		}
		if height != nil{
			aCoder.encode(height, forKey: "height")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if imagesFrom != nil{
			aCoder.encode(imagesFrom, forKey: "images_from")
		}
		if inQueue != nil{
			aCoder.encode(inQueue, forKey: "in_queue")
		}
		if isArchived != nil{
			aCoder.encode(isArchived, forKey: "is_archived")
		}
		if isAwaitingContract != nil{
			aCoder.encode(isAwaitingContract, forKey: "is_awaiting_contract")
		}
		if isCopyright != nil{
			aCoder.encode(isCopyright, forKey: "is_copyright")
		}
		if isProductForPricing != nil{
			aCoder.encode(isProductForPricing, forKey: "is_product_for_pricing")
		}
		if isProductForProduction != nil{
			aCoder.encode(isProductForProduction, forKey: "is_product_for_production")
		}
		if isProposalForProduction != nil{
			aCoder.encode(isProposalForProduction, forKey: "is_proposal_for_production")
		}
		if isScheduled != nil{
			aCoder.encode(isScheduled, forKey: "is_scheduled")
		}
		if isSendMail != nil{
			aCoder.encode(isSendMail, forKey: "is_send_mail")
		}
		if isStorageProposal != nil{
			aCoder.encode(isStorageProposal, forKey: "is_storage_proposal")
		}
		if isUpdatedDetails != nil{
			aCoder.encode(isUpdatedDetails, forKey: "is_updated_details")
		}
		if length != nil{
			aCoder.encode(length, forKey: "length")
		}
		if manageStock != nil{
			aCoder.encode(manageStock, forKey: "manage_stock")
		}
		if menuOrder != nil{
			aCoder.encode(menuOrder, forKey: "menu_order")
		}
		if note != nil{
			aCoder.encode(note, forKey: "note")
		}
		if price != nil{
			aCoder.encode(price, forKey: "price")
		}
		if productId != nil{
			aCoder.encode(productId, forKey: "product_id")
		}
		if quantity != nil{
			aCoder.encode(quantity, forKey: "quantity")
		}
		if rejectToAuction != nil{
			aCoder.encode(rejectToAuction, forKey: "reject_to_auction")
		}
		if seatHeight != nil{
			aCoder.encode(seatHeight, forKey: "seat_height")
		}
		if shippingClass != nil{
			aCoder.encode(shippingClass, forKey: "shipping_class")
		}
		if sortDescription != nil{
			aCoder.encode(sortDescription, forKey: "sort_description")
		}
		if stockStatus != nil{
			aCoder.encode(stockStatus, forKey: "stock_status")
		}
		if storagePricing != nil{
			aCoder.encode(storagePricing, forKey: "storage_pricing")
		}
		if stripePlanId != nil{
			aCoder.encode(stripePlanId, forKey: "stripe_plan_id")
		}
		if stripeSubscriptionsId != nil{
			aCoder.encode(stripeSubscriptionsId, forKey: "stripe_subscriptions_id")
		}
		if taxClass != nil{
			aCoder.encode(taxClass, forKey: "tax_class")
		}
		if taxStatus != nil{
			aCoder.encode(taxStatus, forKey: "tax_status")
		}
		if tlvPrice != nil{
			aCoder.encode(tlvPrice, forKey: "tlv_price")
		}
		if tlvSuggestedPrice != nil{
			aCoder.encode(tlvSuggestedPrice, forKey: "tlv_suggested_price")
		}
		if tlvSuggestedPriceMax != nil{
			aCoder.encode(tlvSuggestedPriceMax, forKey: "tlv_suggested_price_max")
		}
		if tlvSuggestedPriceMin != nil{
			aCoder.encode(tlvSuggestedPriceMin, forKey: "tlv_suggested_price_min")
		}
		if units != nil{
			aCoder.encode(units, forKey: "units")
		}
		if updatedAt != nil{
			aCoder.encode(updatedAt, forKey: "updated_at")
		}
		if weight != nil{
			aCoder.encode(weight, forKey: "weight")
		}
		if width != nil{
			aCoder.encode(width, forKey: "width")
		}
		if wpProductId != nil{
			aCoder.encode(wpProductId, forKey: "wp_product_id")
		}

	}

}