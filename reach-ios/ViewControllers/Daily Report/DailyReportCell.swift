//
//  DailyReportCell.swift
//  reach-ios
//
//  Created by Elie El Khoury on 2/21/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit

protocol DailyReportCellDelegate {
    func deleteSaleItem(atIndex index:IndexPath)
}

class DailyReportCell: GenericTableCell<ReportSaleModel> {
    
    @IBOutlet weak var nameLabel : UILabel!
    @IBOutlet weak var serialLabel : UILabel!
    @IBOutlet weak var quantityLabel : UILabel!
    
    var cellDelegate : DailyReportCellDelegate?
    var cellIndex : IndexPath  = []
    
    override var model : ReportSaleModel! {
        didSet {
            nameLabel.text = model.productName
            serialLabel.text = model.serialNumber
            quantityLabel.text = "1"//String(model.quantity)
        }
    }
    
    @IBAction func didTapDelete(_ sender: UIButton) {
        if let delegate = cellDelegate {
            delegate.deleteSaleItem(atIndex: self.cellIndex)
        }
    }
}
