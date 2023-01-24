//
//  UserObj.swift
//  Elevator
//
//  Created by InovantSolutions on 01/11/22.
//

import Foundation
import Foundation

class UserObj: NSObject, NSCoding {
    var userID: String = ""
    var userImage: String = ""
    var firstName: String = ""
    var lastName: String = ""
    var userEmail: String = ""
    var phoneCode: String = ""
    var phone: String = ""
    var socialRegisterType: String = ""
    var areaID: Int = 0
    var stateID: Int = 0
    var countryID: Int = 0
    var pushEnabled: Bool = false
    var isPhoneVerified: Bool = false
    var isEmailVerified: Bool = false
    var isSocialRegister: Bool = false
    var newsletterSubscribed: Bool = false
    
    override init() {}
    func encode(with aCoder: NSCoder) {
        aCoder.encode(userID, forKey: "userID");
        aCoder.encode(userImage, forKey: "userImage");
        aCoder.encode(firstName, forKey: "firstName");
        aCoder.encode(lastName, forKey: "lastName");
        aCoder.encode(userEmail, forKey: "userEmail");
        aCoder.encode(phoneCode, forKey: "phoneCode");
        aCoder.encode(phone, forKey: "phone");
        aCoder.encode(socialRegisterType, forKey: "socialRegisterType");
        aCoder.encode(areaID, forKey: "areaID");
        aCoder.encode(stateID, forKey: "stateID");
        aCoder.encode(countryID, forKey: "countryID");
        aCoder.encode(isPhoneVerified, forKey: "isPhoneVerified");
        aCoder.encode(isEmailVerified, forKey: "isEmailVerified");
        aCoder.encode(isSocialRegister, forKey: "isSocialRegister");
        aCoder.encode(pushEnabled, forKey: "pushEnabled");
        aCoder.encode(newsletterSubscribed, forKey: "newsletterSubscribed");
        
    }
    
    required init(coder aDecoder: NSCoder) {
        if let userID = aDecoder.decodeObject(forKey: "userID") as? String {
            self.userID = userID
        }
        if let userImage = aDecoder.decodeObject(forKey: "userImage") as? String {
            self.userImage = userImage
        }
        if let firstName = aDecoder.decodeObject(forKey: "firstName") as? String {
            self.firstName = firstName
        }
        
        if let lastName = aDecoder.decodeObject(forKey: "lastName") as? String {
            self.lastName = lastName
        }
        if let userEmail = aDecoder.decodeObject(forKey: "userEmail") as? String {
            self.userEmail = userEmail
        }
        if let phoneCode = aDecoder.decodeObject(forKey: "phoneCode") as? String {
            self.phoneCode = phoneCode
        }
        if let countryID = aDecoder.decodeObject(forKey: "countryID") as? Int {
            self.countryID = countryID
        }
        if let socialRegisterType = aDecoder.decodeObject(forKey: "socialRegisterType") as? String {
            self.socialRegisterType = socialRegisterType
        }
        if let areaID = aDecoder.decodeObject(forKey: "areaID") as? Int {
            self.areaID = areaID
        }
        if let stateID = aDecoder.decodeObject(forKey: "stateID") as? Int {
            self.stateID = stateID
        }
        if let phone = aDecoder.decodeObject(forKey: "phone") as? String {
            self.phone = phone
        }
        if let isPhoneVerified = aDecoder.decodeObject(forKey: "isPhoneVerified") as? Bool {
            self.isPhoneVerified = isPhoneVerified
        }
        if let isSocialRegister = aDecoder.decodeObject(forKey: "isSocialRegister") as? Bool {
            self.isSocialRegister = isSocialRegister
        }
        if let isEmailVerified = aDecoder.decodeObject(forKey: "isEmailVerified") as? Bool {
            self.isEmailVerified = isEmailVerified
        }
        if let pushEnabled = aDecoder.decodeObject(forKey: "pushEnabled") as? Bool {
            self.pushEnabled = pushEnabled
        }
        if let newsletterSubscribed = aDecoder.decodeObject(forKey: "newsletterSubscribed") as? Bool {
            self.newsletterSubscribed = newsletterSubscribed
        }
        
    }
    
    
    static func returnParsedUserObject(dataDictionary:NSDictionary) -> UserObj{
        let userObj = UserObj()

        if let userID = dataDictionary.object(forKey: "user_id") as? String {
            userObj.userID = userID
        }
        if let userImage = dataDictionary.object(forKey: "user_image") as? String {
            userObj.userImage = userImage
        }
        if let firstName = dataDictionary.object(forKey: "first_name") as? String {
            userObj.firstName = firstName
        }
        if let lastName = dataDictionary.object(forKey: "last_name") as? String {
            userObj.lastName = lastName
        }
        if let userEmail = dataDictionary.object(forKey: "email") as? String {
            userObj.userEmail = userEmail
        }
        if let phoneCode = dataDictionary.object(forKey: "phone_code") as? String {
            userObj.phoneCode = phoneCode
        }
        if let phone = dataDictionary.object(forKey: "phone") as? String {
            userObj.phone = phone
        }
        if let socialRegisterType = dataDictionary.object(forKey: "social_register_type") as? String {
            userObj.socialRegisterType = socialRegisterType
        }
        if let areaID = dataDictionary.object(forKey: "area_id") as? Int {
            userObj.areaID = areaID
        }
        if let stateID = dataDictionary.object(forKey: "state_id") as? Int {
            userObj.stateID = stateID
        }
        if let countryID = dataDictionary.object(forKey: "country_id") as? Int {
            userObj.countryID = countryID
        }
        if let isPhoneVerified = dataDictionary.object(forKey: "is_phone_verified") as? Int {
            userObj.isPhoneVerified = isPhoneVerified == 1
        }
        if let isEmailVerified = dataDictionary.object(forKey: "is_email_verified") as? Int {
            userObj.isEmailVerified = isEmailVerified == 1
        }
        if let pushEnabled = dataDictionary.object(forKey: "push_enabled") as? Int {
            userObj.pushEnabled = pushEnabled == 1
        }
        if let isSocialRegister = dataDictionary.object(forKey: "is_social_register") as? Int {
            userObj.isSocialRegister = isSocialRegister == 1
        }
        if let newsletterSubscribed = dataDictionary.object(forKey: "newsletter_subscribed") as? Int {
            userObj.newsletterSubscribed = newsletterSubscribed == 1
        }
        return userObj
    }
    
}

