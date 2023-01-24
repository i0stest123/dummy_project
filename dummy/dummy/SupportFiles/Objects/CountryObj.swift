//
//  CountryObj.swift
//  Elevator
//
//  Created by Rohit Sawant on 10/11/22.
//

import Foundation

class CountryObj: NSObject, NSCoding {
    var country_id: Int = 0
    var name: String = ""
    var niceName: String = ""
    var phonecode: String = ""
    var iso: String = ""
    var iso3: String = ""
    var numcode: String = ""
    var flag: String = ""
    var currency_en: String = ""
    var currency_ar: String = ""
    var is_base_currency:Bool = false
    var is_store:Bool = false
    var isSelected:Bool = false
    var hasStates:Bool = false
    var is_active:Bool = false
    
    override init() {}
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(country_id, forKey: "country_id");
        aCoder.encode(name, forKey: "name");
        aCoder.encode(niceName, forKey: "niceName");
        aCoder.encode(flag, forKey: "flag");
        aCoder.encode(phonecode, forKey: "phonecode");
        aCoder.encode(iso, forKey: "iso");
        aCoder.encode(iso3, forKey: "iso3");
        aCoder.encode(numcode, forKey: "numcode");
        aCoder.encode(currency_en, forKey: "currency_en");
        aCoder.encode(currency_ar, forKey: "currency_ar");
        aCoder.encode(is_base_currency, forKey: "is_base_currency");
        aCoder.encode(is_store, forKey: "is_store");
        aCoder.encode(isSelected, forKey: "isSelected");
        aCoder.encode(hasStates, forKey: "hasStates");
        aCoder.encode(is_active, forKey: "is_active");
    }
    
    required init(coder aDecoder: NSCoder) {
        if let country_id = aDecoder.decodeObject(forKey: "country_id") as? Int {
            self.country_id = country_id
        }
        if let name = aDecoder.decodeObject(forKey: "name") as? String {
            self.name = name
        }
        if let niceName = aDecoder.decodeObject(forKey: "niceName") as? String {
            self.niceName = niceName
        }
        if let flag = aDecoder.decodeObject(forKey: "flag") as? String {
            self.flag = flag
        }
        if let phonecode = aDecoder.decodeObject(forKey: "phonecode") as? String {
            self.phonecode = phonecode
        }
        if let iso = aDecoder.decodeObject(forKey: "iso") as? String {
            self.iso = iso
        }
        if let iso3 = aDecoder.decodeObject(forKey: "iso3") as? String {
            self.iso3 = iso3
        }
        if let numcode = aDecoder.decodeObject(forKey: "numcode") as? String {
            self.numcode = numcode
        }
        if let currency_en = aDecoder.decodeObject(forKey: "currency_en") as? String {
            self.currency_en = currency_en
        }
        if let currency_ar = aDecoder.decodeObject(forKey: "currency_ar") as? String {
            self.currency_ar = currency_ar
        }
        if let is_base_currency = aDecoder.decodeObject(forKey: "is_base_currency") as? Bool {
            self.is_base_currency = is_base_currency
        }
        if let is_store = aDecoder.decodeObject(forKey: "is_store") as? Bool {
            self.is_store = is_store
        }
        if let isSelected = aDecoder.decodeObject(forKey: "isSelected") as? Bool {
            self.isSelected = isSelected
        }
        if let hasStates = aDecoder.decodeObject(forKey: "hasStates") as? Bool {
            self.hasStates = hasStates
        }
        if let is_active = aDecoder.decodeObject(forKey: "is_active") as? Bool {
            self.is_active = is_active
        }
    }
    
    //MARK: Parsing Country Object
    static func returnParsedCountryObject(dataDictionary:NSDictionary) -> CountryObj{
        let countryObj = CountryObj()
        if let country_id = dataDictionary.object(forKey: "country_id") as? Int {
            countryObj.country_id = country_id
        }
        if let name = dataDictionary.object(forKey: "name") as? String {
            countryObj.name = name
        }
        if let niceName = dataDictionary.object(forKey: "niceName") as? String {
            countryObj.niceName = niceName
        }
        if let flag = dataDictionary.object(forKey: "flag") as? String {
            countryObj.flag = flag
        }
        if let phonecode = dataDictionary.object(forKey: "phonecode") as? String {
            countryObj.phonecode = phonecode
        }
        if let iso = dataDictionary.object(forKey: "iso") as? String {
            countryObj.iso = iso
        }
        if let iso3 = dataDictionary.object(forKey: "iso3") as? String {
            countryObj.iso3 = iso3
        }
        if let numcode = dataDictionary.object(forKey: "numcode") as? String {
            countryObj.numcode = numcode
        }
        if let currency_en = dataDictionary.object(forKey: "currency_en") as? String {
            countryObj.currency_en = currency_en
        }
        if let currency_ar = dataDictionary.object(forKey: "currency_ar") as? String {
            countryObj.currency_ar = currency_ar
        }
        if let is_base_currency = dataDictionary.object(forKey: "is_base_currency") as? Bool {
            countryObj.is_base_currency = is_base_currency
        }
        if let is_store = dataDictionary.object(forKey: "is_store") as? Bool {
            countryObj.is_store = is_store
        }
        if let isSelected = dataDictionary.object(forKey: "isSelected") as? Bool {
            countryObj.isSelected = isSelected
        }
        if let hasStates = dataDictionary.object(forKey: "hasStates") as? Bool {
            countryObj.hasStates = hasStates
        }
        
        if let is_active = dataDictionary.object(forKey: "is_active") as? String {
            countryObj.is_active = is_active == "Yes"
        }
        
        return countryObj
    }
    static func returnParsedStateArray(nsArray:NSArray) -> [CountryObj]{
        var countryArray = [CountryObj]()
        for dict in nsArray{
            let dataDictionary = dict as? NSDictionary ?? [:]
            let countryObj = self.returnParsedCountryObject(dataDictionary: dataDictionary)
            countryArray.append(countryObj)
        }
        return countryArray
    }
    
}

class StateObj: NSObject{
    lazy var stateId:Int = 0
    lazy var name:String = ""
    lazy var isSelected:Bool = false
    
    //MARK: Parsing State Object
    static func returnParsedStateObject(dataDictionary:NSDictionary) -> StateObj{
        let stateObj = StateObj()
        if let id = dataDictionary.object(forKey: "state_id") as? Int{
            stateObj.stateId = id
        }
        if let name = dataDictionary.object(forKey: "name") as? String{
            stateObj.name = name
        }
        
        return stateObj
    }
    static func returnParsedStateArray(nsArray:NSArray) -> [StateObj]{
        var stateArray = [StateObj]()
        for dict in nsArray{
            let dataDictionary = dict as? NSDictionary ?? [:]
            stateArray.append(self.returnParsedStateObject(dataDictionary: dataDictionary))
        }
        return stateArray
    }
}

class AreaObj: NSObject{
    lazy var areaId:Int = 0
    lazy var name:String = ""
    lazy var stateName:String = ""
    lazy var latitude:String = ""
    lazy var isSelected:Bool = false
    lazy var longitude:String = ""
    
    //MARK: Parsing Area Object
    static func returnParsedAreaObject(dataDictionary:NSDictionary) -> AreaObj{
        let areaObj = AreaObj()
        if let id = dataDictionary.object(forKey: "area_id") as? Int{
            areaObj.areaId = id
        }
        if let name = dataDictionary.object(forKey: "name") as? String{
            areaObj.name = name
        }
        if let state = dataDictionary.object(forKey: "state") as? String{
            areaObj.stateName = state
        }
        if let latitude = dataDictionary.object(forKey: "latitude") as? String{
            areaObj.latitude = latitude
        }
        if let longitude = dataDictionary.object(forKey: "longitude") as? String{
            areaObj.longitude = longitude
        }
        
        return areaObj
    }
    static func returnParsedAreaArray(nsArray:NSArray) -> [AreaObj]{
        var areaArray = [AreaObj]()
        for dict in nsArray{
            let dataDictionary = dict as? NSDictionary ?? [:]
            areaArray.append(self.returnParsedAreaObject(dataDictionary: dataDictionary))
        }
        return areaArray
    }
}
