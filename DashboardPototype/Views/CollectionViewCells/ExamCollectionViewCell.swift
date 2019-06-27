//
//  ExamCollectionViewCell.swift
//  DashboardPototype
//
//  Created by Supanat Wanroj on 25/6/2562 BE.
//  Copyright © 2562 Supanat Wanroj. All rights reserved.
//

import UIKit

class ExamCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var examImage: UIImageView!
    @IBOutlet weak var examTitle: UILabel!
    @IBOutlet weak var cellView: UIView!
    
    override func awakeFromNib() {
        
        self.cellView.dropShadow()
        self.cellView.layer.cornerRadius = 5
    }
    
}
