//
//  Config.swift
//  CurlNation
//
//  Created by Inovant Solutions on 31/12/22.
//

import UIKit
import Foundation
import AssistantKit


let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
let appDelegate = UIApplication.shared.delegate as! AppDelegate


//MARK: Domain info
var ISLIVE:Bool = true
var Host = (ISLIVE) ? "https://dev-cp.bandarestate.com/api/v1/" : "https://dev-cp.bandarestate.com/api/v1/"
var AuthToken = (ISLIVE) ? "" : ""
var DeviceType:String = "I"

var DeviceMultiplier:CGFloat = Device.size(phone:UIScreen.main.bounds.width/320.0, pad: (is_Portrait) ? UIScreen.main.bounds.width/768.0 : UIScreen.main.bounds.width/1024.0 );
var DeviceWidth:CGFloat = UIScreen.main.bounds.width;
var ScreenHeight = UIScreen.main.bounds.height;
var ScreenWidth = UIScreen.main.bounds.width;
var is_Portrait:Bool = UIApplication.shared.statusBarOrientation.isPortrait
var is_Landscape:Bool = UIApplication.shared.statusBarOrientation.isLandscape
let DeviceMargine = 15*DeviceMultiplier
let CornerRadius = 5*DeviceMultiplier
let BtnHeight = 40*DeviceMultiplier

//MARK: Device Information
let AppVersion :String = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String ?? ""
var OSVersion  :String = UIDevice.current.systemVersion
var DeviceModel:String = Globals.getCurrentDeviceModal()


//MARK: Icons


//MARK: FONTS
var fontNameRegular = Globals.isEnglishLang() ? "Helvetica-Light" : "FrutigerLTArabic-65Bold"
var fontNameSemiBold = Globals.isEnglishLang() ? "Helvetica-Light" : "FrutigerLTArabic-65Bold"
var fontNameMedium = Globals.isEnglishLang() ? "Helvetica-Light" : "FrutigerLTArabic-65Bold"
var fontNameBold = Globals.isEnglishLang() ? "Helvetica-Light" : "FrutigerLTArabic-65Bold"
var NavBarFont = Globals.isEnglishLang() ? "Helvetica-Light" : "Archivo-Bold"
var TabBarFont = Globals.isEnglishLang() ? "Helvetica-Light" : "FrutigerLTArabic-55Roman"
var fontNameBtn = Globals.isEnglishLang() ? "Helvetica-Light" : "FrutigerLTArabic-75Black"

var fontNameRegularMont = Globals.isEnglishLang() ? "Montserrat-Regular" : "FrutigerLTArabic-55Roman"
var fontNameSemiBoldMont = Globals.isEnglishLang() ? "Montserrat-SemiBold" : "FrutigerLTArabic-65Bold"
var fontNameMediumMont = Globals.isEnglishLang() ? "Montserrat-Medium" : "FrutigerLTArabic-65Bold"
var fontNameBoldMont = Globals.isEnglishLang() ? "Montserrat-Bold" : "FrutigerLTArabic-65Bold"
var NavBarFontMont = Globals.isEnglishLang() ? "Montserrat-Bold" : "Oxygen-Bold"
var TabBarFontMont = Globals.isEnglishLang() ? "Montserrat-Regular" : "FrutigerLTArabic-55Roman"
var fontNameBtnMont = Globals.isEnglishLang() ? "Montserrat-Bold" : "FrutigerLTArabic-75Black"

//MARK: SIZES
var NavFontsize = CGFloat(Globals.isEnglishLang() ? 16:16)
var TabFontsize =  CGFloat(Globals.isEnglishLang() ? 9:9);
var HugeFontSize = CGFloat(Globals.isEnglishLang() ? 22.0:22.0)
var BigTitleFontsize = CGFloat(Globals.isEnglishLang() ?20:20)
var HeaderFontSize = CGFloat(Globals.isEnglishLang() ? 18.0:18)
var TitleFontsize =  CGFloat(Globals.isEnglishLang() ? 14.0:14.0)
var SubTitleFontsize = CGFloat(Globals.isEnglishLang() ? 12.0:12)
var DetailFontsize = CGFloat(Globals.isEnglishLang() ? 10:10)
var SmallFontsize = CGFloat(Globals.isEnglishLang() ? 9:9)
var BtnFontsize = CGFloat(Globals.isEnglishLang() ? 14:14)
var BigBtnFontsize = CGFloat(Globals.isEnglishLang() ? 16:16)


//MARK: COLORS
var BgColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1)
var NavBgColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
var NavTitleColor = UIColor(red: 20.0/255.0, green: 20.0/255.0, blue: 20.0/255.0, alpha: 1.0)
var PrimaryTextColor = UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1)
var SecondaryTextColor = UIColor(red: 90.0/255.0, green: 90.0/255.0, blue: 90.0/255.0, alpha: 1)
var TertiaryTextColor = UIColor(red: 154/255.0, green: 154/255.0, blue: 154/255.0, alpha: 1)
var PinkColor = UIColor(red: 255.0/255.0, green: 200.0/255.0, blue: 192.0/255.0, alpha: 1)
var BorderColor = UIColor(red: 236/255.0, green: 236/255.0, blue: 236/255.0, alpha: 1)
var LightGrayBGColor = UIColor(red: 235/255.0, green: 235/255.0, blue: 235/255.0, alpha: 1)
var ShadowColor = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1)

var PlaceholderColor = UIColor(red: 90.0/255.0, green: 90.0/255.0, blue: 90.0/255.0, alpha: 1)
var TextFieldBgColor = UIColor(red: 241.0/255.0, green: 241.0/255.0, blue: 241.0/255.0, alpha: 1)
var TextFieldTextColor = UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1)

var TabBarBgcolor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1)
var TabBarTextColor = UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1)
var TabBarUnselectedTextColor = UIColor(red: 90.0/255.0, green: 90.0/255.0, blue: 90.0/255.0, alpha: 1)




var TOKEN_URL = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiIsImN0eSI6InR3aWxpby1mcGE7dj0xIn0.eyJqdGkiOiJTSzZiN2JlY2FjMTZkZjM2YmNlMjNlYTVmODkwZWE5YjVjLTE2NzIxMzk3NTAiLCJpc3MiOiJTSzZiN2JlY2FjMTZkZjM2YmNlMjNlYTVmODkwZWE5YjVjIiwic3ViIjoiQUMzMzBhOWY0NDEwZTA3Mjc4ZDQwODcwZWMyODJhYjQ4MyIsImV4cCI6MTY3MjE0MzM1MCwiZ3JhbnRzIjp7ImlkZW50aXR5IjoiNyIsImNoYXQiOnsic2VydmljZV9zaWQiOiJJUzRmZDM3ZTc5MGY2YzRhNTg4MTZiZTY3OTI0MGU3NTU0In19fQ.6OyAL4Luq-wB6HwPm116ZMZyqPVYb2FBl0bsXDb_La4"
 
