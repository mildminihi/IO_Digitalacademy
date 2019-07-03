//
//  ViewController.swift
//  DashboardPototype
//
//  Created by Supanat Wanroj on 24/6/2562 BE.
//  Copyright © 2562 Supanat Wanroj. All rights reserved.
//
import UIKit

class ViewController: UIViewController {
    
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
    
    var examArray = ["Exam1", "Exam2", "Exam3", "Exam4", "Exam5"]
    var examRecommendArray = ["ExamRe1", "ExamRe2", "ExamRe3", "ExamRe4", "ExamRe5"]
    var examImageArray = ["1", "2", "3", "4", "5"]
    var mostDoExams: [HistoryMostDo] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initUi()
        self.fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.barStyle = .black
    }
    @IBAction func clickLogout(sender: AnyObject) {
        let alert = UIAlertController(title: "Are you sure you want to logout?", message: nil, preferredStyle: .alert)
        
        // add the actions (buttons)
        alert.addAction(UIAlertAction(title: "Log out", style: .destructive, handler: { action in
            self.dismiss(animated: true, completion: nil)
            
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    func feedUserData() {
        UserServices().self.getUserProfileService { (dataArray) in
//            print("🍒🍒\(dataArray)")
            self.labelName.text = "\(dataArray[0].firstNameEN) \(dataArray[0].lastNameEN)"
            self.labelEmail.text = dataArray[0].email
        }
    }
    
    func feedMostExamData() {
        MostDoExamServices().self.getMostDoExamService { (historyMostDo) in
//            print("🥩🥩 \(historyMostDo) 🍤🥩")
            self.mostDoExams = historyMostDo.data.historyMostDo
            if self.mostDoExams.count != 0{
                self.notHaveRecomLabel.isHidden = true
                self.notHaveRecentLabel.isHidden = true
            }
            else {
                self.notHaveRecomLabel.isHidden = false
                self.notHaveRecentLabel.isHidden = false
            }
            self.examCollectView.reloadData()
            self.examRecommendCollectView.reloadData()
        }
    }
    
    func fetchData() {
        self.activityIndicator.isHidden = false
        let delay = 1 // seconds
        self.activityIndicator.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delay)) {
            self.feedUserData()
            self.feedMostExamData()
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
        }
    }
    
    @IBAction func clickRefresh(_ sender: Any) {
        
        self.fetchData()
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mostDoExams.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == examCollectView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "examCell", for: indexPath) as! ExamCollectionViewCell
            let indexImage = Int(arc4random_uniform(5))
            
            cell.examTitle.text = examArray[indexPath.row]
            cell.examImage.image = UIImage(named: examImageArray[indexImage])
            cell.examImage.image = cell.examImage.image?.withRenderingMode(.alwaysTemplate)
            cell.examImage.tintColor = #colorLiteral(red: 0.7704972625, green: 0.5143797994, blue: 1, alpha: 1)
            
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "examRecommendCell", for: indexPath) as! ExamRecommendCollectionViewCell
            
            let indexImage = Int(arc4random_uniform(5))
            
            cell.examReTitle.text = mostDoExams[indexPath.row].examName
            cell.examReImage.image = UIImage(named: examImageArray[indexImage])
            cell.examReImage.image = cell.examReImage.image?.withRenderingMode(.alwaysTemplate)
            cell.examReImage.tintColor = #colorLiteral(red: 0.7704972625, green: 0.5143797994, blue: 1, alpha: 1)
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == examCollectView{
            
            let vc = storyboard?.instantiateViewController(withIdentifier: "ExamDetailViewController") as! ExamDetailViewController
            vc.examName = examArray[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else {
            let vc = storyboard?.instantiateViewController(withIdentifier: "ExamDetailViewController") as! ExamDetailViewController
            vc.examName = mostDoExams[indexPath.row].examName
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        
    }
    
    
}

extension ViewController {
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
        
    }
}

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
