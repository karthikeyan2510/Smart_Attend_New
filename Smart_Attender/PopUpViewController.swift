

import UIKit


class PopUpViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet var tblViewPopup: UITableView!

    @IBOutlet var viewPopup: UIView!
    var DeviceID = [Int]()
    var DeviceName = [String]()
    var BtnColour = [String]()
    var DeviceMessage = [String]()
    var machineNameArray:NSMutableArray=[]
 
     var roundV = UIView()
    
    @IBOutlet var noDataLbl: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.darkGray.withAlphaComponent(0.8)
       // initi()
        self.showAnimate()
        self.showPopupapi()
        // Do any additional setup after loading the view.
    }
    override func viewWillDisappear(_ animated: Bool) {
        viewPopup.isHidden = true
    }
    
    @IBAction func markAllRead(_ sender: UIButton) {
        
         readNotificationAPI()
         DeviceName.removeAll()
         self.tblViewPopup.reloadData()
      
    }
    
    func initi(){
        let cusV = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 40, height: 40))
        cusV.backgroundColor = UIColor.clear
        
        // notification image
        
        img = UIImageView.init(frame: CGRect.init(x: cusV.center.x-30, y: cusV.center.y-15, width: 30, height: 30))
        img!.image = UIImage.init(named: "Battery_icon")
        img!.tintColor = UIColor.white
        cusV.addSubview(img!)
        
        roundV = UIView.init(frame: CGRect.init(x: img!.frame.origin.x+15, y:img!.frame.origin.y-5, width: 35, height: 17.00))
        print(roundV)
        roundV.layer.cornerRadius = 8
        roundV.layer.masksToBounds = true
        roundV.backgroundColor = UIColor.green
        cusV.addSubview(roundV)
        
        
        
//        let cusV = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 40, height: 40))
//        cusV.backgroundColor = UIColor.clear
//
//        // notification image
//
//        img = UIImageView.init(frame: CGRect.init(x: cusV.center.x-30, y: cusV.center.y-15, width: 30, height: 30))
//        img!.image = UIImage.init(named: "Battery_icon")
//        img!.tintColor = UIColor.white
//        cusV.addSubview(img!)
//
//        // badge counter round
//        roundV = UIView.init(frame: CGRect.init(x: img!.frame.origin.x+15, y:img!.frame.origin.y-5, width: 35, height: 17.00))
//        print(roundV)
//        roundV.layer.cornerRadius = 8
//        roundV.layer.masksToBounds = true
//        roundV.backgroundColor = UIColor.red
//
//        self.badgeLbl = UILabel.init(frame: CGRect.init(x:7, y: 0, width: 20, height: 15.00))
//        // self.badgeLbl = UILabel()
//        badgeLbl.font = UIFont.init(name: "IBMPlexSans-SemiBold", size: 10)
//        badgeLbl.textAlignment = .center
//        badgeLbl.textColor = UIColor.white
//        badgeLbl.center = CGPoint(x: roundV.center.x, y: badgeLbl.center.y)
//
//        // badgeLbl.center = roundV.center
//
//        roundV.addSubview(badgeLbl)
//
//
//        cusV.addSubview(roundV)
//
        
        
        
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DeviceName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell
        var ID:String?
        ID = String(DeviceID[indexPath.row])
        cell.lblNo.text = "(" + ID! + ")" ?? ""
        cell.lblName.text  = DeviceName[indexPath.row]
        cell.colourBtn.backgroundColor = UIColor(netHex_String: BtnColour[indexPath.row])
        cell.statusLbl.text = DeviceMessage[indexPath.row]
        print(BtnColour)
        cell.viewBtn.tag = indexPath.row
//        let data_array:NSDictionary = machineNameArray.object(at: indexPath.row) as! NSDictionary
//        cell.lblName.text =  data_array.value(forKey: "DeviceName") as? String
//        cell.statusLbl.text =  data_array.value(forKey: "Message") as? String
//        let status:NSNumber = data_array.value(forKey: "RunningStatus") as? NSNumber ?? 0
//        
        cell.viewBtn.addTarget(self, action: #selector(viewActionBtn(_:)), for: .touchUpInside)
      //  cell.viewBtn.backgroundColor
        return cell
    }
    
    @IBAction func seeAllBtnAction(_ sender: Any) {
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "dashboard1_ViewController") as! dashboard1_ViewController
        self.navigationController?.pushViewController(secondViewController, animated: true)
}
    func readNotificationAPI() {
        //let jsonURL = "http://smartattend.colanonline.net/service/api/Dashboard/ReadAllNotification/121"
        let jsonURL = (BaseApi + "Dashboard/ReadAllNotification/" + account_id)
        let url = URL(string: jsonURL)
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard error == nil else{
                return
            }
            guard let dd = data else {
                return
            }
            
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as? [String:Any]
                {
                    
                    DispatchQueue.main.async {
                        print(json)
                        img!.image = UIImage.init(named: "Battery_icon-green")
                       // self.roundV.backgroundColor = UIColor.clear
                        //self.roundV.removeFromSuperview()
                        self.roundV.isHidden = true
                        self.tblViewPopup.reloadData()
                    }
                 
                }
            }
            catch {
                print("Error is : \n\(error)")
            }
            }.resume()
    }
    
    func show_popup(indexpath: IndexPath, view: UITableView)
    {
        let selectedCell:CustomCell = view.cellForRow(at: indexpath)! as! CustomCell
        selectedCell.contentView.backgroundColor = selectedCell.contentView.backgroundColor//UIColor.clear
        
        if indexpath.row<=self.machineNameArray.count
        {
            let data_dict:NSDictionary=machineNameArray.object(at: indexpath.row) as! NSDictionary
            dfualts.setValue(false, forKey: "reload")
            
            let usertype:String=dfualts.value(forKey: "UserType") as? String ?? ""
            if (usertype.lowercased() == "admin") || Global.userType.isManager()
            {
                let popview = self.storyboard?.instantiateViewController(withIdentifier: "MachineDetails_ViewController") as! MachineDetails_ViewController
                popview.data_dict=data_dict
                self.addChildViewController(popview)
                popview.view.frame=self.view.frame
                self.view.addSubview(popview.view)
                popview.didMove(toParentViewController: self)
            }
            else
            {
                let popview2 = self.storyboard?.instantiateViewController(withIdentifier: "Popup_MachinedetailsViewController") as! Popup_MachinedetailsViewController
                popview2.data_dict=data_dict
                self.addChildViewController(popview2)
                popview2.view.frame=self.view.frame
                self.view.addSubview(popview2.view)
                popview2.didMove(toParentViewController: self)
            }
        }
    }
    
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    func post_notificinfo(indexpath: IndexPath,view: UITableView) {
        
        if machineNameArray.count > 1 {
            let data_array:NSDictionary = machineNameArray.object(at: indexpath.row) as! NSDictionary
            print(data_array)
            let notific_id:NSNumber=data_array.value(forKey: "ID") as? NSNumber ?? 0
            print(notific_id)
            self.startloader(msg: "Loading.... ")
            let postdict:NSMutableDictionary=["NotificationID":notific_id]
            Global.server.Post(path: "Dashboard/NotificationRead/\(notific_id)", jsonObj: postdict, completionHandler: {
                (success,failure ,noConnection) in
                self.stoploader()
                if(failure == nil && noConnection == nil)
                {
                    let dict:NSDictionary=success as! NSDictionary
                    if(dict["Message"] != nil)
                    {
                        let success=dict.value(forKey: "IsSuccess") as? Bool ?? false
                        if (success)
                        {
                            defalts.setValue("\(indexpath.row)", forKey: "RemoveId")
                            self.show_popup(indexpath: indexpath,view: view)
                        }
                        else
                        {
                            self.alert(msgs:dict.value(forKey: "Message") as? String ?? "")
                        }
                    }
                }
                else
                {
                    self.alert(msgs: Global.network.redAlert(error: failure, noConnection: noConnection))
                }
            })
        }else
        {
        }

    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        view.isHidden = true
        //self.removeAnimate()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closePopUp(_ sender: AnyObject) {
        removeAnimate()
        //self.view.removeFromSuperview()
    }
    
    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
    
    
    func showPopupapi(){
        //let jsonURL = "http://smartattend.colanonline.net/service/api/Dashboard/NotificationCountByDeviceID/131"
    let jsonURL = (BaseApi + "Dashboard/NotificationCountByDeviceID/" + account_id)
        print(jsonURL)
        let url = URL(string: jsonURL)
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard error == nil else{
                print("abdul")
                return
            }
            guard let dd = data else{
                 print("abdul1")
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as? [String:Any]
                {
                    let myarray = json["LstNotificationDeviceModel"] as! NSArray
                    
                     self.machineNameArray = myarray.mutableCopy() as? NSMutableArray ?? []
                    
                    if myarray == []
                    {
                        self.noDataLbl.isHidden = false
                    }
                    
                    for array in myarray
                    {
                        if let ar1 = array as? [String: Any]
                        {
                            DispatchQueue.main.async {
                                self.noDataLbl.isHidden = true
                              }
                             print("abdul33")
                            print("In Json ID :",ar1["ID"] as! Int)
                            self.DeviceID.append(ar1["Notifycount"] as! Int)
                            self.DeviceName.append(ar1["DeviceName"] as! String)
                            self.BtnColour.append(ar1["Color"] as! String)
                            self.DeviceMessage.append(ar1["Message"]as! String)
                            
                            print("In Json Device Name :",ar1["DeviceName"] as! String)
                        }
                    }
                    DispatchQueue.main.async
                        {
                            self.tblViewPopup.reloadData()
                    }
                }
                
            }
            catch {
                 print("abdul2")
                print("Error is : \n\(error)")
            }
            }.resume()
        
    }
    
  
    @objc func viewActionBtn(_ sender: UIButton) {
        let tag = sender.tag
        let indexpath = NSIndexPath(row: tag, section: 0)
        self.post_notificinfo(indexpath:indexpath as IndexPath,view: tblViewPopup)
    
    }
    
   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
