//
//  ChatViewController.swift
//  Elevator
//
//  Created by InovantSolutions on 13/12/22.
//

//import UIKit
//import DZNEmptyDataSet
//
//class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
//    
//    @IBOutlet weak var tableView: UITableView!
//    
//    private let tableViewCellReuseableIdentifier: String = "chatTableViewCell"
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.view.backgroundColor = BlueBgColor
//        
//        Globals.setupTabBarScreenNavigationItems(self)
//        
//        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: tableViewCellReuseableIdentifier)
//        self.tableView.separatorStyle = .none
//        self.tableView.bounces = true;
//        self.tableView.delegate = self
//        self.tableView.dataSource = self
//        self.tableView.separatorStyle = .none
//        self.tableView.rowHeight = UITableView.automaticDimension
//        self.tableView.estimatedRowHeight = UITableView.automaticDimension
//        self.tableView.backgroundColor = BgColor
//        self.tableView.cornerRadius = 15*DeviceMultiplier
//        self.tableView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
//        
//        self.tableView.checkEmptyDataSet(array: [], self )
//
//        // Do any additional setup after loading the view.
//    }
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 0
//    }
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//       return 70*DeviceMultiplier
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: tableViewCellReuseableIdentifier, for: indexPath)
//        for subView in cell.contentView.subviews  {
//            subView.removeFromSuperview()
//        }
//        cell.selectionStyle = .none
//        cell.backgroundColor  = .clear
//        
//        let container = Globals.makeContainerView(rect: .zero, bgColor: .clear)
//        cell.contentView.addSubview(container)
//        container.addDirectConstaints(constaintAndValue: [.Top:0,.Bottom:0,.Leading:0,.Trailing:0],addDeviceMultiplier: true)
////        container.backgroundColor = .cyan
//        
//        let profileImage = Globals.makeImageView(frame: .zero, url: "", contentMode: .scaleAspectFit)
//        profileImage.image = UIImage(named: "UserProfileIcon")
//        container.addSubview(profileImage)
//        profileImage.addDirectConstaints(constaintAndValue: [.Leading:DeviceMargine,.Top:20,.FixHeight:45,.FixWidth:45],addDeviceMultiplier: true)
//        
//        let userLable = Globals.makeLabel(frame: CGRect.zero, fontName: fontNameBold, fontSize: TitleFontsize2, textColor: SecondaryTextColor, text: "Jon Ferguson")
//        container.addSubview(userLable)
//        userLable.addDirectConstaints(constaintAndValue: [.Trailing:30*DeviceMultiplier,.Top:25*DeviceMultiplier,.FixHeight:20*DeviceMultiplier])
//        userLable.rightTo(view: profileImage, constant: 10*DeviceMultiplier)
////        userLable.backgroundColor = .blue
//        
//        let timeLable = Globals.makeLabel(frame: CGRect.zero, fontName: fontNameRegular, fontSize: DetailFontsize, textColor: SecondaryTextColor, text: "09:45")
//        container.addSubview(timeLable)
//        timeLable.addDirectConstaints(constaintAndValue: [.Trailing:DeviceMargine,.Top:25*DeviceMultiplier,.FixHeight:20*DeviceMultiplier,.FixWidth:30*DeviceMultiplier])
////        timeLable.backgroundColor = .brown
//        
//        let tikeImage = Globals.makeImageView(frame: .zero, url: "", contentMode: .scaleAspectFit)
//        tikeImage.image = UIImage(named: "ReadTikeIcon")
//        container.addSubview(tikeImage)
//        tikeImage.addDirectConstaints(constaintAndValue: [.FixHeight:15,.FixWidth:15],addDeviceMultiplier: true)
//        tikeImage.addConstaintsRespectToView(constaintViewValue: [(.RightTo, profileImage, 10*DeviceMultiplier),(.BelowTo,userLable,5*DeviceMultiplier)])
////        tikeImage.backgroundColor = .red
//        
//        let massageLable = Globals.makeLabel(frame: CGRect.zero, fontName: fontNameRegular, fontSize: SubTitleFontsize, textColor: SecondaryTextColor, text: "Send me property config. & photos.")
//        container.addSubview(massageLable)
//        massageLable.addDirectConstaints(constaintAndValue: [.FixHeight:20*DeviceMultiplier,.Trailing:DeviceMargine])
//        massageLable.addConstaintsRespectToView(constaintViewValue: [(.RightTo, tikeImage, 5*DeviceMultiplier),(.BelowTo,userLable,0*DeviceMultiplier)])
//        return cell
//    }
//    
//    func customView(forEmptyDataSet scrollView: UIScrollView) -> UIView? {
//        let title = Globals.GetStringForKey(key:"Oops No Chat")
//        let subTitleText = Globals.GetStringForKey(key:"You don't have any Chat")
//
//        return Globals.makeEmptyView(titleText: title, subtitleText:subTitleText)
//    }
//    
//    
//
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}
