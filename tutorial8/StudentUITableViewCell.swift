//
//  StudentUITableViewCell.swift
//  tutorial8
//
//  Created by mobiledev on 16/5/21.
//

import UIKit

class StudentUITableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var titleLabel: UILabel!
   
    @IBOutlet weak var studentImage: UIImageView!
    @IBOutlet weak var subTitleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
