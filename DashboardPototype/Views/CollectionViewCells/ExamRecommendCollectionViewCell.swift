//
//  ExamRecommendCollectionViewCell.swift
//  DashboardPototype
//
//  Created by Supanat Wanroj on 25/6/2562 BE.
//  Copyright © 2562 Supanat Wanroj. All rights reserved.
//

import UIKit

class ExamRecommendCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var examReImage: UIImageView!
    @IBOutlet weak var examReTitle: UILabel!
    @IBOutlet weak var examReView: UIView!
    override func awakeFromNib() {
        
        examReView.dropShadow()
        examReView.layer.cornerRadius = 5
    }
    
}
