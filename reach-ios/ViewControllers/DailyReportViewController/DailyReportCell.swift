//
//  DailyReportCell.swift
//  reach-ios
//
//  Created by Elie El Khoury on 2/21/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit

class DailyReportCell: GenericTableCell<DailyReport> {
    
    @IBOutlet weak var nameLabel : UILabel!
    @IBOutlet weak var serialLabel : UILabel!
    @IBOutlet weak var quantityLabel : UILabel!
    
    override var model : DailyReport! {
        didSet {
            nameLabel.text = model.name
            serialLabel.text = model.serial
            quantityLabel.text = String(model.quantity)
        }
    }
}
