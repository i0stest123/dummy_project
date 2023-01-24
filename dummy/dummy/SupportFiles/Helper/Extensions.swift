//
//  Extensions.swift
//  CurlNation
//
//  Created by Inovant Solutions on 31/12/22.
//

import Foundation
import UIKit

extension UIViewController{
    func setNavigationCustomBack(titleStr: String){
        let backButton = UIBarButtonItem()
        backButton.title = Globals.GetStringForKey(key: titleStr)
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    func setSearchAndCartRightView(){
        let searchbtn = Globals.makeButton(frame: CGRect(x: 0,y:5*DeviceMultiplier,width:30*DeviceMultiplier,height:30*DeviceMultiplier), fontName:fontNameBtn, fontSize: BtnFontsize, textColor: PrimaryTextColor, text: "", backgroundColor: .clear)
        searchbtn.tintColor = NavTitleColor

        searchbtn.setImage(UIImage(named: "SearchIcon")?.withRenderingMode(.alwaysTemplate), for: .normal)
        searchbtn.imageView?.contentMode = .scaleAspectFit
        let searchbarButton = UIBarButtonItem()
        searchbarButton.customView = searchbtn
        searchbtn.addTarget(self, action: #selector(method), for: UIControl.Event.touchUpInside)
        
        let cartbtn = Globals.makeButton(frame: CGRect(x: 0,y:5*DeviceMultiplier,width:30*DeviceMultiplier,height:30*DeviceMultiplier), fontName:fontNameBtn, fontSize: BtnFontsize, textColor: PrimaryTextColor, text: "", backgroundColor: .clear)
        cartbtn.tintColor = NavTitleColor

        cartbtn.setImage(UIImage(named: "CartIcon")?.withRenderingMode(.alwaysTemplate), for: .normal)
        cartbtn.imageView?.contentMode = .scaleAspectFit
        let cartbarButton = UIBarButtonItem()
        cartbarButton.customView = cartbtn
        cartbtn.addTarget(self, action: #selector(method), for: UIControl.Event.touchUpInside)
        
        self.navigationItem.rightBarButtonItems = [cartbarButton,searchbarButton]
    }
}
extension UIView{
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    @IBInspectable
    var borderColor: UIColor {
        get {
            return UIColor(cgColor: layer.borderColor ?? UIColor.white.cgColor)
        }
        set {
            layer.borderColor = newValue.cgColor
        }
    }
    
    func rotateInArabic(){
        if !Globals.isEnglishLang(){
            self.transform = CGAffineTransform(scaleX: -1, y: 1)
        }
    }
}

extension UIButton {
    func underline() {
        guard let text = self.titleLabel?.text else { return }
        let attributedString = NSMutableAttributedString(string: text)
        //NSAttributedStringKey.foregroundColor : UIColor.blue
        attributedString.addAttribute(NSAttributedString.Key.underlineColor, value: self.titleColor(for: .normal)!, range: NSRange(location: 0, length: text.count))
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: self.titleColor(for: .normal)!, range: NSRange(location: 0, length: text.count))
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: text.count))
        self.setAttributedTitle(attributedString, for: .normal)
    }
}



extension UILabel {
    func underline() {
        if let textString = self.text {
            let attributedString = NSMutableAttributedString(string: textString)
            attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: attributedString.length - 1))
            attributedText = attributedString
        }
    }
}
