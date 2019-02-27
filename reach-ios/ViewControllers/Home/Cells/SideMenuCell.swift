//
//  SideMenuCell.swift
//  reach-ios
//
//  Created by Elie El Khoury on 2/19/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit

class SideMenuCell: GenericTableCell<SideMenuItem> {
    
    @IBOutlet weak var cellImageView : UIImageView!
    @IBOutlet weak var cellTextLabel : UILabel!
    
    override var model : SideMenuItem! {
        didSet {
            cellTextLabel?.text = model.name
            cellImageView?.image = UIImage(named: model.image)
        }
    }
}
