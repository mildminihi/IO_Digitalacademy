//
//  ScoreHistoryViewController.swift
//  DashboardPototype
//
//  Created by Sudchaya Somniyarm on 28/6/2562 BE.
//  Copyright © 2562 Supanat Wanroj. All rights reserved.
//

import UIKit


class ScoreHistoryViewController: UIViewController {
    
    let timeCounter = TimeCounterServices.timeCounter
    
    @IBOutlet weak var mTableView: UITableView!

    
    var mTitleArray = ["robot framework-01", "Core-Android", "Advanced-Android"]
    var mScoreArray = ["12/20", "18/20", "20/20"]
    var mDateArray = ["08-12-2019", "10-12-2019", "12-12-2019"]
    var historyArray : [AllHistory] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        HistoryServices().self.getHistoryService { (historyData) in
            self.historyArray = historyData[0].data.allHistory
            self.mTableView.reloadData()
        }
        
    }
}

extension ScoreHistoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.historyArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "score") as! ScoreHistoryTableViewCell
        
        cell.labelScore.text = "\(self.historyArray[indexPath.row].pointUser)/\(self.historyArray[indexPath.row].pointExam)"
        cell.labelExamTitle.text = self.historyArray[indexPath.row].examName
        cell.labelDate.text = "\(self.historyArray[indexPath.row].timestamp)"
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Title")
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("History check")
        timeCounter.checkTokenTime(dateNow: Date(), dateExpire: UserDefaults.standard.value(forKey: "token_expire") as! Date, view: self)
    }
    
}
