//
//  ReportSaleViewController.swift
//  reach-ios
//
//  Created by Elie El Khoury on 2/20/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit

class ReportSaleViewController: UITableViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productIDLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var infoTextfield: UITextField!
    
    // MARK: - Properties
    
    // MARK: - Views Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - Actions

    @IBAction func didTapProduct(_ sender: UIButton) {
    }
    
    @IBAction func didTapScan(_ sender: UIButton) {
    }
    
    @IBAction func didTapAddPhoto(_ sender: UITapGestureRecognizer) {
    }
    
    @IBAction func didTapSubmit(_ sender: UIButton) {
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
