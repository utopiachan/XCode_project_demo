//
//  WeekSummaryTableViewCell.swift
//  tutorial8
//
//  Created by mobiledev on 23/5/21.
//

import UIKit

class WeekSummaryTableViewCell: UITableViewCell {

    @IBOutlet weak var sImage: UIImageView!
    @IBOutlet weak var studentName: UILabel!
    @IBOutlet weak var studentID: UILabel!
    @IBOutlet weak var studentMark: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
