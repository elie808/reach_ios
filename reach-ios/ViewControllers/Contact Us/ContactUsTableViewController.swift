//
//  ContactUsTableViewController.swift
//  reach-ios
//
//  Created by Elie El Khoury on 3/7/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class ContactUsTableViewController: UITableViewController {

    // MARK: - Outlets
    
    
    @IBOutlet var toolbar: UIToolbar!
    @IBOutlet weak var titleTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var messageTextView: UITextView!
    
    // MARK: - Properties
    
    // MARK: - Views Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        messageTextView.inputAccessoryView = toolbar
        messageTextView.layer.borderWidth = 2.0;
        messageTextView.layer.borderColor = UIColor.reachGreen.cgColor
    }

    // MARK: - Helpers
    
    func formValid() -> Bool {
        
        var isValid = true
        
        if (titleTextField.text?.isEmpty)! {
            titleTextField.errorMessage = String.cantBeEmpty
            isValid = false
        } else {
            titleTextField.errorMessage = nil
        }
        
        if (messageTextView.text?.isEmpty)! {
            messageTextView.layer.borderColor = UIColor.red.cgColor
            isValid = false
        } else {
            messageTextView.layer.borderColor = UIColor.reachGreen.cgColor
        }
        
        return isValid
    }
    
    // MARK: - Actions
    
    @IBAction func didTapDone(_ sender: UIBarButtonItem) {
        messageTextView.resignFirstResponder()
    }
    
    @IBAction func didTapSubmit(_ sender: UIButton) {
        
        if formValid() == true {
            
        }
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

extension ContactUsTableViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return messageTextView.becomeFirstResponder()
    }
}
