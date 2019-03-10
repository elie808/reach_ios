//
//  BrandsCell.swift
//  reach-ios
//
//  Created by Elie El Khoury on 3/10/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit

class BrandsCell: GenericCollectionCell<Brand> {
    
    // MARK: - Outlets
    
    @IBOutlet weak var nameLabel : UILabel!
    @IBOutlet weak var bottomBar : UIView!
    
    // MARK: - Properties
    
    override var model : Brand! {
        didSet {
            nameLabel.alpha = 0.3
            bottomBar.backgroundColor = .clear
            nameLabel.text = model.name.uppercased()
        }
    }
    
    override var isSelected: Bool{
        didSet {
            if self.isSelected {
                nameLabel.alpha = 1.0
                bottomBar.backgroundColor = .white
            } else {
                nameLabel.alpha = 0.3
                bottomBar.backgroundColor = .clear
            }
        }
    }
    
}
