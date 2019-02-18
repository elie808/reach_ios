//
//  SideMenuCell.swift
//  reach-ios
//
//  Created by Elie El Khoury on 2/19/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit

class SideMenuCell: GenericTableCell<SideMenuItem> {
    
    //    @IBOutlet weak var imageView : UIImageView!
    //    @IBOutlet weak var textLabel : UILabel!
    
    override var model : SideMenuItem! {
        didSet {
            textLabel?.text = model.name
            imageView?.image = UIImage(named: model.image)
        }
    }
}
