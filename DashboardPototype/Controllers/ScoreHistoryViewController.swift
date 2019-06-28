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
        self.query()
        
    }
    
    func query(){
        if !self.mDataArray.isEmpty{
            self.mDataArray.removeAll()
        }
      //  self.mDataArray = DatabaseManagement.instance.query()
        self.mTableView.reloadData()
    }

  
}
