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
    
    @IBOutlet weak var mTableView: UITableView!
    @IBOutlet weak var mPreviewImageview: UIImageView!
    var mIsProfileDataChange: Bool = false
    
    var mDataArray : [String:Any] = [:]
  
    let mUrl = Constants.profileServiceUrl
    
    
    var mRefresh: UIRefreshControl = UIRefreshControl()
    let headers: HTTPHeaders = ["token": "Bearer asdasd12"]
    
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
//                               ["raceEng"],
                                 ["religion", "Religion"],
//                               ["religionEng"],
                                 ["address", "Address"]]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.feedData()
        
        self.view.backgroundColor = UIColor.init(red: 0.1215686275, green: 0.1294117647, blue: 0.1411764706, alpha: 1)
        // Do any additional setup after loading the view.
        let selectImage = UIImage(named: "profile")
        //        let selectImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        self.mPreviewImageview.image = selectImage
        self.mPreviewImageview.drawAsCircle()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(putProfileData))
        navigationItem.title = "Edit Profile"
        navigationItem.hidesBackButton = true
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.backButtonTapped))

        
        
        // Set name of back button
//        let backButton = UIBarButtonItem()
//        backButton.title = "Cancel"
        
        
        // Do any additional setup after loading the view.
    }
    
    @objc func backButtonTapped() {
        let responseMsg: String = "Are you sure to discard changing profile?"
        if(self.mIsProfileDataChange){
          self.showAlert(responseMsg: responseMsg)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
        
        
    }
    
    func showAlert(responseMsg: String){
        
        let alertVC = UIAlertController(title: "Response", message: responseMsg, preferredStyle: .actionSheet)
        alertVC.addAction(UIAlertAction(title: "CLOSE", style: .cancel, handler: nil))
        alertVC.addAction(UIAlertAction(title: "Discard", style: .default, handler: { (alert) in
            self.navigationController?.popViewController(animated: true)
        }))
        
        self.present(alertVC, animated: true, completion: nil)
    }
    
    
    
    func setupRefresh(){
        self.mRefresh.addTarget(self, action: #selector(feedData), for: .valueChanged)
        self.mTableView.addSubview(self.mRefresh)
    }
    
    @objc func putProfileData(){
        
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
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
    
    @IBAction func firstnameChanged(_ sender: Any) {
        self.mIsProfileDataChange = true
    }
    
    @IBAction func lastNameChanged(_ sender: Any) {
        self.mIsProfileDataChange = true
    }
    
    @IBAction func valueChanged(_ sender: Any) {
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
        
        if indexPath.item > 0 {
            let keyName: String! = self.mKeyOrder[indexPath.item + 3][0]
            let bueatyKey: String! = self.mKeyOrder[indexPath.item + 3][1]
            
            cell = tableView.dequeueReusableCell(withIdentifier: "custom") as! EditProfileTableViewCell
            //        let item = self.mDataArray[indexPath.row]
            //        cell.mFlightLabel.text = item[Database.Fields.fieldData]
            cell.mKey.text = bueatyKey
            
            
            if let profile_value = self.mDataArray[keyName as String] as? String {
                cell.mValue.text = profile_value
            } else {
                cell.mValue.text = "N/A"
            }
            
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "name section") as! EditProfileTableViewCell
            //            cell.mFirstnameThVal.text = mDataDict["firstName_TH"] as? String
            //            cell.mLastnameThVal.text = mDataDict["lastName_TH"] as? String
            
            if let first_name = self.mDataArray["firstName_EN"] as? String {
                cell.mFirstnameEngVal.text = first_name as String
            } else {
                cell.mFirstnameEngVal.text = "N/A"
            }
            if let last_name = self.mDataArray["lastName_EN"] as? String {
                cell.mLastnameEngVal.text = last_name as String
            } else {
                cell.mLastnameEngVal.text = "N/A"
            }
        }
        return cell
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

