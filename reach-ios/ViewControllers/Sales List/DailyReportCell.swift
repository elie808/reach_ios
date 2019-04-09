//
//  DailyReportCell.swift
//  reach-ios
//
//  Created by Elie El Khoury on 2/21/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit

class DailyReportCell: GenericTableCell<Sale> {
    
    @IBOutlet weak var nameLabel : UILabel!
    @IBOutlet weak var serialLabel : UILabel!
    @IBOutlet weak var quantityLabel : UILabel!
    @IBOutlet weak var saleImageView : UIImageView!
    
    var didTapRemove: ((IndexPath) -> Void)?
    var cellIndex : IndexPath  = []
    
    override var model : Sale! {
        didSet {
            nameLabel.text = model.productName
            serialLabel.text = model.serialNumber
            quantityLabel.text = "1"//String(model.quantity)
        }
    }
    
    @IBAction func didTapDelete(_ sender: UIButton) {
        didTapRemove?(cellIndex)
    }
}
