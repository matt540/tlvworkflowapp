//
//	AddProductSeller.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class AddProductSeller : NSObject, NSCoding{

	var address : String!
	var createdAt : AddProductCreatedAt!
	var deletedAt : AnyObject!
	var displayname : String!
	var email : String!
	var firstname : String!
	var id : Int!
	var inQueue : Int!
	var isSellerAgreement : Bool!
	var lastProductFileName : String!
	var lastProductFileNameBase : String!
	var lastProposalFileName : String!
	var lastProposalFileNameBase : String!
	var lastSku : Int!
	var lastname : String!
	var password : String!
	var phone : String!
	var sellerAgreementJson : AnyObject!
	var sellerAgreementPdf : AnyObject!
	var sellerAgreementSignature : AnyObject!
	var shopname : String!
	var shopurl : String!
	var stripeCustomerId : AnyObject!
	var updatedAt : AddProductCreatedAt!
	var wpSellerId : Int!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		address = dictionary["address"] as? String
		if let createdAtData = dictionary["created_at"] as? [String:Any]{
			createdAt = AddProductCreatedAt(fromDictionary: createdAtData)
		}
		deletedAt = dictionary["deletedAt"] as? AnyObject
		displayname = dictionary["displayname"] as? String
		email = dictionary["email"] as? String
		firstname = dictionary["firstname"] as? String
		id = dictionary["id"] as? Int
		inQueue = dictionary["in_queue"] as? Int
		isSellerAgreement = dictionary["is_seller_agreement"] as? Bool
		lastProductFileName = dictionary["last_product_file_name"] as? String
		lastProductFileNameBase = dictionary["last_product_file_name_base"] as? String
		lastProposalFileName = dictionary["last_proposal_file_name"] as? String
		lastProposalFileNameBase = dictionary["last_proposal_file_name_base"] as? String
		lastSku = dictionary["last_sku"] as? Int
		lastname = dictionary["lastname"] as? String
		password = dictionary["password"] as? String
		phone = dictionary["phone"] as? String
		sellerAgreementJson = dictionary["seller_agreement_json"] as? AnyObject
		sellerAgreementPdf = dictionary["seller_agreement_pdf"] as? AnyObject
		sellerAgreementSignature = dictionary["seller_agreement_signature"] as? AnyObject
		shopname = dictionary["shopname"] as? String
		shopurl = dictionary["shopurl"] as? String
		stripeCustomerId = dictionary["stripe_customer_id"] as? AnyObject
		if let updatedAtData = dictionary["updated_at"] as? [String:Any]{
			updatedAt = AddProductCreatedAt(fromDictionary: updatedAtData)
		}
		wpSellerId = dictionary["wp_seller_id"] as? Int
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
		if createdAt != nil{
			dictionary["created_at"] = createdAt.toDictionary()
		}
		if deletedAt != nil{
			dictionary["deletedAt"] = deletedAt
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
		if inQueue != nil{
			dictionary["in_queue"] = inQueue
		}
		if isSellerAgreement != nil{
			dictionary["is_seller_agreement"] = isSellerAgreement
		}
		if lastProductFileName != nil{
			dictionary["last_product_file_name"] = lastProductFileName
		}
		if lastProductFileNameBase != nil{
			dictionary["last_product_file_name_base"] = lastProductFileNameBase
		}
		if lastProposalFileName != nil{
			dictionary["last_proposal_file_name"] = lastProposalFileName
		}
		if lastProposalFileNameBase != nil{
			dictionary["last_proposal_file_name_base"] = lastProposalFileNameBase
		}
		if lastSku != nil{
			dictionary["last_sku"] = lastSku
		}
		if lastname != nil{
			dictionary["lastname"] = lastname
		}
		if password != nil{
			dictionary["password"] = password
		}
		if phone != nil{
			dictionary["phone"] = phone
		}
		if sellerAgreementJson != nil{
			dictionary["seller_agreement_json"] = sellerAgreementJson
		}
		if sellerAgreementPdf != nil{
			dictionary["seller_agreement_pdf"] = sellerAgreementPdf
		}
		if sellerAgreementSignature != nil{
			dictionary["seller_agreement_signature"] = sellerAgreementSignature
		}
		if shopname != nil{
			dictionary["shopname"] = shopname
		}
		if shopurl != nil{
			dictionary["shopurl"] = shopurl
		}
		if stripeCustomerId != nil{
			dictionary["stripe_customer_id"] = stripeCustomerId
		}
		if updatedAt != nil{
			dictionary["updated_at"] = updatedAt.toDictionary()
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
         address = aDecoder.decodeObject(forKey: "address") as? String
         createdAt = aDecoder.decodeObject(forKey: "created_at") as? AddProductCreatedAt
         deletedAt = aDecoder.decodeObject(forKey: "deletedAt") as? AnyObject
         displayname = aDecoder.decodeObject(forKey: "displayname") as? String
         email = aDecoder.decodeObject(forKey: "email") as? String
         firstname = aDecoder.decodeObject(forKey: "firstname") as? String
         id = aDecoder.decodeObject(forKey: "id") as? Int
         inQueue = aDecoder.decodeObject(forKey: "in_queue") as? Int
         isSellerAgreement = aDecoder.decodeObject(forKey: "is_seller_agreement") as? Bool
         lastProductFileName = aDecoder.decodeObject(forKey: "last_product_file_name") as? String
         lastProductFileNameBase = aDecoder.decodeObject(forKey: "last_product_file_name_base") as? String
         lastProposalFileName = aDecoder.decodeObject(forKey: "last_proposal_file_name") as? String
         lastProposalFileNameBase = aDecoder.decodeObject(forKey: "last_proposal_file_name_base") as? String
         lastSku = aDecoder.decodeObject(forKey: "last_sku") as? Int
         lastname = aDecoder.decodeObject(forKey: "lastname") as? String
         password = aDecoder.decodeObject(forKey: "password") as? String
         phone = aDecoder.decodeObject(forKey: "phone") as? String
         sellerAgreementJson = aDecoder.decodeObject(forKey: "seller_agreement_json") as? AnyObject
         sellerAgreementPdf = aDecoder.decodeObject(forKey: "seller_agreement_pdf") as? AnyObject
         sellerAgreementSignature = aDecoder.decodeObject(forKey: "seller_agreement_signature") as? AnyObject
         shopname = aDecoder.decodeObject(forKey: "shopname") as? String
         shopurl = aDecoder.decodeObject(forKey: "shopurl") as? String
         stripeCustomerId = aDecoder.decodeObject(forKey: "stripe_customer_id") as? AnyObject
         updatedAt = aDecoder.decodeObject(forKey: "updated_at") as? AddProductCreatedAt
         wpSellerId = aDecoder.decodeObject(forKey: "wp_seller_id") as? Int

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
		if createdAt != nil{
			aCoder.encode(createdAt, forKey: "created_at")
		}
		if deletedAt != nil{
			aCoder.encode(deletedAt, forKey: "deletedAt")
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
		if inQueue != nil{
			aCoder.encode(inQueue, forKey: "in_queue")
		}
		if isSellerAgreement != nil{
			aCoder.encode(isSellerAgreement, forKey: "is_seller_agreement")
		}
		if lastProductFileName != nil{
			aCoder.encode(lastProductFileName, forKey: "last_product_file_name")
		}
		if lastProductFileNameBase != nil{
			aCoder.encode(lastProductFileNameBase, forKey: "last_product_file_name_base")
		}
		if lastProposalFileName != nil{
			aCoder.encode(lastProposalFileName, forKey: "last_proposal_file_name")
		}
		if lastProposalFileNameBase != nil{
			aCoder.encode(lastProposalFileNameBase, forKey: "last_proposal_file_name_base")
		}
		if lastSku != nil{
			aCoder.encode(lastSku, forKey: "last_sku")
		}
		if lastname != nil{
			aCoder.encode(lastname, forKey: "lastname")
		}
		if password != nil{
			aCoder.encode(password, forKey: "password")
		}
		if phone != nil{
			aCoder.encode(phone, forKey: "phone")
		}
		if sellerAgreementJson != nil{
			aCoder.encode(sellerAgreementJson, forKey: "seller_agreement_json")
		}
		if sellerAgreementPdf != nil{
			aCoder.encode(sellerAgreementPdf, forKey: "seller_agreement_pdf")
		}
		if sellerAgreementSignature != nil{
			aCoder.encode(sellerAgreementSignature, forKey: "seller_agreement_signature")
		}
		if shopname != nil{
			aCoder.encode(shopname, forKey: "shopname")
		}
		if shopurl != nil{
			aCoder.encode(shopurl, forKey: "shopurl")
		}
		if stripeCustomerId != nil{
			aCoder.encode(stripeCustomerId, forKey: "stripe_customer_id")
		}
		if updatedAt != nil{
			aCoder.encode(updatedAt, forKey: "updated_at")
		}
		if wpSellerId != nil{
			aCoder.encode(wpSellerId, forKey: "wp_seller_id")
		}

	}

}