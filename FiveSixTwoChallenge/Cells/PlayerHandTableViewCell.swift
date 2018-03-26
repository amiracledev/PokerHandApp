//
//  PlayerHandTableViewCell.swift
//  FiveSixTwoChallenge
//
//  Created by Amir Nickroo on 3/25/18.
//  Copyright © 2018 amiracledev. All rights reserved.
//

import UIKit

class PlayerHandTableViewCell: UITableViewCell {

    
    @IBOutlet weak var cardImage: UIImageView!
    
    @IBOutlet weak var cardSuitValueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
