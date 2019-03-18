//
//  ReportSaleViewController.swift
//  reach-ios
//
//  Created by Elie El Khoury on 2/20/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit

struct ReportSaleModel : Codable {
    var productName : String = ""
    var serialNumber : String = ""
    var additionalInfo : String = ""
}

//"product_id": 32,
//            "serial_number": "111234",
//            "additional_info": "Additional info here",
//            "image": 1

struct Product {
    let name : String
}

class ReportSaleViewController: UITableViewController {

    // MARK: - Properties
    
    var viewModel = ReportSaleModel()
    var productDataSource : [Product] = []
    
    // MARK: - Outlets
    
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productIDLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var infoTextfield: UITextField!
    
    // MARK: - Views Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeView()
        
        productDataSource = [Product(name: "Product 1"), Product(name: "Product 2")]
    }
    
    func initializeView() {
        productNameLabel.text = viewModel.productName
        productIDLabel.text = viewModel.serialNumber
        infoTextfield.text = viewModel.additionalInfo
    }
    
    func formValid() -> Bool {
        
        var isValid = true
        
        if (productNameLabel.text?.isEmpty)! {
//            nameTextField.errorMessage = String.addressNameRequired
            isValid = false
        }
        
        if (productIDLabel.text?.isEmpty)! {
            isValid = false
        }
        
        if productImageView.image != nil {
            isValid = false
        }

        if (infoTextfield.text?.isEmpty)! {
            isValid = false
        }
        
        return isValid
    }
    
    // MARK: - Actions

    @IBAction func didTapProduct(_ sender: UIButton) {
        performSegue(withIdentifier: Segue.ReportSale.toProductList, sender: nil)
    }
    
    @IBAction func didTapScan(_ sender: UIButton) {
        performSegue(withIdentifier: Segue.ReportSale.toQRScannerVC, sender: nil)
    }
    
    @IBAction func didTapAddPhoto(_ sender: UITapGestureRecognizer) {
        
        let alertActions = [ UIAlertAction(title: "Take picture", style: .default) { (action) in self.openCamera() },
                             UIAlertAction(title: "Choose picture from gallery", style: .default) { (action) in self.openGallery() },
                             UIAlertAction(title: "Cancel", style: .cancel, handler: nil) ]
        
        present(UIAlertController.createActionSheet(title: "Add a photo", message: nil, actions: alertActions), animated: true, completion: nil)
    }
    
    @IBAction func didTapSubmit(_ sender: UIButton) {
        
//        if formValid() == true {
//        }
        performSegue(withIdentifier: Segue.ReportSale.toDailyReport, sender: nil)
    }
    
    // MARK: - Navigation

    @IBAction func unwindToReportSaleVC(segue: UIStoryboardSegue) {

        switch segue.identifier {
        
        case Segue.ProductList.toReportSale:
            productNameLabel.text = viewModel.productName
            
        case Segue.QRScanner.toReportSale:
            productIDLabel.text = viewModel.serialNumber
        
        default: return
        }
        
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        switch segue.identifier {
            
//        case Segue.ReportSale.toQRScannerVC:
            
        case Segue.ReportSale.toProductList:
            let vc : ProductListTableViewController = segue.destination as! ProductListTableViewController
            vc.dataSource = productDataSource
            
        default: return
        }
    }
}

extension ReportSaleViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if let text = textField.text {
            viewModel.additionalInfo = text
        }
        
        return textField.resignFirstResponder()
    }
}

extension ReportSaleViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
 
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        dismiss(animated: true) { self.productImageView.image = pickedImage }
    }
}
