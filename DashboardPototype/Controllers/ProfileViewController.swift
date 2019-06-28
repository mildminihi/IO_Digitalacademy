
import UIKit
import Foundation
import Alamofire
//import AlamofireImage

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var mTableView: UITableView!
    @IBOutlet weak var mPreviewImageview: UIImageView!
    
    var mDataArray: [String:Any] = [:]
    //    var mDataArray: DataClass = DataClass()
    
    var mRefresh: UIRefreshControl = UIRefreshControl()
    let headers: HTTPHeaders = ["token": "1234"]
    
    
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
    
    let mDataDict: [String:Any] = ["id": 2,
                                   "lastName_TH": "นันธิ",
                                   "firstName_TH": "ณัฐดนัย",
                                   "address": "5555555555 ",
                                   "position": "software engineer",
                                   "profilePhotoPath": "lnwza007.com",
                                   "birth_date": "1996-07-08",
                                   "registerDate": "2019-06-26T08:30:00.000+0000",
                                   "mobileNo": "0870760710",
                                   "email_notification_flag": "2",
                                   "lastName_EN": "Nunti",
                                   "firstName_EN": "Natdanai",
                                   "nationality": "ไทย",
                                   "religion": "ไทย",
                                   "email": "natdanai.nunti@gmail.com",
                                   "userId": 89614]
    
    // [real key, Bueatyful key]
    let mKeyOrder: [[String]] = [["firstName_TH", "ชื่อ"],
                                 ["lastName_TH", ""],
                                 ["firstName_EN", "Full name"],
                                 ["lastName_EN", ""],
                                 ["position", "Position"],
                                 ["birth_date", "Birth date"],
                                 ["mobileNo", "Mobile No."],
                                 ["email", "E-mail"],
                                 ["nationality", "Nationality"],
                                 //                        ["raceEng"],
        ["religion", "Religion"],
        //                        ["religionEng"],
        ["address", "Address"]]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.feedData()
        //        self.query()
        
        //        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        //        self.view.backgroundColor = #colorLiteral(red: 0.1215686275, green: 0.1294117647, blue: 0.1411764706, alpha: 1)
        self.view.backgroundColor = UIColor.init(red: 0.1215686275, green: 0.1294117647, blue: 0.1411764706, alpha: 1)
        // Do any additional setup after loading the view.
        let selectImage = UIImage(named: "profile")
        //        let selectImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        self.mPreviewImageview.image = selectImage
        self.mPreviewImageview.drawAsCircle()
    }
    
    //    override func setEditing(_ editing: Bool, animated: Bool) {
    //        if self.navigationItem.rightBarButtonItem?.title == "Edit" {
    //            self.navigationItem.rightBarButtonItem?.title = "Done"
    //            self.mTableView.setEditing(true, animated: true)
    //        }else{
    //            self.navigationItem.rightBarButtonItem?.title = "Edit"
    //            self.mTableView.setEditing(false, animated: true)
    //        }
    //    }
    
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
    
    func setupRefresh(){
        self.mRefresh.addTarget(self, action: #selector(feedData), for: .valueChanged)
        self.mTableView.addSubview(self.mRefresh)
    }
    
    @objc func feedData(){
        AF.request("http://192.168.110.91:9091/api/user/profileInfo", method: .get, headers: headers).responseJSON { (response) in
            
            print("raw res:", response)
            
            switch response.result{
            case .success:
                
                do{
//                    let result = try JSONDecoder().decode(ProfileResponse.self, from: response.data!)
//                    print("res : \(result.data)")
                    //                    self.mDataArray = response.data
//                    print(self.mDataArray)
                    //                    print("res data:", self.mDataArray as Any)
                    
                    
                    // important
                    //                    self.mTableView.reloadData()
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
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                self.mRefresh.endRefreshing()
            }
        }
    }
    
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        return self.mDataArray.count
        return mKeyOrder.count - 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell : ProfileTableViewCell
        
        print("IndexPath: ", indexPath, " int: ", indexPath.item)
        
        if indexPath.item > 0 {
            let keyName: String! = mKeyOrder[indexPath.item + 3][0]
            let bueatyKey: String! = mKeyOrder[indexPath.item + 3][1]
            cell = tableView.dequeueReusableCell(withIdentifier: "custom") as! ProfileTableViewCell
            //        let item = self.mDataArray[indexPath.row]
            //        cell.mFlightLabel.text = item[Database.Fields.fieldData]
            cell.mKey.text = bueatyKey
            cell.mValue.text = mDataDict[keyName] as? String
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "name section") as! ProfileTableViewCell
            //            cell.mFirstnameThVal.text = mDataDict["firstName_TH"] as? String
            //            cell.mLastnameThVal.text = mDataDict["lastName_TH"] as? String
            cell.mFirstnameEngVal.text = mDataDict["firstName_EN"] as? String
            cell.mLastnameEngVal.text = mDataDict["lastName_EN"] as? String
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        //        if editingStyle == .delete{
        //            let item = mDataArray[indexPath.row]
        //            let rowID = item[Database.Fields.row]
        //            if DatabaseManagement.instance.delete(rowID: rowID!){
        //                self.query()
        //            }else{
        //                print("Delete failure")
        //            }
    }
}

