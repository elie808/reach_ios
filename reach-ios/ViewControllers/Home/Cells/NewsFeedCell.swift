//
//  NewsFeedCell.swift
//  reach-ios
//
//  Created by Elie El Khoury on 2/18/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit

class NewsFeedCell: GenericCollectionCell<NewsFeedItem> {
    
    @IBOutlet weak var imageView : UIImageView!
    @IBOutlet weak var textLabel : UILabel!
    @IBOutlet weak var subtitleLabel : UILabel!
    
    override var model : NewsFeedItem! {
        didSet {
            textLabel?.text = model.title
            subtitleLabel?.text = model.subtitle
            imageView.image = UIImage(named: model.imageName)
        }
    }
}
