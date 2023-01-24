//
//  Globals.swift
//  CurlNation
//
//  Created by Inovant Solutions on 31/12/22.
//

import Foundation
import Alamofire
import SwiftMessages
import AssistantKit
import Kingfisher

class Globals: NSObject{
    
    static func isEnglishLang() -> Bool {
        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
        return sceneDelegate.isEnglish;
    }
    
    static func getCurrentLanguage() -> String {
        return isEnglishLang() ? "en" : "ar";
    }
    
    static func getCurrentCurrencyCode() -> String {
        return isEnglishLang() ? "KW" : "KW";
    }
    
    static func GetStringForKey(key:String) -> String {
        return NSLocalizedString(key, tableName: isEnglishLang() ? "English": "Arabic", bundle: Bundle.main, value: "", comment: "")
    }
    
    static func currentTime() -> String {
        let currentDate = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = NSTimeZone(name: "GMT") as TimeZone?
        let date = dateFormatter.date(from: dateFormatter.string(from: currentDate as Date))
        let calendar = Calendar.current
        let addedMinDate = calendar.date(byAdding: .minute, value: 17, to: date!)
        let dateToStringInSeconds = String(addedMinDate!.timeIntervalSince1970)
        return dateToStringInSeconds
    }
    
    static func returnHeadersForRequestWithToken() ->HTTPHeaders{
        
        let time = self.currentTime()
        let stringToEncrypt = time+"###"+AuthToken+"###"+"ios"
        let authToken =  self.EncryptToken(dataToEncrypt:stringToEncrypt)
        
        print("time",time)
        print("stringToEncrypt",stringToEncrypt)
        print("authToken",authToken)
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "authtoken": authToken
        ]
        
        //  //print("TOKEN >> ",isUserLoggedIn() ? "Bearer"+" "+appDelegate.userObj.auth_token : "")
        print("headers",headers)
        
        
        return headers
    }
    
    static func EncryptToken(dataToEncrypt:String)->String{
        var encryptedName = ""
        
        //        do {
        //
        //
        //            //encryption
        ////            let aes = try AES(key: SecretKey, iv: IVKey) // aes256
        //
        //            let ciphertext = try aes.encrypt(Array(dataToEncrypt.utf8))
        //            encryptedName = ciphertext.toBase64() ?? ""
        //
        //            //decryption
        //            let decryptedText = try aes.decrypt(ciphertext)
        //            let data = Data(bytes: decryptedText, count: decryptedText.count)
        //
        //            if let string = String(data: data, encoding: .utf8) {
        //                print("decrpt",string)
        //            } else {
        //                print("not a valid UTF-8 sequence")
        //            }
        //        } catch { }
        return encryptedName
        
    }
    
    static func SaveUserProfile(userObj:UserObj) {
        UserDefaults.standard.set(NSKeyedArchiver.archivedData(withRootObject: userObj), forKey: "UserProfile");
    }
    
    static func showSucess(title: String) {
        var config = SwiftMessages.defaultConfig
        config.presentationStyle = .top
        config.presentationContext = .window(windowLevel: UIWindow.Level.normal)
        config.duration = .seconds(seconds: 2)
        SwiftMessages.show(config: config, view: Globals.makeSwiftMessage(Text:title,Type: "success"))
    }
    
    static func showError(title: String) {
        var config = SwiftMessages.defaultConfig
        config.presentationStyle = .top
        config.presentationContext = .window(windowLevel: UIWindow.Level.normal)
        config.duration = .seconds(seconds: 2)
        SwiftMessages.show(config: config, view: Globals.makeSwiftMessage(Text:title,Type: "error"))
    }
    
    static func makeSwiftMessage(Text:String, Type:String ) -> MessageView {
        let view: MessageView
        view = try! SwiftMessages.viewFromNib()
        
        view.configureContent(title:nil , body: Text, iconImage: nil, iconText: nil, buttonImage: nil, buttonTitle: nil , buttonTapHandler: { _ in SwiftMessages.hide() })
        view.bodyLabel?.font = UIFont(name: fontNameRegular, size: SubTitleFontsize)
        view.bodyLabel?.textColor = .black;
        view.bodyLabel?.textAlignment = .center;
        
        if Type == "info"{
            view.configureTheme(.info, iconStyle: .default)
            view.accessibilityPrefix = "info"
        }
        else  if Type == "success"{
            view.configureTheme(.success, iconStyle: .default)
            view.accessibilityPrefix = "success"
        }
        else if Type == "warning"{
            view.configureTheme(.warning, iconStyle: .default)
            view.accessibilityPrefix = "warning"
        }
        else if Type == "error"{
            view.bodyLabel?.font = UIFont(name: fontNameRegular, size: TitleFontsize)
            view.button?.isHidden = true
            view.iconImageView?.isHidden = true
            view.configureTheme(backgroundColor: BgColor, foregroundColor: SecondaryTextColor, iconImage: nil, iconText: "")
            
            return view
        }
        else
        {
            
            view.configureTheme(backgroundColor: .black, foregroundColor: SecondaryTextColor, iconImage: nil, iconText: "")
            
        }
        
        view.configureTheme(backgroundColor: BgColor, foregroundColor: SecondaryTextColor, iconImage: nil, iconText: "")
        view.accessibilityPrefix = "info"
        
        view.button?.isHidden = true
        
        view.bodyLabel?.textAlignment = .center;
        return view;
    }
    
    static func changeDateFormat(strTimeOrignal: String, inputFormat strInputFormat: String, outputFormat strOutputFormat: String,langSpecificLocal:Bool=false) -> String {
        
        if strTimeOrignal.isEmpty {
            return ""
        }
        else{
            let dateFormat = DateFormatter()
            dateFormat.locale = NSLocale(localeIdentifier: "en") as Locale
            dateFormat.dateFormat = strInputFormat
            
            
            let date: Date? = dateFormat.date(from: strTimeOrignal)
            dateFormat.dateFormat = strOutputFormat
            dateFormat.amSymbol = "Am"
            dateFormat.pmSymbol = "Pm"
            let todayDate = Date()
            let strNewTime: String = dateFormat.string(from: date ?? todayDate)
            return strNewTime
        }
    }
    
    //MARK: Check devices
    static func isDeviceLessThan11() -> Bool {
        var isLess = true;
        switch UIDevice.current.systemVersion.compare("11.0", options: NSString.CompareOptions.numeric) {
        case .orderedAscending:
            isLess = true;
            break;
        case .orderedSame:
            isLess = false;
            break;
        case .orderedDescending:
            isLess = false;
            break;
        }
        return isLess;
    }
    
    static func isDeviceiPad() -> Bool {
        return Device.isPad;
    }
    
    static func isDeviceiPhone6() -> Bool {
        var isDevice = false
        if UI_USER_INTERFACE_IDIOM() == .phone {
            if ScreenHeight == 667.0 {
                isDevice = true
            }
            else {
                isDevice = false
            }
        }
        return isDevice
    }
    
    static func isDeviceiPhone6Plus() -> Bool {
        var isDevice = false
        if UI_USER_INTERFACE_IDIOM() == .phone {
            if ScreenHeight == 736.0 {
                isDevice = true
            }
            else {
                isDevice = false
            }
        }
        return isDevice
    }
    
    static func isDeviceiPhone5() -> Bool {
        var isDevice = false
        if UI_USER_INTERFACE_IDIOM() == .phone {
            if ScreenHeight == 568.0 {
                isDevice = true
            }
            else {
                isDevice = false
            }
        }
        return isDevice
    }
    
    static func isDeviceiPhoneX() -> Bool {
        var isDevice = false
        if UI_USER_INTERFACE_IDIOM() == .phone {
            if ScreenHeight == 812.0 {
                isDevice = true
            }
            else {
                isDevice = false
            }
        }
        return isDevice
    }
    
    static func isDeviceiPhoneXMax() -> Bool {
        var isDevice = false
        if UI_USER_INTERFACE_IDIOM() == .phone {
            if ScreenHeight == 896.0 || ScreenHeight == 844.0 {
                isDevice = true
            }
            else {
                isDevice = false
            }
        }
        return isDevice
    }
    
    //MARK: Get current device model
    static func getCurrentDeviceModal() -> String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") {
            identifier, element in
            guard let value = element.value as? Int8, value != 0
            else
            {
                return identifier
            }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
#if os(iOS)
        switch identifier {
        case "iPod5,1":                                 return "iPod Touch 5"
        case "iPod7,1":                                 return "iPod Touch 6"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
        case "iPhone4,1":                               return "iPhone 4s"
        case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
        case "iPhone7,2":                               return "iPhone 6"
        case "iPhone7,1":                               return "iPhone 6 Plus"
        case "iPhone8,1":                               return "iPhone 6s"
        case "iPhone8,2":                               return "iPhone 6s Plus"
        case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
        case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
        case "iPhone8,4":                               return "iPhone SE"
        case "iPhone10,1", "iPhone10,4":                return "iPhone 8"
        case "iPhone10,2", "iPhone10,5":                return "iPhone 8 Plus"
        case "iPhone10,3", "iPhone10,6":                return "iPhone X"
        case "iPhone11,2":                              return "iPhone XS"
        case "iPhone11,4", "iPhone11,6":                return "iPhone XS Max"
        case "iPhone11,8":                              return "iPhone XR"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
        case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
        case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
        case "iPad6,11", "iPad6,12":                    return "iPad 5"
        case "iPad7,5", "iPad7,6":                      return "iPad 6"
        case "iPad11,4", "iPad11,5":                    return "iPad Air (3rd generation)"
        case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
        case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
        case "iPad11,1", "iPad11,2":                    return "iPad Mini 5"
        case "iPad6,3", "iPad6,4":                      return "iPad Pro (9.7-inch)"
        case "iPad6,7", "iPad6,8":                      return "iPad Pro (12.9-inch)"
        case "iPad7,1", "iPad7,2":                      return "iPad Pro (12.9-inch) (2nd generation)"
        case "iPad7,3", "iPad7,4":                      return "iPad Pro (10.5-inch)"
        case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4":return "iPad Pro (11-inch)"
        case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8":return "iPad Pro (12.9-inch) (3rd generation)"
        case "AppleTV5,3":                              return "Apple TV"
        case "AppleTV6,2":                              return "Apple TV 4K"
        case "AudioAccessory1,1":                       return "HomePod"
        case "i386", "x86_64":                          return "Simulator"
        default:                                        return identifier
        }
#elseif os(tvOS)
        switch identifier {
        case "AppleTV5,3": return "Apple TV 4"
        case "AppleTV6,2": return "Apple TV 4K"
        case "i386", "x86_64": return "Simulator"
        default: return identifier
        }
#endif
    }
    
    static func setFonts(){
        fontNameRegular = Globals.isEnglishLang() ? "Archivo-Regular" : "FrutigerLTArabic-55Roman"
        fontNameSemiBold = Globals.isEnglishLang() ? "Archivo-SemiBold" : "FrutigerLTArabic-65Bold"
        fontNameBold = Globals.isEnglishLang() ? "Archivo-Bold" : "FrutigerLTArabic-65Bold"
        fontNameMedium = Globals.isEnglishLang() ? "Archivo-Medium" : "FrutigerLTArabic-65Bold"
        NavBarFont = Globals.isEnglishLang() ? "Archivo-Bold" : "Oxygen-Bold"
        TabBarFont = Globals.isEnglishLang() ? "Archivo-Regular" : "FrutigerLTArabic-55Roman"
        fontNameBtn = Globals.isEnglishLang() ? "Archivo-Bold" : "FrutigerLTArabic-75Black"
        
        fontNameRegularMont = Globals.isEnglishLang() ? "Montserrat-Regular" : "FrutigerLTArabic-55Roman"
        fontNameSemiBoldMont = Globals.isEnglishLang() ? "Montserrat-SemiBold" : "FrutigerLTArabic-65Bold"
        fontNameMediumMont = Globals.isEnglishLang() ? "Montserrat-Medium" : "FrutigerLTArabic-65Bold"
        fontNameBoldMont = Globals.isEnglishLang() ? "Montserrat-Bold" : "FrutigerLTArabic-65Bold"
        NavBarFontMont = Globals.isEnglishLang() ? "Montserrat-Bold" : "Oxygen-Bold"
        TabBarFontMont = Globals.isEnglishLang() ? "Montserrat-Regular" : "FrutigerLTArabic-55Roman"
        fontNameBtnMont = Globals.isEnglishLang() ? "Montserrat-Bold" : "FrutigerLTArabic-75Black"
        
    }
    
    static func setSize(){
        NavFontsize = CGFloat(Globals.isEnglishLang() ? 16:16)
        TabFontsize =  CGFloat(Globals.isEnglishLang() ? 9:9);
        HugeFontSize = CGFloat(Globals.isEnglishLang() ? 22.0:22.0)
        BigTitleFontsize = CGFloat(Globals.isEnglishLang() ?20:20)
        HeaderFontSize = CGFloat(Globals.isEnglishLang() ? 18.0:18)
        TitleFontsize =  CGFloat(Globals.isEnglishLang() ? 14.0:14.0)
        SubTitleFontsize = CGFloat(Globals.isEnglishLang() ? 12.0:12)
        DetailFontsize = CGFloat(Globals.isEnglishLang() ? 10:10)
        SmallFontsize = CGFloat(Globals.isEnglishLang() ? 9:9)
        BtnFontsize = CGFloat(Globals.isEnglishLang() ? 14:14)
        BigBtnFontsize = CGFloat(Globals.isEnglishLang() ? 16:16)
    }
    
    static func makeContainerView (rect : CGRect, bgColor:UIColor) -> UIView{
        let view = UIView()
        view.frame=rect
        view.backgroundColor=bgColor
        
        return view
    }
    
    static func makeLabel(frame:CGRect, fontName:String, fontSize:CGFloat, textColor:UIColor, text:String) -> UILabel {
        
        let label = UILabel()
        
        label.frame = frame;
        label.backgroundColor = UIColor.clear;
        label.numberOfLines=0;
        label.font=UIFont(name:fontName, size:fontSize)
        label.textColor=textColor;
        label.text=text;
        label.textAlignment = Globals.isEnglishLang() ? .left : .right
        return label
    }
    
    static func makeTextField(placeholder:String , TextColor:UIColor, fontname:String, frame:CGRect,fontsize:CGFloat, text:String,Icon:String  ) -> UITextField {
        
        let textField = UITextField()
        textField.frame = frame
        textField.placeholder = placeholder
        textField.textColor = TextColor
        textField.font = UIFont(name: fontname, size: fontsize)
        textField.text = text
        textField.textAlignment = Globals.isEnglishLang() ? .left : .right
        textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : TextFieldTextColor,NSAttributedString.Key.font:UIFont(name: fontNameRegular, size: fontsize) ?? UIFont.systemFont(ofSize: fontsize)])
        textField.leftView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 10*DeviceMultiplier, height: 40*DeviceMultiplier))
        textField.leftViewMode = .always
        textField.rightView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 10*DeviceMultiplier, height: 40*DeviceMultiplier))
        textField.rightViewMode = .always
        textField.leftView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 10*DeviceMultiplier, height: 40*DeviceMultiplier))
        textField.leftViewMode = .always
        
        if Icon.count>0{
            let imgView = Globals.makeContainerView(rect: CGRect(x: 0, y: 0, width: 40*DeviceMultiplier, height: 40*DeviceMultiplier), bgColor: .clear)
            imgView.isUserInteractionEnabled = false
            let textIcon = UIImageView()
            textIcon.frame = CGRect(x: 10*DeviceMultiplier, y: 10*DeviceMultiplier, width:20*DeviceMultiplier, height: 20*DeviceMultiplier)
            textIcon.image = UIImage(named: Icon)?.withRenderingMode(.alwaysTemplate)
            textIcon.tintColor = TextColor
            imgView.addSubview(textIcon)
            
            if Globals.isEnglishLang() {
                textField.rightView = imgView
            }
            else {
                textField.leftView = imgView
            }
        }
        
        return textField
    }
    
    static func makeImageView(frame:CGRect,url: String,contentMode:UIView.ContentMode) -> UIImageView {
        
        let imageView = UIImageView()
        imageView.frame=frame
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: URL(string: url), placeholder: UIImage(named: ""), options: [.transition(.fade(0.5))])
        imageView.contentMode = contentMode;
        imageView.isUserInteractionEnabled=true;
        imageView.clipsToBounds = true;
        return imageView;
    }
    
    static func makeButton(frame:CGRect, fontName:String, fontSize:CGFloat, textColor:UIColor, text:String , backgroundColor:UIColor ) -> MultiTag_UIButton {
        
        let button = MultiTag_UIButton(type: .custom)
        
        button.frame=frame;
        button.titleLabel?.font=UIFont(name:fontName, size:fontSize)
        button.titleLabel?.textColor=textColor;
        button.titleLabel?.numberOfLines=0;
        button.setTitleColor(textColor, for: UIControl.State.normal);
        button.setTitle(GetStringForKey(key: text), for: UIControl.State.normal)
        button.backgroundColor=backgroundColor;
        return button;
    }
    
    static func makeDividerLine(Frame:CGRect) -> UIView {
        let  dividerLine = UIView();
        dividerLine.frame=Frame;
        dividerLine.backgroundColor=BgColor
        
        return dividerLine;
    }
    
    static func getTextHeight(text:String, font:UIFont, constrainedSize: CGSize) -> CGFloat {
        var height:CGFloat = 0;
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 3
        
        let rect:CGRect = NSString(string: text).boundingRect(with: constrainedSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font,NSAttributedString.Key.paragraphStyle: paragraphStyle],  context: nil)
        height = rect.size.height
        
        return height
    }
    
    static func getTextWidth(text:String, font:UIFont, constrainedSize: CGSize) -> CGFloat {
        
        var width:CGFloat = 0;
        
        let rect:CGRect = NSString(string: text).boundingRect(with: constrainedSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font],  context: nil)
        width = rect.size.width
        
        
        return width
    }
    
    static func convertNumberToPrice(price: Double) -> String {
        let priceNumber = price as NSNumber
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        formatter.locale = Locale(identifier: "en")
        formatter.currencyCode = ""
        formatter.currencySymbol = ""
        formatter.maximumFractionDigits=2;
        
        var convertedPrice:String = formatter.string(from: priceNumber)!
        convertedPrice = sceneDelegate.selectedCountry.currency_en + " " + convertedPrice;
        
        if sceneDelegate.isEnglish {
            convertedPrice = findAndReplacePriceEN(price: convertedPrice);
        }else{
            convertedPrice = findAndReplacePriceAR(price: convertedPrice);
        }
        
        return convertedPrice
        
    }
    
    //MARK: Currency Functions
    static func findAndReplacePriceAR(price: String) -> String {
        var newPrice = price;
        newPrice = newPrice.replacingOccurrences(of: "KD", with: "د.ك");
        newPrice = newPrice.replacingOccurrences(of: "QR", with: "ر.ق");
        newPrice = newPrice.replacingOccurrences(of: "SR", with: "ر.س");
        newPrice = newPrice.replacingOccurrences(of: "USD", with: "د.أ");
        newPrice = newPrice.replacingOccurrences(of: "BD", with: "د.ب");
        newPrice = newPrice.replacingOccurrences(of: "OR", with: "ر.ع");
        newPrice = newPrice.replacingOccurrences(of: "AED", with: "د.إ");
        
        return newPrice;
    }
    
    static func findAndReplacePriceEN(price: String) -> String {
        
        var newPrice = price;
        newPrice = newPrice.replacingOccurrences(of: "د.ك", with: "KD");
        newPrice = newPrice.replacingOccurrences(of: "ر.ق", with: "QR");
        newPrice = newPrice.replacingOccurrences(of: "ر.س", with: "SR");
        newPrice = newPrice.replacingOccurrences(of: "د.أ", with: "USD");
        newPrice = newPrice.replacingOccurrences(of: "د.ب", with: "BD");
        newPrice = newPrice.replacingOccurrences(of: "ر.ع", with: "OR");
        newPrice = newPrice.replacingOccurrences(of: "د.إ", with: "AED");
        
        return newPrice;
    }
    
    static func findAndReplaceDateEN(date: String) -> String {
        var DateEN = date;
        DateEN = DateEN.replacingOccurrences(of: "٠", with: "0");
        DateEN = DateEN.replacingOccurrences(of: "١", with: "1");
        DateEN = DateEN.replacingOccurrences(of: "٢", with: "2");
        DateEN = DateEN.replacingOccurrences(of: "٣", with: "3");
        DateEN = DateEN.replacingOccurrences(of: "٤", with: "4");
        DateEN = DateEN.replacingOccurrences(of: "٥", with: "5");
        DateEN = DateEN.replacingOccurrences(of: "٦", with: "6");
        DateEN = DateEN.replacingOccurrences(of: "٧", with: "7");
        DateEN = DateEN.replacingOccurrences(of: "٨", with: "8");
        DateEN = DateEN.replacingOccurrences(of: "٩", with: "9");
        
        return DateEN;
    }
    
    //MARK: Check User Type
    static func SaveUserCountry(countryObj:CountryObj) {
        NSKeyedArchiver.setClassName("CountryObj", for: CountryObj.self)
        UserDefaults.standard.set(NSKeyedArchiver.archivedData(withRootObject: countryObj), forKey: "UserCountry")
    }
    
    static func LoadUserCountry() -> CountryObj {
        var countryObj = CountryObj()
        if let countryObject = UserDefaults.standard.value(forKey: "UserCountry") as? NSData {
            NSKeyedUnarchiver.setClass(CountryObj.self, forClassName: "CountryObj")
            countryObj = NSKeyedUnarchiver.unarchiveObject(with: countryObject as Data) as! CountryObj
        }
        return countryObj
    }
    
    static func isUserLoggedIn() -> Bool {
        return  UserDefaults.standard.bool(forKey: "isUserLogin");
    }
    
    static func LoadUserProfile() -> UserObj{
        var userObj = UserObj();
        if let userObject = UserDefaults.standard.value(forKey: "UserProfile") as? NSData {
            NSKeyedUnarchiver.setClass(UserObj.self, forClassName: "UserObj")
            userObj = NSKeyedUnarchiver.unarchiveObject(with: userObject as Data) as! UserObj
        }
        return userObj;
    }
    
    static func logoutUser() -> Bool {
        appDelegate.userObj = UserObj()
        Globals.SaveUserProfile(userObj: appDelegate.userObj);
        UserDefaults.standard.set(false, forKey: "isUserLogin");
        return true;
    }
    
    static func getDefaultCountry() -> CountryObj{
        let countryObj = CountryObj()
        countryObj.country_id = 114
        countryObj.name = Globals.isEnglishLang() ? "Kuwait" : "الكويت"
        countryObj.currency_en = "KD"
        countryObj.currency_ar = "د.ك"
        countryObj.isSelected = true
        countryObj.iso = "KW"
        countryObj.iso3 = "KWT"
        countryObj.numcode = "414"
        countryObj.phonecode = "965"
        countryObj.flag = "https://api-dev.salamtek.com/uploads/Img_1632723347671_ku29bpw7ga5lqeargt5.png"
        
        return countryObj
    }
    
    static func setDefaultCountry(){
        let countryObj = self.getDefaultCountry()
        
        Globals.SaveUserCountry(countryObj: countryObj)
        sceneDelegate.selectedCountry = Globals.LoadUserCountry()
    }
    
    static func addRefreshController(Target:Any?, tableView:UITableView, refreshControll:UIRefreshControl, targetSelector:Selector){
        tableView.refreshControl = refreshControll
        refreshControll.addTarget(Target, action:
                                    targetSelector,
                                  for: UIControl.Event.valueChanged)
        refreshControll.tintColor = PrimaryTextColor
    }
    
    static func isValidEmail(emailStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{1,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailStr)
    }
    
    static func encodeToBase64String(image: UIImage) -> String {
        return image.pngData()?.base64EncodedString() ?? ""
    }

    
}
