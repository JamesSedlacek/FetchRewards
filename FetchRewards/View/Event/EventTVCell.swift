//
//  EventTVCell.swift
//  FetchRewards
//
//  Created by James Sedlacek on 5/18/21.
//

import UIKit

class EventTVCell: UITableViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var displayedImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var heartImageView: UIImageView!
    
    // MARK: - ViewDidLoad

    override func awakeFromNib() {
        super.awakeFromNib()
        displayedImageView.layer.cornerRadius = K.Numbers.cornerRadius
    }
}
