//
//  NewsCell.swift
//  reach-ios
//
//  Created by Elie El Khoury on 2/25/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit

class NewsCell : GenericCollectionCell<NewsItem> {
    
    @IBOutlet weak var imageView : UIImageView!
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var descriptionLabel : UILabel!
    @IBOutlet weak var dateLabel : UILabel!
    
    override var model : NewsItem! {
        didSet {
            imageView.urlSetImage(model.image, #imageLiteral(resourceName: "LoginLogo"))
            titleLabel?.text = model.name
            dateLabel?.text = model.date //Date(timeIntervalSince1970: (model?.date)!).toString(withFormat: .DateFull)
            descriptionLabel?.text = "Learn More" //model.description
        }
    }
    
}
