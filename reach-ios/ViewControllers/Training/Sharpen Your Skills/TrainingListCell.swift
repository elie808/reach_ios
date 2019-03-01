//
//  TrainingListCell.swift
//  reach-ios
//
//  Created by Elie El Khoury on 3/1/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit

class TrainingListCell: GenericCollectionCell<TrainingListItems> {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override var model : TrainingListItems! {
        didSet {
//            imageView.image = UIImage(named: model.imageName)
            titleLabel.text = model.category
        }
    }
}

