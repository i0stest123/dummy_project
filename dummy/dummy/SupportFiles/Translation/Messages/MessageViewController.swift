

import UIKit

class MessageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextViewDelegate, QuickstartChatManagerDelegate{

    private var tableView: UITableView = UITableView()
    private let messageTableIdentifier: String = "MessageTableCell"
    private var txtView: UITextView = UITextView()
    private var my_token: String = ""
    private var my_channel_id: String = ""
    internal var userId: String = ""
    internal var oppositeUserId: String = ""
    private let chatManager: QuickstartChatManager = QuickstartChatManager()
    private var dateArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.chatManager.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.getTokenAndChannelId()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.deregisterFromKeyboardNotifications()
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        chatManager.loginWithAccessToken("")
//    }
//
    override func viewDidDisappear(_ animated: Bool) {
        self.chatManager.shutdown()
    }
    
    func loginToChat(){
        if self.my_token.count > 0 && self.my_channel_id.count > 0 {
            chatManager.login(self.my_token, self.my_channel_id){
                result in
                self.setViewForMessage()
                if !result{
                    Globals.showSucess(title: Globals.GetStringForKey(key:"Unable to login - check the token URL"))
                }
                print("result after response in twilio \(result)")
            }
        } else {
            Globals.showSucess(title: Globals.GetStringForKey(key:"Unable to login - check the token URL"))
        }
    }
    
    private func setViewForMessage(){
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: messageTableIdentifier)
        self.tableView.separatorStyle = .none
        self.tableView.bounces = true;
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = UITableView.automaticDimension
        self.tableView.backgroundColor = BgColor
        
        self.view.addSubview(self.tableView)
        self.tableView.addDirectConstaints(constaintAndValue: [.Top:0,.Leading:0,.Trailing:0,.Bottom:80],addDeviceMultiplier: true)
        
        self.tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: DeviceWidth, height: 15*DeviceMultiplier))
        
        let bottomContainer = Globals.makeContainerView(rect: CGRect.zero, bgColor: .white)
        self.view.addSubview(bottomContainer)
        bottomContainer.belowTo(view: self.tableView, constant: 0*DeviceMultiplier)
        bottomContainer.addDirectConstaints(constaintAndValue: [.Leading:0,.Trailing:0,.Bottom:0],addDeviceMultiplier: true)
        
        let divLine = Globals.makeDividerLine(Frame: CGRect(x: 0, y: 0, width: DeviceWidth, height: 1*DeviceMultiplier))
        divLine.backgroundColor = .gray.withAlphaComponent(0.5)
        bottomContainer.addSubview(divLine)
        
        let addBtn = Globals.makeButton(frame: .zero, fontName: fontNameBtn, fontSize: BtnFontsize, textColor: .gray, text: "", backgroundColor: .gray.withAlphaComponent(0.3))
        addBtn.setToTag = 1
        addBtn.cornerRadius = 35*DeviceMultiplier/2
//        addBtn.addTarget(self, action: #selector(self.uploadDocumentAction(_:)), for: .touchUpInside)
        addBtn.setImage(UIImage(named: "AddIcon")?.withTintColor(.white), for: .normal)
        bottomContainer.addSubview(addBtn)
        addBtn.belowTo(view: divLine, constant: 7.5*DeviceMultiplier)
        addBtn.addDirectConstaints(constaintAndValue: [.Leading:DeviceMargine,.FixHeight:35*DeviceMultiplier, .FixWidth:35*DeviceMultiplier])
        
        self.txtView.textAlignment = Globals.isEnglishLang() ? .left : .right
        self.txtView.textContainerInset = UIEdgeInsets(top: 10*DeviceMultiplier, left: Globals.isEnglishLang() ? 35*DeviceMultiplier : 20*DeviceMultiplier, bottom: 5*DeviceMultiplier, right: Globals.isEnglishLang() ? 20*DeviceMultiplier : 35*DeviceMultiplier)
        self.txtView.backgroundColor = .gray.withAlphaComponent(0.3)
        self.txtView.textColor =  TextFieldTextColor
        self.txtView.cornerRadius = 10*DeviceMultiplier
        self.txtView.delegate = self
        bottomContainer.addSubview(self.txtView)
        self.txtView.belowTo(view: divLine, constant: 7.5*DeviceMultiplier)
        self.txtView.addDirectConstaints(constaintAndValue: [.Leading:DeviceMargine+40*DeviceMultiplier,.Trailing:DeviceMargine+15*DeviceMultiplier,.FixHeight:35*DeviceMultiplier])
        
        let leftView = Globals.makeContainerView(rect:.zero, bgColor: .clear)
        leftView.isUserInteractionEnabled = true
//        leftView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openEmojiView)))
        let textIcon = UIImageView()
        textIcon.frame = CGRect(x: 10*DeviceMultiplier, y: 7.5*DeviceMultiplier, width:20*DeviceMultiplier, height: 20*DeviceMultiplier)
        textIcon.image = UIImage(named: "SmilingFace")
        leftView.addSubview(textIcon)
        bottomContainer.addSubview(leftView)
        leftView.belowTo(view: divLine, constant: 7.5*DeviceMultiplier)
        leftView.addDirectConstaints(constaintAndValue: [.Leading:DeviceMargine+40*DeviceMultiplier,.FixHeight:35*DeviceMultiplier,.FixWidth:35*DeviceMultiplier])
        

        let sendBtn = Globals.makeButton(frame: .zero, fontName: fontNameBtn, fontSize: BtnFontsize, textColor: .systemBlue, text: "", backgroundColor: .clear)
        sendBtn.setImage(UIImage(named: "SendMessage"), for: .normal)
        sendBtn.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        sendBtn.imageView?.contentMode = .scaleAspectFit
        sendBtn.imageView?.centerX()
        sendBtn.imageView?.centerY()
        sendBtn.imageView?.fixWidth(constant: 15*DeviceMultiplier)
        sendBtn.imageView?.fixHeight(constant: 15*DeviceMultiplier)
        sendBtn.backgroundColor = SecondaryTextColor
        sendBtn.cornerRadius = 15*DeviceMultiplier
        bottomContainer.addSubview(sendBtn)
        sendBtn.belowTo(view: divLine, constant: 10*DeviceMultiplier)
        sendBtn.addDirectConstaints(constaintAndValue: [.Trailing:DeviceMargine+5*DeviceMultiplier,.FixHeight:30*DeviceMultiplier, .FixWidth:30*DeviceMultiplier])
    }
    
    // MARK: Keyboard Dodging Logic
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            self.view.frame.origin.y = -250*DeviceMultiplier
        }
    }
    
    @objc func keyboardDidShow(notification: NSNotification) {
        self.scrollToBottomMessage()
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 0.1, animations: { () -> Void in
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
                self.view.frame.origin.y = 250*DeviceMultiplier
              }
        })
    }
    
    func registerForKeyboardNotifications(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification,object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow), name: UIResponder.keyboardDidShowNotification,object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification,object: nil)
    }

    func deregisterFromKeyboardNotifications(){
        //Removing notifies on keyboard appearing
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification,object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidShowNotification,object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification,object: nil)

    }
    
    func reloadMessages() {
        self.tableView.reloadData()
    }
    
    func receivedNewMessage() {
        self.scrollToBottomMessage()
    }
    
    
    private func scrollToBottomMessage() {
        if chatManager.messages.count == 0 {
            return
        }
        let bottomMessageIndex = IndexPath(row: chatManager.messages.count - 1,
                                           section: 0)
        tableView.scrollToRow(at: bottomMessageIndex, at: .bottom, animated: true)
    }

}

extension MessageViewController{
    
    @objc func sendMessage(){
        if self.txtView.text != ""{
            chatManager.sendMessage(txtView.text!, completion: { (result, _) in
                if result.isSuccessful(){
                    self.txtView.text = ""
                } else {
                    Globals.showError(title: Globals.GetStringForKey(key: "Unable to send message"))
                }
            })
        }
        
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.chatManager.messages.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: messageTableIdentifier, for: indexPath)
        for subView in cell.contentView.subviews  {
            subView.removeFromSuperview()
        }
        cell.selectionStyle = .none
        cell.backgroundColor  = .clear
        
        if self.chatManager.messages.count > 0 {
            let obj = self.chatManager.messages[indexPath.row]

            if indexPath.row == 0 && (obj.dateCreated?.count ?? 0) > 0  {
                let formattedDate = Globals.changeDateFormat(strTimeOrignal: obj.dateCreated  ?? "", inputFormat: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z", outputFormat: "yyyy-MM-dd")
                
                let titleLbl = Globals.makeLabel(frame: CGRect.zero, fontName: fontNameBold, fontSize: HeaderFontSize, textColor: .black, text: formattedDate)
                titleLbl.textAlignment = .center
                cell.contentView.addSubview(titleLbl)
                titleLbl.addDirectConstaints(constaintAndValue: [.Top:20*DeviceMultiplier,.FixHeight:60*DeviceMultiplier,.Leading:DeviceMargine,.Trailing:DeviceMargine])
            }
            
            
            let formattedDate = Globals.changeDateFormat(strTimeOrignal: obj.dateCreated  ?? "", inputFormat: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z", outputFormat: "HH:mm a")   
            
            let container = makeMessageView(message: obj.body ?? "", time: formattedDate, isParticipant: obj.author != "4", sentImage: obj.mediaFilename ?? "")
            cell.contentView.addSubview(container)
            container.addDirectConstaints(constaintAndValue: [.Top:indexPath.row == 0  ? 70*DeviceMultiplier :0,.Bottom:0,.Leading:0,.Trailing:0])
        }
        
        return cell
    }
    
    @objc func getTokenAndChannelId(){
        self.chatManager.shutdown()
        let url = Host + "chat-init"
        let params:[String: Any] = [
            "from_id" :4,
            "to_id" :7
        ]
        ApiManager.shared.sendDataToServer(url, parameters: params, completion: {[weak self](response, status) in
            if(response != nil && status == "SUCCESS"){
                let status = response?.object(forKey: "status") as? NSNumber ?? 0
                let message = response?.object(forKey: "message") as? String ?? ""
                let data = response?.object(forKey: "data") as? NSDictionary ?? [:]

                if status  == 200 {
                    self?.my_token = data["token"] as? String ?? ""
                    self?.my_channel_id = data["channel_id"] as? String ?? ""
                    self?.loginToChat()
                }else{
                    Globals.showError(title: message)
                }
            }else {
                Globals.showError(title: Globals.GetStringForKey(key: "ERROR CONNECTION"))
            }

        })
    }
    
    
    func makeMessageView(message: String , time: String, isParticipant: Bool , sentImage: String = "") -> UIView {
        let width = DeviceWidth - (DeviceMargine*2) - 100*DeviceMultiplier
        let container = Globals.makeContainerView(rect: CGRect.zero, bgColor: .clear)
        let timeLbl = Globals.makeLabel(frame: CGRect.zero, fontName: fontNameRegular, fontSize: DetailFontsize, textColor: .gray, text: time)
        timeLbl.textAlignment = isParticipant ? .left : .right
        container.addSubview(timeLbl)
        timeLbl.addDirectConstaints(constaintAndValue: [.Top:10*DeviceMultiplier,.Leading:DeviceMargine, .FixHeight:15*DeviceMultiplier, .FixWidth: DeviceWidth - (DeviceMargine*2)])
        
        if sentImage.isEmpty{
            let msgContainer = Globals.makeContainerView(rect: .zero, bgColor: isParticipant ? .systemBlue.withAlphaComponent(0.2): .systemRed.withAlphaComponent(0.2))
            container.addSubview(msgContainer)
            msgContainer.belowTo(view: timeLbl, constant: 2.5*DeviceMultiplier)
            if isParticipant{
                msgContainer.leading(constant: DeviceMargine)
            }else{
                msgContainer.trailing(constant: DeviceMargine)
            }
            let textWidth = Globals.getTextWidth(text: message, font: UIFont(name: fontNameRegular, size: DetailFontsize)!, constrainedSize: CGSize(width: 999, height: 99))+30*DeviceMultiplier
            
            msgContainer.addDirectConstaints(constaintAndValue: [.Bottom:0, .FixWidth: textWidth < width ? textWidth : width])
            
            let messageLbl =  Globals.makeLabel(frame: CGRect.zero, fontName: fontNameRegular, fontSize: DetailFontsize, textColor: SecondaryTextColor, text: message)
            msgContainer.addSubview(messageLbl)
            messageLbl.addDirectConstaints(constaintAndValue: [.Top:10,.Leading:10, .Bottom:10, .Trailing: 10],addDeviceMultiplier: true)
        }
        else{
            let msgContainer = Globals.makeContainerView(rect: .zero, bgColor:  isParticipant ? .systemBlue.withAlphaComponent(0.2): .systemRed.withAlphaComponent(0.2))

            container.addSubview(msgContainer)
            msgContainer.belowTo(view: timeLbl, constant: 2.5*DeviceMultiplier)
            if isParticipant{
                msgContainer.leading(constant: DeviceMargine)
            }else{
                msgContainer.trailing(constant: DeviceMargine)
            }
            
            msgContainer.addDirectConstaints(constaintAndValue: [.Bottom:0, .FixWidth: width, .FixHeight: width])
            
            let imageview = Globals.makeImageView(frame: .zero, url: sentImage, contentMode: .scaleAspectFit)
            msgContainer.addSubview(imageview)
            imageview.addDirectConstaints(constaintAndValue: [.Top:10,.Leading:10, .Bottom:10, .Trailing: 10],addDeviceMultiplier: true)
            
        }
        return container
    }
    
    func relativeDate(date: Date) -> String{
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full

        let relativeDate = formatter.localizedString(for: date, relativeTo: Date())
        return relativeDate
    }
  

}
