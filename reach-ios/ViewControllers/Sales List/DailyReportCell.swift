//
//  DailyReportCell.swift
//  reach-ios
//
//  Created by Elie El Khoury on 2/21/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit

class DailyReportCell: GenericTableCell<SaleViewModel> {
    
    @IBOutlet weak var nameLabel : UILabel!
    @IBOutlet weak var serialLabel : UILabel!
    @IBOutlet weak var quantityLabel : UILabel!
    @IBOutlet weak var saleImageView : UIImageView!
    
    var didTapRemove: ((IndexPath) -> Void)?
    var cellIndex : IndexPath  = []
    
    override var model : SaleViewModel! {
        didSet {
            nameLabel.text = model.sale.productName
            serialLabel.text = model.sale.serialNumber
            quantityLabel.text = "1" //String(model.quantity)
            
            if let imageData = model.imageData {
                self.saleImageView.image = UIImage(data: imageData)
            } else {
                if let imageView = self.saleImageView {
                    imageView.removeFromSuperview()
                }
            }
        }
    }
    
    @IBAction func didTapDelete(_ sender: UIButton) {
        didTapRemove?(cellIndex)
    }
}
