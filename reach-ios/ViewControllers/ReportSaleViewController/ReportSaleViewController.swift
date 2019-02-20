//
//  ReportSaleViewController.swift
//  reach-ios
//
//  Created by Elie El Khoury on 2/20/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit

struct ReportSaleModel {
    var serialNumber : String = ""
}

class ReportSaleViewController: UITableViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productIDLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var infoTextfield: UITextField!
    
    // MARK: - Properties
    
    var viewModel = ReportSaleModel()
    
    // MARK: - Views Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeView()
    }
    
    func initializeView() {
        productIDLabel.text = viewModel.serialNumber
    }
    
    // MARK: - Actions

    @IBAction func didTapProduct(_ sender: UIButton) {
    }
    
    @IBAction func didTapScan(_ sender: UIButton) {
        performSegue(withIdentifier: Segue.ReportSale.toQRScannerVC, sender: nil)
    }
    
    @IBAction func didTapAddPhoto(_ sender: UITapGestureRecognizer) {
    }
    
    @IBAction func didTapSubmit(_ sender: UIButton) {
    }
    
    // MARK: - Navigation

    @IBAction func unwindToReportSaleVC(segue: UIStoryboardSegue) {
        productIDLabel.text = viewModel.serialNumber 
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        switch segue.identifier {
        case Segue.ReportSale.toQRScannerVC:
            print("qr")
        default: return
        }
    }

}
