//
//  ProfileTableViewCell.swift
//  OnJob
//
//  Created by Ruchapol Sripruetkiat on 26/6/2562 BE.
//  Copyright © 2562 Ruchapol Sripruetkiat. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mFirstnameThVal: UILabel!
    @IBOutlet weak var mLastnameThVal: UILabel!
    @IBOutlet weak var mFirstnameEngVal: UILabel!
    @IBOutlet weak var mLastnameEngVal: UILabel!
    @IBOutlet weak var mKey: UILabel!
    @IBOutlet weak var mValue: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    //    override func setSelected(_ selected: Bool, animated: Bool) {
    //        super.setSelected(selected, animated: animated)
    //
    //        // Configure the view for the selected state
    //    }
    
}
