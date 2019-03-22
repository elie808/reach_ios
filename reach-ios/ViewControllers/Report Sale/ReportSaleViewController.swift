//
//  ReportSaleViewController.swift
//  reach-ios
//
//  Created by Elie El Khoury on 2/20/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class ReportSaleViewController: UITableViewController {

    // MARK: - Properties
    
    var viewModel : SaleViewModel = SaleViewModel() {
        didSet {
            if let product = viewModel.product {
                if product.image_required == 1 {
                    if let label = imageOptionlLabel{
                        label.isHidden = true
                    }
                } else {
                    if let label = imageOptionlLabel{
                        label.isHidden = false
                    }
                }
            }
        }
    }

    // MARK: - Outlets

    @IBOutlet weak var productNameTextField : SkyFloatingLabelTextField!
    @IBOutlet weak var productIDTextField : SkyFloatingLabelTextField!
    @IBOutlet weak var productImageLabel : UILabel!
    @IBOutlet weak var imageOptionlLabel : UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var infoTextfield: SkyFloatingLabelTextField!
    
    // MARK: - Views Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeView()
    }
    
    // MARK: - Helpers
    
    func initializeView() {
        productNameTextField.text = viewModel.product?.name
        productIDTextField.text = viewModel.sale.serialNumber
        infoTextfield.text = viewModel.sale.additionalInfo
    }
    
    func resetForm() {
        imageOptionlLabel.isHidden = true
        productNameTextField.text = ""
        productIDTextField.text = ""
        productImageView.image = nil
        infoTextfield.text = ""
    }
    
    func formValid() -> Bool {
        
        var isValid = true
        
        if (productNameTextField.text?.isEmpty)! {
            productNameTextField.errorMessage = .cantBeEmpty
            isValid = false
        } else {
            productNameTextField.errorMessage = nil
        }
        
        guard let product = viewModel.product else { return false }
        
        if (productIDTextField.text?.isEmpty)! {
            productIDTextField.errorMessage = .cantBeEmpty
            isValid = false
        } else {
            productIDTextField.errorMessage = nil
        }
        
        if product.serial_number_required == 1 {
            if product.image_required == 1 {
                if productImageView.image == nil {
                    isValid = false
                    productImageLabel.textColor = #colorLiteral(red: 0.7669542101, green: 0, blue: 0.003921568627, alpha: 1)
                } else {
                    productImageLabel.textColor = #colorLiteral(red: 0, green: 0.7098039216, blue: 0.7098039216, alpha: 1)
                }
            }
        }
        
        if product.description_required == 1 {
            if (infoTextfield.text?.isEmpty)! {
                infoTextfield.errorMessage = .cantBeEmpty
                isValid = false
            } else {
                infoTextfield.errorMessage = nil
            }
        }

        return isValid
    }
    
    /// Return an initiated data model with values from the VC
    func bindToViewModel() -> Sale {

        let model = Sale(productID: (viewModel.product?.promotions_products_id)!,
                         productName: productNameTextField.text!,
                         serialNumber: productIDTextField.text!,
                         additionalInfo: infoTextfield.text!, image: 0)

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
            productNameTextField.text = viewModel.product?.name
            
        case Segue.QRScanner.toReportSale:
            productIDTextField.text = viewModel.sale.serialNumber
        
        default: return
        }
        
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        switch segue.identifier {
            
        case Segue.ReportSale.toDailyReport:
            if let saleObj = sender, saleObj is Sale {
                let salesView = SaleViewModel(sale: (saleObj as! Sale), product: viewModel.product)
                PersistenceManager.save(saleObject: salesView)
                resetForm()
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
        
        dismiss(animated: true) {
            self.productImageView.image = pickedImage
            _ = self.formValid()
        }
    }
}
