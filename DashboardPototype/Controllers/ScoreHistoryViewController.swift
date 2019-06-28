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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    //   self.query()
        
    }
    
    func query(){
        if !self.mDataArray.isEmpty{
            self.mDataArray.removeAll()
        }
      //  self.mDataArray = DatabaseManagement.instance.query()
//        self.mTableView.reloadData()
    }

  
}

extension ScoreHistoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "score") as! ScoreHistoryTableViewCell
        cell.labelScore.text = "robot framework-01      12/20          08-12-2019"
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Title")
        return cell!
    }
    
    
}
