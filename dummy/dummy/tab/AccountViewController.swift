//
//  AccountViewController.swift
//  dummy
//
//  Created by Inovant Solutions on 31/12/22.
//

import UIKit

class AccountViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    private let tableCellIdentifier: String = "AccountCell"
    private var titleArray:[(titleStr: String, iconStr: String)] = [(titleStr: String, iconStr: String)]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.generateTitleArray()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: tableCellIdentifier)
        self.tableView.separatorStyle = .none
        self.tableView.bounces = true;
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = UITableView.automaticDimension
        self.tableView.backgroundColor = BgColor
        
        self.setupHeader()
        // Do any additional setup after loading the view.
    }
    
    func setupHeader(){
        let container = Globals.makeContainerView(rect: CGRect(x: 0, y: 0, width: DeviceWidth, height: 140*DeviceMultiplier), bgColor: BgColor)
        self.tableView.tableHeaderView = container
        
        let innerContainer = Globals.makeContainerView(rect: .zero, bgColor: LightGrayBGColor.withAlphaComponent(0.7))
        container.addSubview(innerContainer)
        innerContainer.addDirectConstaints(constaintAndValue: [.Top:DeviceMargine,.Leading:DeviceMargine,.Trailing:DeviceMargine,.Bottom:20*DeviceMultiplier])
        
        let userImgview = Globals.makeImageView(frame: .zero, url: "", contentMode: .scaleAspectFill)
        userImgview.image = UIImage(named: "EditProfileIcon")
        innerContainer.addSubview(userImgview)
        userImgview.addDirectConstaints(constaintAndValue: [.FixWidth:30,.FixHeight:30,.Leading:10,.CenterY:0],addDeviceMultiplier: true)
        
        let nameContainer = Globals.makeContainerView(rect: .zero, bgColor: .clear)
        innerContainer.addSubview(nameContainer)
        nameContainer.rightTo(view: userImgview, constant: 10*DeviceMultiplier)
        nameContainer.addDirectConstaints(constaintAndValue: [.Trailing:0,.FixHeight:30,.CenterY:0],addDeviceMultiplier: true)
        
        let titleLbl = Globals.makeLabel(frame: .zero, fontName: fontNameRegular, fontSize: SubTitleFontsize, textColor: TertiaryTextColor, text: Globals.GetStringForKey(key: "Welcome"))
        nameContainer.addSubview(titleLbl)
        titleLbl.addDirectConstaints(constaintAndValue: [.Trailing:0,.FixHeight:15,.Leading:0,.Top:0],addDeviceMultiplier: true)
        
        let nameLbl = Globals.makeLabel(frame: .zero, fontName: fontNameBold, fontSize: SubTitleFontsize, textColor: TertiaryTextColor, text: Globals.GetStringForKey(key: "user name"))
        nameContainer.addSubview(nameLbl)
        nameLbl.belowTo(view: titleLbl, constant: 0)
        nameLbl.addDirectConstaints(constaintAndValue: [.Trailing:0,.FixHeight:15,.Leading:0],addDeviceMultiplier: true)
        
        let editBtn = Globals.makeButton(frame: .zero, fontName: fontNameRegular, fontSize: DetailFontsize, textColor: PrimaryTextColor, text: Globals.GetStringForKey(key: "Edit"), backgroundColor: .clear)
        editBtn.underline()
        nameContainer.addSubview(editBtn)
        editBtn.addDirectConstaints(constaintAndValue: [.Trailing:0,.FixHeight:12.5,.FixWidth:40,.CenterY:0],addDeviceMultiplier: true)
        
        let divLine = Globals.makeDividerLine(Frame: .zero)
        divLine.backgroundColor = PinkColor
        innerContainer.addSubview(divLine)
        divLine.addDirectConstaints(constaintAndValue: [.Trailing:0,.FixHeight:3.5,.Bottom:0,.Leading:0],addDeviceMultiplier: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.titleArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50*DeviceMultiplier
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: tableCellIdentifier, for: indexPath)
        for subView in cell.contentView.subviews  {
            subView.removeFromSuperview()
        }
        cell.selectionStyle = .none
        cell.backgroundColor  = .clear
        
        let view = self.makeAccountView(titleStr: self.titleArray[indexPath.row].titleStr, iconStr: self.titleArray[indexPath.row].iconStr)
        cell.contentView.addSubview(view)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch self.titleArray[indexPath.row].titleStr{
        case Globals.GetStringForKey(key: "Edit Profile"):
            let editVc = HomeViewController()
            editVc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(editVc, animated: true)
            break
        case Globals.GetStringForKey(key: "My Orders"):
            let orderVc = HomeViewController()
            orderVc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(orderVc, animated: true)
            break
        case Globals.GetStringForKey(key: "Wishlist"):
            let wishlistVc = HomeViewController()
            wishlistVc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(wishlistVc, animated: true)
            break
        case Globals.GetStringForKey(key: "My Addresses"):
            let addressVc = HomeViewController()
            addressVc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(addressVc, animated: true)
            break
        case Globals.GetStringForKey(key: "Earn Rewards"):
            let rewardVc = HomeViewController()
            rewardVc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(rewardVc, animated: true)
            break
        case Globals.GetStringForKey(key: "Change Language"):
            self.changeLangPopUp()
            break
        case Globals.GetStringForKey(key: "Change Country"):
            let countryVc = HomeViewController()
            countryVc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(countryVc, animated: true)
            break
        case Globals.GetStringForKey(key: "Help"):
            let helpVc = HomeViewController()
            helpVc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(helpVc, animated: true)
            break
        case Globals.GetStringForKey(key: "Sign Out"):
            break
        default:break
        }
    }

}


extension AccountViewController{
    func makeAccountView(titleStr: String, iconStr: String) -> UIView{
        let container = Globals.makeContainerView(rect: CGRect(x: DeviceMargine, y: 0, width: DeviceWidth - (DeviceMargine*2), height: 50*DeviceMultiplier), bgColor: BgColor)
        
        let viewBtn = Globals.makeButton(frame: .zero, fontName: fontNameSemiBold, fontSize: TitleFontsize, textColor: SecondaryTextColor, text: titleStr, backgroundColor: .clear)
        viewBtn.isUserInteractionEnabled = false
        container.addSubview(viewBtn)
        viewBtn.addDirectConstaints(constaintAndValue: [.Leading:0,.Trailing:0,.Top:0,.Bottom:0])
        viewBtn.setImage(UIImage(named: iconStr), for: .normal)
        viewBtn.contentHorizontalAlignment = Globals.isEnglishLang() ? .left : .right
        viewBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: Globals.isEnglishLang() ? 0 : 15*DeviceMultiplier, bottom: 0, right: Globals.isEnglishLang() ? 15*DeviceMultiplier: 0)
        
        let arrow = Globals.makeImageView(frame: .zero, url: "", contentMode: .scaleAspectFill)
        arrow.image = UIImage(named: "BrandTabIcon")
        container.addSubview(arrow)
        arrow.addDirectConstaints(constaintAndValue: [.Trailing:0,.CenterY:0,.FixWidth:6,.FixHeight:10],addDeviceMultiplier: true)
        
        if titleStr == Globals.GetStringForKey(key: "Change Language"){
            
            let langLbl = Globals.makeLabel(frame: .zero, fontName: fontNameRegular, fontSize: DetailFontsize, textColor: PrimaryTextColor, text: Globals.isEnglishLang() ? "العربية" : "English")
            langLbl.textAlignment = Globals.isEnglishLang() ? .right : .left
            container.addSubview(langLbl)
            langLbl.leftTo(view: arrow, constant: 5*DeviceMultiplier)
            langLbl.addDirectConstaints(constaintAndValue: [.FixHeight:12.5,.FixWidth:100,.CenterY:0],addDeviceMultiplier: true)
            
        }else if titleStr == Globals.GetStringForKey(key: "Change Country"){
            let countryImage = Globals.makeImageView(frame: .zero, url: sceneDelegate.selectedCountry.flag, contentMode: .scaleAspectFill)
            container.addSubview(countryImage)
            countryImage.leftTo(view: arrow, constant: 5*DeviceMultiplier)
            countryImage.addDirectConstaints(constaintAndValue: [.FixHeight:20*DeviceMultiplier,.FixWidth:20*DeviceMultiplier,.CenterY:0])
            
        }
        
        return container
    }
    func generateTitleArray(){
        self.titleArray.removeAll()
        
//        if Globals.isUserLoggedIn(){
            let titleArr = ["Edit Profile","My Orders","Wishlist","My Addresses","Earn Rewards","Change Language","Change Country","Help","Sign Out"]
            let iconArr = ["AddressIcon","AddressIcon","AddressIcon","AddressIcon","AddressIcon","AddressIcon","AddressIcon","AddressIcon","AddressIcon"]
            
            for index in 0..<titleArr.count{
                self.titleArray.append((titleStr:titleArr[index],iconStr:iconArr[index]))
            }
//        }else{
//            let titleArr = ["Change Language","Change Country","Help"]
//            let iconArr = ["AddressIcon","AddressIcon","AddressIcon"]
//
//            for index in 0..<titleArr.count{
//                self.titleArray.append((titleStr:titleArr[index],iconStr:iconArr[index]))
//            }
//        }
    }
    
         func changeLangPopUp(){
            let alert = UIAlertController(title: Globals.isEnglishLang() ?"هل انت متأكد؟":"Are you sure?",
                                          message: Globals.isEnglishLang() ? "تريد تغيير لغتك إلى العربية؟" : "You want to change your language\nto english?",
                                          preferredStyle: .alert)
            let noAction = UIAlertAction(title: NSLocalizedString(Globals.isEnglishLang() ?  "لا" : "NO", comment: "Default action"), style: .default, handler: { _ in })
            alert.addAction(noAction)
            let yesAction = UIAlertAction(title: NSLocalizedString(Globals.isEnglishLang() ? "نعم" :"YES", comment: "Default action"), style: .default, handler: { _ in
                if(Globals.isEnglishLang()){
                    sceneDelegate.isEnglish = false
                }else{
                    sceneDelegate.isEnglish = true
                }
                
                UserDefaults.standard.set(sceneDelegate.isEnglish, forKey: "isEnglishLang")
                
                Globals.setFonts();
            
            })
            alert.addAction(yesAction)
            
            noAction.setValue(UIColor.black, forKey: "titleTextColor")
            yesAction.setValue(UIColor.black, forKey: "titleTextColor")
            
            self.present(alert, animated: true, completion: nil)
    }
}
