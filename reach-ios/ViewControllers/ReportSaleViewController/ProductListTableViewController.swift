//
//  ProductListTableViewController.swift
//  reach-ios
//
//  Created by Elie El Khoury on 2/20/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit

class ProductListCell: GenericTableCell<Product> {

    override var model : Product! {
        didSet {
            textLabel?.text = model.name
        }
    }
}

class ProductListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.dataSource is GenericTableDataSource<GenericTableCell<Product>, Product> {

            let prod : Product = ((tableView.dataSource as! GenericTableDataSource<GenericTableCell<Product>, Product>).data)[indexPath.row]
            performSegue(withIdentifier: Segue.ProductList.toReportSale, sender: prod)
        }
    }
    
    // MARK: - Navigation

     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
            
        case Segue.ProductList.toReportSale:
            let vc : ReportSaleViewController = segue.destination as! ReportSaleViewController
            if let product = sender {
                if product is Product {
                    vc.viewModel.productName = (product as! Product).name
                }
            }
            
        default: return
        }
    }

}
