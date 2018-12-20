//
//  MyNameCell.swift
//  SystemTaskFindLogic
//
//  Created by Murali  on 19/12/18.
//  Copyright © 2018 NadboyTechnology. All rights reserved.
//

import UIKit

class MyNameCell: UITableViewCell {

    @IBOutlet weak var imgViewProfile: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imgViewProfile.layer.borderWidth=1.0
        imgViewProfile.layer.masksToBounds = false
        imgViewProfile.layer.borderColor = UIColor.blue.cgColor
        imgViewProfile.layer.cornerRadius =  imgViewProfile.frame.size.height/2
        imgViewProfile.clipsToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
