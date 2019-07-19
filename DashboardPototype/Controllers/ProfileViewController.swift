
import UIKit
import Foundation
import Alamofire
//import AlamofireImage

class ProfileViewController: UIViewController {
    
    let timeCounter = TimeCounterServices.timeCounter
    
    @IBOutlet weak var mTableView: UITableView!
    @IBOutlet weak var mPreviewImageview: UIImageView!
    
    
    
    
    
    var mDataArray : [String:Any?] = ["last_name_en": nil,
                                     "address": nil,
                                     "religion": nil,
                                     "mobile_no": nil,
                                     "birth_date": nil,
                                     "email_notification_flag": nil,
                                     "nationality": nil,
                                     "last_name_th": nil,
                                     "first_name_en": nil,
                                     "position": nil,
                                     "profile_photo_path": nil,
                                     "first_name_th": nil,
                                     "register_date": nil,
                                     "user_id": nil,
                                     "email": nil]
    //    var mDataArray: DataClass = DataClass()
    
//            let url = "http://192.168.110.91:9091/api/user/profileInfo"
    
    let mUrl = Constants.profileServiceUrl
//    let mUrl = "http://192.168.109.211:8089/api/user/profileInfo"
    //    let mUrl = "http://192.168.109.211:8089/api/user/profileInfo"

    
    var mRefresh: UIRefreshControl = UIRefreshControl()

    let headers: HTTPHeaders = ["accessToken": "Bearer \(UserDefaults.standard.string(forKey: "access_token").unsafelyUnwrapped)"]

    
    
    
    
    //    let mDataDict: [String:String] = ["first_nameEng": "Ruchapol",
    //                                       "last_nameEng": "Sripruetkait",
    //                                       "positionEng": "Mobile dev",
    //                                       "birth_date": "30 Nov 1996",
    //                                       "phone": "082444xxxx",
    //                                       "email": "axxxxxxx@gmail.com",
    //                                       "raceEng": "Thai",
    //                                       "nationalityEng": "Thai",
    //                                       "religionEng": "Buddhist",
    //                                       "addressEng": "Some where on earth"]
    
//    let mDataDict: [String:Any] = ["id": 2,
//                                   "lastName_TH": "นันธิ",
//                                   "firstName_TH": "ณัฐดนัย",
//                                   "address": "5555555555 ",
//                                   "position": "software engineer",
//                                   "profilePhotoPath": "lnwza007.com",
//                                   "birth_date": "1996-07-08",
//                                   "registerDate": "2019-06-26T08:30:00.000+0000",
//                                   "mobileNo": "0870760710",
//                                   "email_notification_flag": "2",
//                                   "lastName_EN": "Nunti",
//                                   "firstName_EN": "Natdanai",
//                                   "nationality": "ไทย",
//                                   "religion": "ไทย",
//                                   "email": "natdanai.nunti@gmail.com",
//                                   "userId": 89614]
    
    // [real key, Bueatyful key]
    let mKeyOrder: [[String]] = [["first_name_th", "ชื่อ"],
                                 ["last_name_th", ""],
                                 ["first_name_en", "Full name"],
                                 ["last_name_en", ""],
                                 ["position", "Position"],
                                 ["birth_date", "Birth date"],
                                 ["mobile_no", "Mobile No."],
                                 ["email", "E-mail"],
                                 ["nationality", "Nationality"],
                                 //["raceEng"],
                                 ["religion", "Religion"],
                                 //["religionEng"],
                                 ["address", "Address"]]
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.mTableView.reloadData()
        self.setupRefresh()
        //        self.query()
        
        //        self.navigationItem.rightBarButtonItem = self.editButtonItem 
        
        //        self.view.backgroundColor = #colorLiteral(red: 0.1215686275, green: 0.1294117647, blue: 0.1411764706, alpha: 1)
        self.view.backgroundColor = UIColor.init(red: 0.1215686275, green: 0.1294117647, blue: 0.1411764706, alpha: 1)
        // Do any additional setup after loading the view.
        let selectImage = UIImage(named: "profile")
        //        let selectImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        self.mPreviewImageview.image = selectImage
        self.mPreviewImageview.drawAsCircle()

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(nav_to_edit_page))
    }
    
//    override func viewDidDisappear(_ animated: Bool) {
//        <#code#>
//    }
//
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let backItem = UIBarButtonItem(barButtonSystemItem: <#T##UIBarButtonItem.SystemItem#>, target: <#T##Any?#>, action: <#T##Selector?#>)
        let backItem = UIBarButtonItem()
//        backItem.target = showLog()
//        backItem.action = #selector(showLog)
        backItem.title = "Cancel"
        navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
        
        if segue.identifier == "ToEditProfileViewController" {
            let targetVC = segue.destination as! EditProfileViewController
            targetVC.mDataArray = self.mDataArray
            targetVC.headers = self.headers
        }
        
    }
    
    
//    @objc func showLog() -> UIViewController{
//        print("Back btn callback??")
//        return self
//    }
    
//        override func setEditing(_ editing: Bool, animated: Bool) {
//            if self.navigationItem.rightBarButtonItem?.title == "Edit" {
//                self.navigationItem.rightBarButtonItem?.title = "Done"
//                self.mTableView.setEditing(true, animated: true)
//            }else{
//                self.navigationItem.rightBarButtonItem?.title = "Edit"
//                self.mTableView.setEditing(false, animated: true)
//            }
//        }
    
    //    @IBAction func insertDatabase(){
    //        if DatabaseManagement.instance.insert(){
    //            self.query()
    //        }else{
    //            print("database insert failure")
    //        }
    //    }
    
    //    func query() {
    //        if !self.mDataArray.isEmpty{
    //            self.mDataArray.removeAll()
    //        }
    //
    //
    //        self.mDataArray = DatabaseManagement.instance.query()
    //        self.mTableView.reloadData()
    //    }
    
    @objc func nav_to_edit_page() {
//        let thisStoryboard: UIStoryboard = UIStoryboard(name: "Profile", bundle: nil)
//        let newViewController = thisStoryboard.instantiateViewController(withIdentifier: "EditProfileViewController") as! EditProfileViewController
//        self.present(newViewController, animated: true, completion: nil)
        
        
        self.performSegue(withIdentifier: "ToEditProfileViewController", sender: nil)
        
        
    }
    
    func setupRefresh(){
        self.mRefresh.addTarget(self, action: #selector(self.feedData), for: .valueChanged)
//        self.mTableView.addSubview(self.mRefresh)
    }
    
    @objc func feedData(){
        
        AF.request(self.mUrl, method: .get, headers: self.headers).responseJSON { (response) in
            
            print("raw res:", response)
            
            switch response.result{
            case .success:
                
                do{
                    let result = try JSONDecoder().decode(ProfileResponse.self, from: response.data!)
//                    print("res : \(result.data)")
                    self.mDataArray = result.data.dictionary
                    print(self.mDataArray)
//                    print(self.mDataArray["id"])
//                    for key in self.mDataDict {
//                        self.mDataDict[key] = result.data.dictionary[key]
//                    }
                    //                    print("res data:", self.mDataArray as Any)
                    
                    
                    // important
                    self.mTableView.reloadData()
                    //
                } catch {
                    print("error some \(error)")
                }
                
            case .failure(let error):
                print("network error: \(error.localizedDescription)")
                
            default:
                print("swift case error")
            }
            
            
            
            
            // 2 second
//            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
//                self.mRefresh.endRefreshing()
//            }
        }
    }
    
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        return self.mDataArray.count
        return self.mKeyOrder.count - 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell : ProfileTableViewCell
        
        print("IndexPath: ", indexPath, " int: ", indexPath.item)
        
        if indexPath.item > 0 {
            let keyName: String! = self.mKeyOrder[indexPath.item + 3][0]
            let bueatyKey: String! = self.mKeyOrder[indexPath.item + 3][1]
            
            cell = tableView.dequeueReusableCell(withIdentifier: "custom") as! ProfileTableViewCell
            //        let item = self.mDataArray[indexPath.row]
            //        cell.mFlightLabel.text = item[Database.Fields.fieldData]
            cell.mKey.text = bueatyKey
            
            
            if let profile_value = self.mDataArray[keyName as String] as? String {
                cell.mValue.text = profile_value
            } else {
                cell.mValue.text = "N/A"
            }
            
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "name section") as! ProfileTableViewCell
            //            cell.mFirstnameThVal.text = mDataDict["firstName_TH"] as? String
            //            cell.mLastnameThVal.text = mDataDict["lastName_TH"] as? String
            
            if let first_name = self.mDataArray["first_name_en"] as? String {
                cell.mFirstnameEngVal.text = first_name as String
            } else {
                cell.mFirstnameEngVal.text = "N/A"
            }
            if let last_name = self.mDataArray["last_name_en"] as? String {
                cell.mLastnameEngVal.text = last_name as String
            } else {
                cell.mLastnameEngVal.text = "N/A"
            }
        }
        return cell
    }
    
    
    //    // UIView
    //    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    //        let cell = tableView.dequeueReusableCell(withIdentifier: "name section")
    //
    ////        print("Cell obj", cell as Any)
    ////        cell.mFirstnameVal.text =
    ////        cell.mLastnameVal.text =
    //        return cell!
    //    }
    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        //        if editingStyle == .delete{
//        //            let item = mDataArray[indexPath.row]
//        //            let rowID = item[Database.Fields.row]
//        //            if DatabaseManagement.instance.delete(rowID: rowID!){
//        //                self.query()
//        //            }else{
//        //                print("Delete failure")
//        //            }
//    }
    override func viewDidAppear(_ animated: Bool) {
        print("Profile check")

        self.feedData()
        self.mTableView.reloadData()

        timeCounter.checkTokenTime(dateNow: Date(), dateExpire: UserDefaults.standard.value(forKey: "token_expire") as! Date, view: self)

    }
}

