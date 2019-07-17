//
//  ViewController.swift
//  DashboardPototype
//
//  Created by Supanat Wanroj on 24/6/2562 BE.
//  Copyright © 2562 Supanat Wanroj. All rights reserved.
//
import UIKit

class DashBoardViewController: UIViewController {
    
    @IBOutlet weak var labelEmail: UILabel!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var imageProfile: UIImageView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var examCountView: UIView!
    @IBOutlet weak var userCountView: UIView!
    @IBOutlet weak var examCollectView: UICollectionView!
    @IBOutlet weak var examRecommendCollectView: UICollectionView!
    @IBOutlet weak var historyButton: UIButton!
    @IBOutlet weak var kpiView: UIView!
    @IBOutlet weak var examAllCountView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var viewAllExamButton: UIButton!
    @IBOutlet weak var notHaveRecentLabel: UILabel!
    @IBOutlet weak var notHaveRecomLabel: UILabel!
    @IBOutlet weak var notHaveRecentView: UIView!
    @IBOutlet weak var notHaveRecomView: UIView!
    
    var examImageArray = ["1", "2", "3", "4", "5"]
    var mostDoExamsArray: [HistoryMostDo] = []
    var recentExamArray: [LastDo] = []
    
    let timeCounter = TimeCounterServices.timeCounter
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initUi()
        self.fetchData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("Dashboard check")
        timeCounter.checkTokenTime(dateNow: Date(), dateExpire: UserDefaults.standard.value(forKey: "token_expire") as! Date)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.barStyle = .black
    }
    
    @IBAction func clickLogout(sender: AnyObject) {
        let alert = UIAlertController(title: "Are you sure you want to logout?", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Log out", style: .destructive, handler: { action in
            self.dismiss(animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func clickRefresh(_ sender: Any) {
        self.fetchData()
    }
}

//CollectionView
extension DashBoardViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == examCollectView{
            return recentExamArray.count
        }
        else {
            return mostDoExamsArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == examCollectView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "examCell", for: indexPath) as! ExamCollectionViewCell
            let indexImage = Int(arc4random_uniform(5))
            cell.examTitle.text = recentExamArray[indexPath.row].examName
            cell.examImage.image = UIImage(named: examImageArray[indexImage])
            cell.examImage.image = cell.examImage.image?.withRenderingMode(.alwaysTemplate)
            cell.examImage.tintColor = #colorLiteral(red: 0.7704972625, green: 0.5143797994, blue: 1, alpha: 1)
            
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "examRecommendCell", for: indexPath) as! ExamRecommendCollectionViewCell
            let indexImage = Int(arc4random_uniform(5))
            cell.examReTitle.text = mostDoExamsArray[indexPath.row].examName
            cell.examReImage.image = UIImage(named: examImageArray[indexImage])
            cell.examReImage.image = cell.examReImage.image?.withRenderingMode(.alwaysTemplate)
            cell.examReImage.tintColor = #colorLiteral(red: 0.7704972625, green: 0.5143797994, blue: 1, alpha: 1)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == examCollectView{
            let vc = storyboard?.instantiateViewController(withIdentifier: "ExamDetailViewController") as! ExamDetailViewController
            vc.examName = recentExamArray[indexPath.row].examName
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else {
            let vc = storyboard?.instantiateViewController(withIdentifier: "ExamDetailViewController") as! ExamDetailViewController
            vc.examName = mostDoExamsArray[indexPath.row].examName
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
}

//Fuction on ViewController
extension DashBoardViewController {
    
    func fetchData() {
        self.activityIndicator.isHidden = false
        let delay = 1 // seconds
        self.activityIndicator.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delay)) {
            self.feedUserData()
            self.feedMostExamData()
            self.feedRecentExam()
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
        }
    }
    
    func feedUserData() {
        UserServices().self.getUserProfileService { (dataArray) in
            if dataArray.count == 0 {
                self.alertWithOneOption(title: "Cannot connect to server!", msg: nil, option: "OK")
            }
            else {
                self.labelName.text = "\(dataArray[0].firstNameEN) \(dataArray[0].lastNameEN)"
                self.labelEmail.text = dataArray[0].email
            }
        }
    }
    
    func feedMostExamData() {
        MostDoExamServices().self.getMostDoExamService { (historyMostDo) in
            if historyMostDo.count == 0 {
                self.isNotHaveRecommendExam(flag: true)
                self.alertWithOneOption(title: "Cannot get RecommandExam Info!", msg: nil, option: "OK")
            }
            else {
                self.mostDoExamsArray = historyMostDo[0].data.historyMostDo
                if self.mostDoExamsArray.count != 0{
                    self.isNotHaveRecommendExam(flag: false)
                }
                else {
                    self.isNotHaveRecommendExam(flag: true)
                }
                self.examRecommendCollectView.reloadData()
            }
        }
    }
    
    func feedRecentExam() {
        RecentExamServices().self.getRecentExamService { (recentExam) in
            if recentExam.count == 0 {
                self.isNotHaveRecentExam(flag: true)
                self.alertWithOneOption(title: "Cannot get RecentExam Info!", msg: nil, option: "OK")
            }
            else {
                self.recentExamArray = recentExam[0].data.lastDo
                if self.mostDoExamsArray.count != 0{
                    self.isNotHaveRecentExam(flag: false)
                }
                else {
                    self.isNotHaveRecentExam(flag: true)
                }
                self.examCollectView.reloadData()
            }
        }
    }
}

//Image Extension
extension UIImage {
    func maskWithColor(color: UIColor) -> UIImage? {
        let maskImage = cgImage!
        let width = size.width
        let height = size.height
        let bounds = CGRect(x: 0, y: 0, width: width, height: height)
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let context = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)!
        context.clip(to: bounds, mask: maskImage)
        context.setFillColor(color.cgColor)
        context.fill(bounds)
        if let cgImage = context.makeImage() {
            let coloredImage = UIImage(cgImage: cgImage)
            return coloredImage
        } else {
            return nil
        }
    }
}

//UI Extension
extension DashBoardViewController {
    
    func initUi() {
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.07057655603, green: 0.07059641927, blue: 0.07057393342, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.7704972625, green: 0.5143797994, blue: 1, alpha: 1)
        self.historyButton.layer.cornerRadius = 5
        self.viewAllExamButton.layer.cornerRadius = 5
        self.imageProfile.layer.cornerRadius = 45
        self.topView.dropShadow()
        self.kpiView.dropShadow()
        self.examCountView.dropShadow()
        self.userCountView.dropShadow()
        self.examAllCountView.dropShadow()
        self.imageProfile.layer.borderWidth = 2
        self.imageProfile.layer.borderColor = #colorLiteral(red: 0.7704972625, green: 0.5143797994, blue: 1, alpha: 1)
        self.examCountView.layer.cornerRadius = 2
        self.examAllCountView.layer.cornerRadius = 2
        self.kpiView.layer.cornerRadius = 2
        self.userCountView.layer.cornerRadius = 2
        self.notHaveRecomView.layer.cornerRadius = 5
        self.notHaveRecentView.layer.cornerRadius = 5
    }
    
    func isNotHaveRecommendExam(flag : Bool) {
        if flag{
            self.notHaveRecomLabel.isHidden = false
            self.notHaveRecomView.isHidden = false
            self.examRecommendCollectView.isHidden = true
        }
        else {
            self.notHaveRecomLabel.isHidden = true
            self.notHaveRecomView.isHidden = true
            self.examRecommendCollectView.isHidden = false
        }
    }
    
    func isNotHaveRecentExam(flag : Bool) {
        if flag{
            self.notHaveRecentLabel.isHidden = false
            self.notHaveRecentView.isHidden = false
            self.examCollectView.isHidden = true
        }
        else {
            self.notHaveRecentLabel.isHidden = true
            self.notHaveRecentView.isHidden = true
            self.examCollectView.isHidden = false
        }
    }
    
}
