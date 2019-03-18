//
//  UIViewController+Helpers.swift
//  reach-ios
//
//  Created by Elie El Khoury on 2/13/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit
import SVProgressHUD

extension UIViewController {
    
    // MARK: - Properties
    
    enum BannerMessage : String {
        case SuccessUpdate = "Success"
        case SuccessPostingSales = "Sales post success"
        case ErrorPosting = "No results found"
        case NoResults = ""
    }
    
    // MARK: - AlertControllers
    
    func show(alert title:String, message:String, buttonTitle:String, onSuccess success: (() -> Void)?)  {
        
        let actionSheet : UIAlertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        actionSheet.addAction(UIAlertAction(title: buttonTitle, style: UIAlertAction.Style.default, handler: { (action) in
            guard let successClosure = success else { return }
            successClosure()
        }))
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    func show(twoButtonAlert title:String, message:String, buttonOneTitle:String, buttonTwoTitle:String, onConfirm confirm:(() -> Void)?,
              onCancel cancel: (() -> Void)?)  {
        
        let actionSheet : UIAlertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        actionSheet.addAction(UIAlertAction(title: buttonOneTitle, style: .default, handler: { (action) in
            guard let confirmClosure = confirm else { return }
            confirmClosure()
        }))
        
        actionSheet.addAction(UIAlertAction(title: buttonTwoTitle, style: .destructive, handler: { (action) in
            guard let cancelClosure = cancel else { return }
            cancelClosure()
        }))
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    // MARK: - Top Banner
    
    func showBanner(message : BannerMessage) {
        
        var title = "Success"
        var subtitle = "Success"
        var image = UIImage(named: "iconGreenTick")
        
        var defaultTitleColor = #colorLiteral(red: 0, green: 0.7098039216, blue: 0.7098039216, alpha: 1)
        var defaultSubTitleColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        

        switch message {
            
        case .SuccessUpdate:
            title = "Success"
            subtitle = "Information is updated"
            image = #imageLiteral(resourceName: "iconGreenTick")
        
        case .SuccessPostingSales:
            title = "Success"
            subtitle = "Your sales have been uploaded for approval"
            image = #imageLiteral(resourceName: "iconGreenTick")
            
        case .ErrorPosting:
            title = "Error"
            subtitle = "There was an error posting sales data"
            defaultTitleColor = #colorLiteral(red: 1, green: 0, blue: 0.4065560102, alpha: 1)
            
        case .NoResults:
            title = "Not Found"
            subtitle = "No results found"
//            image = UIImage(named: "banner_cache")
        }
        
        let banner = Banner(title: title, subtitle: subtitle, image: image, backgroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) )
        //        banner.detailLabel.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.headline)
        banner.titleLabel.textColor = defaultTitleColor
        banner.detailLabel.textColor = defaultSubTitleColor
        banner.dismissesOnTap = true
        banner.show(duration: 2.4)
    }
    
    // MARK: - Helpers
    
    func openCamera() {
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
            imagePicker.sourceType = .camera;
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func openGallery() {
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
            imagePicker.sourceType = .photoLibrary;
            imagePicker.allowsEditing = true
            
            present(imagePicker, animated: true, completion: nil)
        }
    }
}
