//
//  EditSaleViewController.swift
//  reach-ios
//
//  Created by Elie El Khoury on 3/22/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit

class EditSaleViewController: ReportSaleViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Actions
    
    @IBAction func didTapProductName(_ sender: Any) {
        print("Product")
    }
    
    @IBAction override func didTapScan(_ sender: UIButton) {
        print("Scan")
    }
    
    @IBAction override func didTapAddPhoto(_ sender: UITapGestureRecognizer) {
        super.didTapAddPhoto(sender)
    }
    
    @IBAction func didTapSave(_ sender: UIButton) {
        print("Save")
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
