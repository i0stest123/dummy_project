//
//  Autolayout.swift
//  Eknathrao Khadse
//
//  Created by Mahalaxmi101 on 25/12/18.
//  Copyright © 2018 Mahalaxmi101. All rights reserved.
//


import Foundation
import UIKit

enum ConstaintsType{
    case Leading
    case Trailing
    case Top
    case Bottom
    case FixHeight
    case FixWidth
    case LeftTo
    case RightTo
    case AboveTo
    case BelowTo
    case CenterX
    case CenterY
    case HeightLessThenEqualTo
    case WidthLessThenEqualTo
    case HeightGreatherThenEqualTo
    case WidthGreatherThenEqualTo
    case CenterXToView
    case CenterYToView
    case EqualHeightTo
}
extension UIView {
    func addDirectConstaints(constaintAndValue:[ConstaintsType:CGFloat],addDeviceMultiplier:Bool = false){
        if !constaintAndValue.isEmpty{
            for constaint in constaintAndValue.keys{
                var constaintValue = constaintAndValue[constaint]!
                if addDeviceMultiplier{
                    constaintValue = constaintAndValue[constaint]!*DeviceMultiplier
                }
                switch constaint{
                case .Leading:
                    self.leading(constant: constaintValue)
                case .Trailing:
                    self.trailing(constant: constaintValue)
                case .Top:
                    self.top(constant: constaintValue)
                case .Bottom:
                    self.bottom(constant: constaintValue)
                case .FixHeight:
                    self.fixHeight(constant: constaintValue)
                case .FixWidth:
                    self.fixWidth(constant: constaintValue)
                case .CenterX:
                    self.centerX()
                case .CenterY:
                    self.centerY()
                case .HeightLessThenEqualTo:
                    self.heightlessthanEqual(constant: constaintValue)
                case .WidthLessThenEqualTo:
                    self.heightlessthanEqual(constant: constaintValue)
                case .HeightGreatherThenEqualTo:
                    self.heightlessthanEqual(constant: constaintValue)
                case .WidthGreatherThenEqualTo:
                    self.heightlessthanEqual(constant: constaintValue)
                default:
                    break
                }
            }
        }
    }
    
    func addConstaintsRespectToView(constaintViewValue:[(ConstaintsType,UIView,CGFloat)], addDeviceMultiplier:Bool = false){
        if !constaintViewValue.isEmpty{
            for index in 0...constaintViewValue.count-1{
                let constaintViewValueTuple = constaintViewValue[index]
                let constaint = constaintViewValueTuple.0
                let constaintView = constaintViewValueTuple.1
                var constantValue = constaintViewValueTuple.2
                if addDeviceMultiplier{
                    constantValue = constaintViewValueTuple.2*DeviceMultiplier
                }
                switch constaint{
                case .LeftTo:
                    self.leftTo(view: constaintView, constant: constantValue)
                case .RightTo:
                    self.rightTo(view: constaintView, constant: constantValue)
                case .AboveTo:
                    self.aboveTo(view: constaintView, constant: constantValue)
                case .BelowTo:
                    self.belowTo(view: constaintView, constant: constantValue)
                case .CenterXToView:
                    self.centerXToView(view: constaintView)
                case .CenterYToView:
                    self.centerYToView(view: constaintView)
                default:
                    break
                }
            }
        }
    }
    
    func addConstaintsToPinHorizontalEdgesToSuperView(padding: CGFloat = 0) {
        prepareForConstraints()
        self.superview!.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(padding)-[view]-(padding)-|",
                                                                      options: NSLayoutConstraint.FormatOptions(rawValue: 0),
                                                                      metrics: ["padding":padding],
                                                                      views: ["view":self]))
    }
    
    func addConstaintsToPinVerticalEdgesToSuperView(padding: CGFloat = 0) {
        prepareForConstraints()
        self.superview!.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(padding)-[view]-(padding)-|",
                                                                      options: NSLayoutConstraint.FormatOptions(rawValue: 0),
                                                                      metrics: ["padding":padding],
                                                                      views: ["view":self]))
    }
    
    func centerY() {
        prepareForConstraints()
        self.superview!.addConstraint(NSLayoutConstraint(item: self,
                                                         attribute: .centerY,
                                                         relatedBy: .equal,
                                                         toItem: self.superview!,
                                                         attribute: .centerY,
                                                         multiplier: 1.0, constant: 0))
    }
    
    func centerX() {
        prepareForConstraints()
        self.superview!.addConstraint(NSLayoutConstraint(item: self,
                                                         attribute: .centerX,
                                                         relatedBy: .equal,
                                                         toItem: self.superview!,
                                                         attribute: .centerX,
                                                         multiplier: 1.0, constant: 0))
    }
    
    func centerYToView(view:UIView) {
        prepareForConstraints()
        self.superview!.addConstraint(NSLayoutConstraint(item: self,
                                                         attribute: .centerY,
                                                         relatedBy: .equal,
                                                         toItem: view,
                                                         attribute: .centerY,
                                                         multiplier: 1.0, constant: 0))
    }
    
    func centerXToView(view:UIView) {
        prepareForConstraints()
        self.superview!.addConstraint(NSLayoutConstraint(item: self,
                                                         attribute: .centerX,
                                                         relatedBy: .equal,
                                                         toItem: view,
                                                         attribute: .centerX,
                                                         multiplier: 1.0, constant: 0))
    }
    
    func heightlessthanEqual(constant: CGFloat) {
        prepareForConstraints()
        let heightConstraint = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.lessThanOrEqual, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: constant)
        self.superview!.addConstraint(heightConstraint)
    }
    
    func widthlessthanEqual(constant: CGFloat) {
        prepareForConstraints()
        let heightConstraint = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.lessThanOrEqual, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: constant)
        self.superview!.addConstraint(heightConstraint)
    }
    
    func heightgreaterthanEqual(constant: CGFloat) {
        prepareForConstraints()
        let heightConstraint = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.greaterThanOrEqual, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: constant)
        self.superview!.addConstraint(heightConstraint)
    }
    
    func widthgreaterthanEqual(constant: CGFloat) {
        prepareForConstraints()
        let heightConstraint = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.greaterThanOrEqual, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: constant)
        self.superview!.addConstraint(heightConstraint)
    }
    
    func leading(constant: CGFloat)  {
        prepareForConstraints()
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: .leading,
                                            relatedBy: .equal,
                                            toItem: self.superview!,
                                            attribute: .leading,
                                            multiplier: 1, constant: constant)
        self.superview!.addConstraint(constraint)
    }
    
    func trailing(constant: CGFloat)  {
        prepareForConstraints()
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: .trailing,
                                            relatedBy: .equal,
                                            toItem: self.superview!,
                                            attribute: .trailing,
                                            multiplier: 1, constant: -(constant))
        self.superview!.addConstraint(constraint)
    }
    
    func top(constant: CGFloat) {
        prepareForConstraints()
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: .top,
                                            relatedBy: .equal,
                                            toItem: self.superview!,
                                            attribute: .top,
                                            multiplier: 1, constant: constant)
        self.superview!.addConstraint(constraint)
    }
    
    func bottom(constant: CGFloat) {
        prepareForConstraints()
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: .bottom,
                                            relatedBy: .equal,
                                            toItem: self.superview!,
                                            attribute: .bottom,
                                            multiplier: 1, constant: -(constant))
        self.superview!.addConstraint(constraint)
    }
    
    func fixHeight(constant: CGFloat){
        
        prepareForConstraints()
        let heightConstraint = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: constant)
        self.superview!.addConstraint(heightConstraint)
        
    }
    
    func fixWidth(constant: CGFloat)
    {
        prepareForConstraints()
        let widthConstraint = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: constant)
        self.superview!.addConstraint(widthConstraint)
        
    }
    
    func aboveTo(view:UIView,constant: CGFloat) {
        prepareForConstraints()
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: .bottom,
                                            relatedBy: .equal,
                                            toItem: view,
                                            attribute: .top,
                                            multiplier: 1, constant: -(constant))
        self.superview!.addConstraint(constraint)
    }
    
    func belowTo(view:UIView,constant: CGFloat) {
        prepareForConstraints()
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: .top,
                                            relatedBy: .equal,
                                            toItem: view,
                                            attribute: .bottom,
                                            multiplier: 1, constant: constant)
        
        self.superview!.addConstraint(constraint)
    }
    
    func rightTo(view:UIView,constant: CGFloat) {
        prepareForConstraints()
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: Globals.isEnglishLang() ? .left:.right,
                                            relatedBy: .equal,
                                            toItem: view,
                                            attribute: Globals.isEnglishLang() ? .right:.left,
                                            multiplier: 1, constant: Globals.isEnglishLang() ? constant:-constant)
        self.superview!.addConstraint(constraint)
    }
    
    func leftTo(view:UIView,constant: CGFloat) {
        prepareForConstraints()
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: Globals.isEnglishLang() ? .right:.left,
                                            relatedBy: .equal,
                                            toItem: view,
                                            attribute: Globals.isEnglishLang() ? .left:.right,
                                            multiplier: 1, constant: Globals.isEnglishLang() ? -constant:constant)
        self.superview!.addConstraint(constraint)
    }
    
    func addConstaintsToFillSuperviewWithPadding(padding: CGFloat = 0) {
        prepareForConstraints()
        addConstaintsToPinHorizontalEdgesToSuperView(padding: padding)
        addConstaintsToPinVerticalEdgesToSuperView(padding: padding)
    }
    
    private func prepareForConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        if superview == nil {
            assert(false, "You need to have a superview before you can add contraints")
        }
    }
}

