//
//  ReportSaleViewController.swift
//  reach-ios
//
//  Created by Elie El Khoury on 2/20/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import SwiftyUserDefaults

struct ReportSaleModel : Codable, DefaultsSerializable {
    
    var productID : Int = 0
    var productName : String = ""
    
    var serialNumber : String = ""
    var additionalInfo : String = ""
    
    var image : Int = 0

    private enum CodingKeys: String, CodingKey {
        case productName, image
        case serialNumber = "serial_number"
        case additionalInfo = "additional_info"
        case productID = "product_id"
    }
}

class ReportSaleViewController: UITableViewController {

    // MARK: - Properties
    
    var selectedProduct : Product? // passed from ProductListTC
    var viewModel = ReportSaleModel()
    
    // MARK: - Outlets

    @IBOutlet weak var productNameTextField : SkyFloatingLabelTextField!
    @IBOutlet weak var productIDTextField : SkyFloatingLabelTextField!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var infoTextfield: SkyFloatingLabelTextField!
    
    // MARK: - Views Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeView()
    }
    
    // MARK: - Helpers
    
    func initializeView() {
        productNameTextField.text = viewModel.productName
        productIDTextField.text = viewModel.serialNumber
        infoTextfield.text = viewModel.additionalInfo
    }
    
    func formValid() -> Bool {
        
        var isValid = true
        
        if (productNameTextField.text?.isEmpty)! {
            productNameTextField.errorMessage = .cantBeEmpty
            isValid = false
        } else {
            productNameTextField.errorMessage = nil
        }
        
        if (productIDTextField.text?.isEmpty)! {
            productIDTextField.errorMessage = .cantBeEmpty
            isValid = false
        } else {
            productIDTextField.errorMessage = nil
        }
        
        if productImageView.image != nil {
            isValid = false
        }

        if (infoTextfield.text?.isEmpty)! {
            infoTextfield.errorMessage = .cantBeEmpty
            isValid = false
        } else {
            infoTextfield.errorMessage = nil
        }
        
        return isValid
    }
    
    /// Return an initiated data model with values from the VC
    func bindToViewModel() -> ReportSaleModel {
        
        let model = ReportSaleModel(productID: selectedProduct != nil ? (selectedProduct?.id)! : viewModel.productID,
                                    productName: productNameTextField.text!,
                                    serialNumber: productIDTextField.text!,
                                    additionalInfo: infoTextfield.text!,
                                    image: 0)
        
        return model
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
        
        if formValid() == true {
            performSegue(withIdentifier: Segue.ReportSale.toDailyReport, sender: bindToViewModel())
        }
    }
    
    // MARK: - Navigation

    @IBAction func unwindToReportSaleVC(segue: UIStoryboardSegue) {

        switch segue.identifier {
        
        case Segue.ProductList.toReportSale:
            productNameTextField.text = viewModel.productName
            
        case Segue.QRScanner.toReportSale:
            productIDTextField.text = viewModel.serialNumber
        
        default: return
        }
        
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        switch segue.identifier {
            
        case Segue.ReportSale.toDailyReport:
//            let vc = segue.destination as! DailyReportViewController
            if let saleObj = sender, saleObj is ReportSaleModel {
                //TODO: stuff
            }
            
        default: return
        }
    }
}

extension ReportSaleViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        _ = formValid()
        return textField.resignFirstResponder()
    }
}

extension ReportSaleViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
 
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        dismiss(animated: true) { self.productImageView.image = pickedImage }
    }
}
