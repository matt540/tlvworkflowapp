//
//	LoginData.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class LoginData : NSObject, NSCoding{

	var createdAt : LoginCreatedAt!
	var deletedAt : String!
	var email : String!
	var firstname : String!
	var id : Int!
	var lastname : String!
	var otherPassword : String!
	var password : String!
	var phone : String!
	var profileImage : String!
	var rememberToken : String!
	var roles : [LoginRole]!
	var updatedAt : LoginCreatedAt!
	var username : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		if let createdAtData = dictionary["created_at"] as? [String:Any]{
			createdAt = LoginCreatedAt(fromDictionary: createdAtData)
		}
		deletedAt = dictionary["deletedAt"] as? String
		email = dictionary["email"] as? String
		firstname = dictionary["firstname"] as? String
		id = dictionary["id"] as? Int
		lastname = dictionary["lastname"] as? String
		otherPassword = dictionary["other_password"] as? String
		password = dictionary["password"] as? String
		phone = dictionary["phone"] as? String
		profileImage = dictionary["profile_image"] as? String
		rememberToken = dictionary["remember_token"] as? String
		roles = [LoginRole]()
		if let rolesArray = dictionary["roles"] as? [[String:Any]]{
			for dic in rolesArray{
				let value = LoginRole(fromDictionary: dic)
				roles.append(value)
			}
		}
		if let updatedAtData = dictionary["updated_at"] as? [String:Any]{
			updatedAt = LoginCreatedAt(fromDictionary: updatedAtData)
		}
		username = dictionary["username"] as? String
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
		if otherPassword != nil{
			dictionary["other_password"] = otherPassword
		}
		if password != nil{
			dictionary["password"] = password
		}
		if phone != nil{
			dictionary["phone"] = phone
		}
		if profileImage != nil{
			dictionary["profile_image"] = profileImage
		}
		if rememberToken != nil{
			dictionary["remember_token"] = rememberToken
		}
		if roles != nil{
			var dictionaryElements = [[String:Any]]()
			for rolesElement in roles {
				dictionaryElements.append(rolesElement.toDictionary())
			}
			dictionary["roles"] = dictionaryElements
		}
		if updatedAt != nil{
			dictionary["updated_at"] = updatedAt.toDictionary()
		}
		if username != nil{
			dictionary["username"] = username
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         createdAt = aDecoder.decodeObject(forKey: "created_at") as? LoginCreatedAt
         deletedAt = aDecoder.decodeObject(forKey: "deletedAt") as? String
         email = aDecoder.decodeObject(forKey: "email") as? String
         firstname = aDecoder.decodeObject(forKey: "firstname") as? String
         id = aDecoder.decodeObject(forKey: "id") as? Int
         lastname = aDecoder.decodeObject(forKey: "lastname") as? String
         otherPassword = aDecoder.decodeObject(forKey: "other_password") as? String
         password = aDecoder.decodeObject(forKey: "password") as? String
         phone = aDecoder.decodeObject(forKey: "phone") as? String
         profileImage = aDecoder.decodeObject(forKey: "profile_image") as? String
         rememberToken = aDecoder.decodeObject(forKey: "remember_token") as? String
         roles = aDecoder.decodeObject(forKey :"roles") as? [LoginRole]
         updatedAt = aDecoder.decodeObject(forKey: "updated_at") as? LoginCreatedAt
         username = aDecoder.decodeObject(forKey: "username") as? String

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
		if otherPassword != nil{
			aCoder.encode(otherPassword, forKey: "other_password")
		}
		if password != nil{
			aCoder.encode(password, forKey: "password")
		}
		if phone != nil{
			aCoder.encode(phone, forKey: "phone")
		}
		if profileImage != nil{
			aCoder.encode(profileImage, forKey: "profile_image")
		}
		if rememberToken != nil{
			aCoder.encode(rememberToken, forKey: "remember_token")
		}
		if roles != nil{
			aCoder.encode(roles, forKey: "roles")
		}
		if updatedAt != nil{
			aCoder.encode(updatedAt, forKey: "updated_at")
		}
		if username != nil{
			aCoder.encode(username, forKey: "username")
		}

	}

}
