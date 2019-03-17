//
//  AddBrandCell.swift
//  reach-ios
//
//  Created by Elie El Khoury on 3/16/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit

protocol AddBrandCellDelegate {
    func deleteBrand(atIndex index:IndexPath)
}

class AddBrandCell: GenericTableCell<Brand> {
    
    @IBOutlet weak var cellImageView : UIImageView!
    @IBOutlet weak var nameLabel : UILabel!
    
    var cellDelegate : AddBrandCellDelegate?
    var cellIndex : IndexPath  = []
    
    override var model : Brand! {
        didSet {
            cellImageView.urlSetImage(model.image, #imageLiteral(resourceName: "LoginLogo"))
            nameLabel.text = model.name
        }
    }
    
    @IBAction func didTapDelete(_ sender: UIButton) {
        if let delegate = cellDelegate {
            delegate.deleteBrand(atIndex: self.cellIndex)
        }
    }
}
