//
//  TrainingByCategoryCell.swift
//  reach-ios
//
//  Created by Elie El Khoury on 3/2/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit

class TrainingByCategoryCell: GenericTableCell<TrainingByCategory> {

    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var cellTitleLabel: UILabel!
    @IBOutlet weak var cellDesciptionLabel: UILabel!
    
    override var model : TrainingByCategory! {
        didSet {
            cellImageView.urlSetImage(model.image, #imageLiteral(resourceName: "LoginLogo"))
//            cellImageView.image = UIImage(data: try! Data(contentsOf: URL(string: model.image)! ))
            cellTitleLabel.text = model.title
            cellDesciptionLabel.text = model.description
        }
    }
}

