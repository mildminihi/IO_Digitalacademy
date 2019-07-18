//
//  EditProfileViewController.swift
//  DashboardPototype
//
//  Created by Ruchapol Sripruetkiat on 9/7/2562 BE.
//  Copyright © 2562 Supanat Wanroj. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class EditProfileViewController: UIViewController {
    let timeCounter = TimeCounterServices.timeCounter
    
    @IBOutlet weak var mTableView: UITableView!
    @IBOutlet weak var mPreviewImageview: UIImageView!
    var mFieldInTable: [UITextField] = []
    var mCellIndices: [IndexPath] = []
    
    var mIsProfileDataChange: Bool = false
    
    var mDataArray : [String:Any] = [:]
    var mEditDataTmpArray : [String:Any] = [:]
    
    let mUrl = Constants.editProfileServiceUrl
    var mRefresh: UIRefreshControl = UIRefreshControl()
    let headers: HTTPHeaders = ["id": "1"]
    
    var mSubmitSuccess: Bool? = nil
    
    
    
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
    
    //    "first_name_th":"firstName_TH":"xyz",
    //    "last_name_th":"lastName_TH":"zyx",
//    "firstName_EN":"xyz",
//    "lastName_EN":"zyx",
//    "address":"mac",
//    "position":"pc",
//    "profilePhotoPath":"labtip/tablet/sm.png",
//    "birth_date":"1998-10-2",
//    "registerDate":"1998-10-2 17:20:9",
//    "mobileNo":"0123456",
//    "email_notification_flag":"22",
//    "nationality":"as",
//    "religion":"sa"
    
//    let mKeyMapper:[[String]] = [["first_name_th", "firstName_TH"]]

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.feedData()
        
        self.view.backgroundColor = UIColor.init(red: 0.1215686275, green: 0.1294117647, blue: 0.1411764706, alpha: 1)
        // Do any additional setup after loading the view.
        let selectImage = UIImage(named: "profile")
        //        let selectImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        self.mPreviewImageview.image = selectImage
        self.mPreviewImageview.drawAsCircle()
        
        self.setupNavBar()
        
        

        
        
        // Set name of back button
//        let backButton = UIBarButtonItem()
//        backButton.title = "Cancel"
        
        
        // Do any additional setup after loading the view.
    }
    
    @objc func submitProfileData(){
        
        print("parameters:", self.mDataArray)
        
        AF.request(self.mUrl, method: .put, parameters: self.mDataArray, headers: self.headers).responseJSON { (response) in
            
            print("raw res:", response)
            
            switch response.result{
            case .success:
                
                do {
                    let result = try JSONDecoder().decode(ProfileResponse.self, from: response.data!)
                    print("Code: \(result.status.code)")
                    print("Success!")
                    
                } catch {
                    do {
                        let result = try JSONDecoder().decode(ProfileErrorResponse.self, from: response.data!)
                        print("Code: \(result.status.code)")
                        print("Message: \(result.status.message)")
                    } catch {
                        print("unknow prase")
                    }
                }
                
                print("Submited profile data")
                
                self.mSubmitSuccess = true
                
            case .failure(let error):
                print("network error: \(error.localizedDescription)")
                
                
                self.mSubmitSuccess = false
                
            }
        }
    }
    
    func setupNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(self.putProfileData))
        navigationItem.title = "Edit Profile"
        navigationItem.hidesBackButton = true
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.backButtonTapped))
    }
    
    @objc func backButtonTapped() {
        let responseMsg: String = "Are you sure to discard changing in profile?"
        if(self.mIsProfileDataChange){
            self.showAlert(responseMsg: responseMsg)
        } else {
            self.navigationController?.popViewController(animated: true)
//            self.navigationController?.
        }
        
        
    }
    
    func showAlert(responseMsg: String){
        
        let alertVC = UIAlertController(title: "Response", message: responseMsg, preferredStyle: .actionSheet)
        alertVC.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
        alertVC.addAction(UIAlertAction(title: "Discard", style: .destructive, handler: { (alert) in
            self.navigationController?.popViewController(animated: true)
        }))
        
        self.present(alertVC, animated: true, completion: nil)
    }
    
    func buildSubmitForm(){
        for (key, value) in self.mEditDataTmpArray{
            self.mDataArray[key] = value
        }
        
        self.mDataArray.removeValue(forKey: "email")
        self.mDataArray.removeValue(forKey: "user_id")
        
    }
    
    @objc func putProfileData(){
        let message = "Submit Change"
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        
        self.buildSubmitForm()
        self.submitProfileData()
        
        self.present(alert, animated: true)
        let duration: Double = 1.5

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + duration) {
            alert.dismiss(animated: true)
            if let succes = self.mSubmitSuccess {
                
                if succes {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    
    @objc func datePickerFromValueChanged(sender:UIDatePicker) {
        
//        cell = self.mTableView.dequeueReusableCell(withIdentifier: "custom") as! EditProfileTableViewCell
//
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let dateStr: String = dateFormatter.string(from: sender.date)
//
//        self.mTableView.accessibilityElements.text = dateStr
        
//        self.mTableView.cellForRow(at: <#T##IndexPath#>)
        
        self.mFieldInTable[3].text = dateStr            // date row
        
        self.mIsProfileDataChange = true          
        
        
    }
    
    @IBAction func showDateScrollView(_ sender: UITextField){
        if sender.accessibilityIdentifier == "birth_date" {
            
            
            let datePickerView:UIDatePicker = UIDatePicker()
            datePickerView.datePickerMode = UIDatePicker.Mode.date
            sender.inputView = datePickerView
//            self.mFieldInTable[3].inputView = datePickerView
            datePickerView.addTarget(self, action: #selector(self.datePickerFromValueChanged), for: UIControl.Event.valueChanged)
            
            
            
            print("Call Date Scroll View")
            
        } else {
            print("Don't call Date scroll view")
        }
    }
    
    @IBAction func profileAttrChanged(_ sender: UITextField) {
//        self.mTableView.
//        let cell = self.mTableView.dequeueReusableCell(withIdentifier: "firstName_EN")
//        let cell = self.myTableView.dequeueReusableCell(withIdentifier: "manualAddC1")
        print("sender:\(String(describing: sender.text))")
        print("id:\(String(describing: sender.accessibilityIdentifier))")
//        print("firstName_EN:\(String(describing: cell?.accessibilityElementCount()))")
        let textFillId = String(sender.accessibilityIdentifier!)
        let text = String(sender.text!)
        self.mEditDataTmpArray[textFillId] = text
    
        
        self.mIsProfileDataChange = true
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
}

extension EditProfileViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        return self.mDataArray.count
        return self.mKeyOrder.count - 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell : EditProfileTableViewCell
        
        print("IndexPath: ", indexPath, " int: ", indexPath.item)
        
        let keyName: String! = self.mKeyOrder[indexPath.item + 3][0]
        let bueatyKey: String! = self.mKeyOrder[indexPath.item + 3][1]
        
        if indexPath.item == 0  {
            cell = tableView.dequeueReusableCell(withIdentifier: "name section") as! EditProfileTableViewCell
            //            cell.mFirstnameThVal.text = mDataDict["firstName_TH"] as? String
            //            cell.mLastnameThVal.text = mDataDict["lastName_TH"] as? String
            
            if let first_name = self.mDataArray["first_name_en"] as? String {
                cell.mFirstnameEngVal.text = first_name as String
            } else {
                cell.mFirstnameEngVal.text = ""
            }
            if let last_name = self.mDataArray["last_name_en"] as? String {
                cell.mLastnameEngVal.text = last_name as String
            } else {
                cell.mLastnameEngVal.text = ""
            }
            cell.mFirstnameEngVal.accessibilityIdentifier = "first_name_en"
            cell.mLastnameEngVal.accessibilityIdentifier = "last_name_en"
            
            self.mFieldInTable.append(cell.mFirstnameEngVal)
            self.mFieldInTable.append(cell.mLastnameEngVal)
            
            
            
        } else {
            
            
            cell = tableView.dequeueReusableCell(withIdentifier: "custom") as! EditProfileTableViewCell
            //        let item = self.mDataArray[indexPath.row]
            //        cell.mFlightLabel.text = item[Database.Fields.fieldData]
            cell.mKey.text = bueatyKey
            
            
            if let profile_value = self.mDataArray[keyName as String] as? String {
                cell.mValue.text = profile_value
            } else {
                cell.mValue.text = ""
            }
            cell.mValue.accessibilityIdentifier = keyName
            if keyName == "birth_date" {
//                cell.mValue.addTarget(self, action: #selector(respondsToTf), for: .touchDown)
            }
            
            self.mFieldInTable.append(cell.mValue)
            
        }
        self.mCellIndices.append(indexPath)
        return cell
    }
    

    override func viewDidAppear(_ animated: Bool) {
        print("Edit Profile check")
        timeCounter.checkTokenTime(dateNow: Date(), dateExpire: UserDefaults.standard.value(forKey: "token_expire") as! Date)
    }
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

