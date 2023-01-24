//
//  MultiTagViews.swift
//  Elevator
//
//  Created by Inovant Solutions on 08/12/22.
//

import UIKit
import Foundation

class MultiTag_UIButton: UIButton {
    var tag2:Int = 0
    var tag3:Int = 0
    var setToTag:Int = 0
    lazy var customObject : Any? = nil
    lazy var dataForShare:(id: String, shareType: String, name: String, imageUrl:String, shareDesc: String)  = (id : "", shareType : "", name : "", imageUrl : "", shareDesc : "")
    var functionalValue:String = ""
    var customType:Any?
    var customBoolean:Bool = false
}

class MultiTag_UIView: UIView {
    var tag2:Int = 0
    var customObject : Any? = nil
}
class Multitag_UIImageView: UIImageView {
    var tag2:Int = 0
    lazy var customObject : Any? = nil
    lazy var target:UIViewController = UIViewController()
}

class ViewWithTag: UIView {
    var tag2:Int = 0
}
