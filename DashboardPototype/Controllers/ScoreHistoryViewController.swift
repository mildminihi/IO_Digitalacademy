//
//  ScoreHistoryViewController.swift
//  DashboardPototype
//
//  Created by Sudchaya Somniyarm on 28/6/2562 BE.
//  Copyright © 2562 Supanat Wanroj. All rights reserved.
//

import UIKit


class ScoreHistoryViewController: UIViewController {
    
    @IBOutlet weak var mTableView: UITableView!

    
    var mDataArray: [[String:String]] = []
    var mTitleArray = ["robot framework-01", "Core-Android", "Advanced-Android"]
    var mScoreArray = ["12/20", "18/20", "20/20"]
    var mDateArray = ["08-12-2019", "10-12-2019", "12-12-2019"]

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ScoreHistoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "score") as! ScoreHistoryTableViewCell
        cell.labelScore.text = mScoreArray[indexPath.row]
        cell.labelExamTitle.text = mTitleArray[indexPath.row]
        cell.labelDate.text = mDateArray[indexPath.row]
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Title")
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    
    
}
