//
//  FeedbackFormCell.swift
//  reach-ios
//
//  Created by Elie El Khoury on 3/24/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit

class FeedbackFormCell: UITableViewCell {
    
    @IBOutlet weak var cellAccessoryImageView : UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func configure(with feedback:FeedbackRating) {
        if feedback.isSelected == true {
            cellAccessoryImageView.image = #imageLiteral(resourceName: "SurveySelectedRadio")
        } else {
            cellAccessoryImageView.image = #imageLiteral(resourceName: "SurveySelectRadio")
        }
    }
}
