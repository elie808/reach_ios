//
//  PerformanceCell.swift
//  reach-ios
//
//  Created by Elie El Khoury on 3/9/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit

class PerformanceCell: GenericTableCell<PerformanceItem> {
    
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var subtitleLabel : UILabel!
    @IBOutlet weak var pointsLabel : UILabel!
    @IBOutlet weak var pointsView : UIView!
    @IBOutlet weak var statusLabel : UILabel!
    @IBOutlet weak var statusView : UIImageView!
    
    override var model : PerformanceItem! {
        didSet {
            titleLabel.text = model.promotion
            subtitleLabel.text = model.product
            pointsLabel.text = String(model.points)
            
            if model.approved == true {
                statusLabel.text = "Approved"
                statusLabel.textColor = .reachGreen
                statusView.image = UIImage(named: "iconGreenTick")
                pointsView.backgroundColor = .reachGreen
            } else {
                statusLabel.text = "Pending"
                statusLabel.textColor = .gray
                statusView.image = UIImage(named: "iconGreyArrow")
                pointsView.backgroundColor = .lightGray
            }
        }
    }
}
