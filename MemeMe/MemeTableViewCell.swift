//
//  MemeTableViewCell.swift
//  MemeMe
//
//  Created by Selasi Kudolo on 2020-04-04.
//  Copyright © 2020 Ewe Cat Productions. All rights reserved.
//

import UIKit

class MemeTableViewCell: UITableViewCell {
    
    @IBOutlet var memeTableViewImageView: UIImageView!
    @IBOutlet var memeTableViewLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
