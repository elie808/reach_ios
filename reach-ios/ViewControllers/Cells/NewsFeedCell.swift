//
//  NewsFeedCell.swift
//  reach-ios
//
//  Created by Elie El Khoury on 2/18/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit

class NewsFeedCell: GenericCollectionCell<Person> {
    
    @IBOutlet weak var textLabel : UILabel!
    
    override var model : Person! {
        didSet {
            textLabel?.text = model.firstName
        }
    }
}
