//
//  TrainingListCell.swift
//  reach-ios
//
//  Created by Elie El Khoury on 3/1/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit

class TrainingListCell: GenericCollectionCell<TrainingListItem> {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var cellIndex : IndexPath! {
        didSet {
            switch cellIndex.row % 3 {
            case 0: self.backgroundColor = #colorLiteral(red: 0, green: 0.7098039216, blue: 0.7098039216, alpha: 1)
            case 1: self.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.7803921569, blue: 0.003921568627, alpha: 1)
            case 2: self.backgroundColor = #colorLiteral(red: 0.9882352941, green: 0.5058823529, blue: 0.007843137255, alpha: 1)
            default: self.backgroundColor = #colorLiteral(red: 0, green: 0.7098039216, blue: 0.7098039216, alpha: 1)
            }
        }
    }
    
    override var model : TrainingListItem! {
        didSet {
            imageView.urlSetImage(model.image, #imageLiteral(resourceName: "LoginLogo"))
            titleLabel.text = model.category
        }
    }
}

