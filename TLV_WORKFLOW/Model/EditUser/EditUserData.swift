//
//	EditUserData.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class EditUserData : NSObject, NSCoding{

	var email : String!
	var firstname : String!
	var id : Int!
	var key : String!
	var lastname : String!
	var otherPassword : String!
	var phone : String!
	var profileImage : String!
    var roles : [LoginRole]!

	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		email = dictionary["email"] as? String
		firstname = dictionary["firstname"] as? String
        if ((dictionary["id"] as? String) != nil){
            id = dictionary["id"].int()
        }else{
            id = dictionary["id"] as? Int
        }
		key = dictionary["key"] as? String
		lastname = dictionary["lastname"] as? String
		otherPassword = dictionary["other_password"] as? String
		phone = dictionary["phone"] as? String
		profileImage = dictionary["profile_image"] as? String
        roles = [LoginRole]()
        if let rolesArray = dictionary["roles"] as? [[String:Any]]{
            for dic in rolesArray{
                let value = LoginRole(fromDictionary: dic)
                roles.append(value)
            }
        }
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if email != nil{
			dictionary["email"] = email
		}
		if firstname != nil{
			dictionary["firstname"] = firstname
		}
		if id != nil{
			dictionary["id"] = id
		}
		if key != nil{
			dictionary["key"] = key
		}
		if lastname != nil{
			dictionary["lastname"] = lastname
		}
		if otherPassword != nil{
			dictionary["other_password"] = otherPassword
		}
		if phone != nil{
			dictionary["phone"] = phone
		}
		if profileImage != nil{
			dictionary["profile_image"] = profileImage
		}
        if roles != nil{
            var dictionaryElements = [[String:Any]]()
            for rolesElement in roles {
                dictionaryElements.append(rolesElement.toDictionary())
            }
            dictionary["roles"] = dictionaryElements
        }
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         email = aDecoder.decodeObject(forKey: "email") as? String
         firstname = aDecoder.decodeObject(forKey: "firstname") as? String
         id = aDecoder.decodeObject(forKey: "id") as? Int
         key = aDecoder.decodeObject(forKey: "key") as? String
         lastname = aDecoder.decodeObject(forKey: "lastname") as? String
         otherPassword = aDecoder.decodeObject(forKey: "other_password") as? String
         phone = aDecoder.decodeObject(forKey: "phone") as? String
         profileImage = aDecoder.decodeObject(forKey: "profile_image") as? String
         roles = aDecoder.decodeObject(forKey :"roles") as? [LoginRole]
	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if email != nil{
			aCoder.encode(email, forKey: "email")
		}
		if firstname != nil{
			aCoder.encode(firstname, forKey: "firstname")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if key != nil{
			aCoder.encode(key, forKey: "key")
		}
		if lastname != nil{
			aCoder.encode(lastname, forKey: "lastname")
		}
		if otherPassword != nil{
			aCoder.encode(otherPassword, forKey: "other_password")
		}
		if phone != nil{
			aCoder.encode(phone, forKey: "phone")
		}
		if profileImage != nil{
			aCoder.encode(profileImage, forKey: "profile_image")
		}
        if roles != nil{
            aCoder.encode(roles, forKey: "roles")
        }
	}

}
