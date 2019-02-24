//
//  ProfileTableViewController.swift
//  reach-ios
//
//  Created by Elie El Khoury on 2/24/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class ProfileTableViewController: UITableViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var barButton: UIBarButtonItem!
    
    @IBOutlet weak var mobileTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var dobTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var emailTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var IAmTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var companyTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var typeTextField: SkyFloatingLabelTextField!
    
    // MARK: - Properties
    
    var editingProfile: Bool = false
    
    // MARK: - Views Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    // MARK: - Helpers
    
    func initializeView() {
        
        mobileTextField.text? = "test"
        dobTextField.text? = "sads"
        emailTextField.text? = ""
        IAmTextField.text? = ""
        companyTextField.text? = ""
        typeTextField.text? = ""
    }
    
    func formValid() -> Bool {
        
        var flag = true
        
        if mobileTextField.text?.isEmpty == true {
            mobileTextField.errorMessage = String.cantBeEmpty
            flag = false
        } else {
            mobileTextField.errorMessage = nil
            flag = true
        }
        
        if dobTextField.text?.isEmpty == true {
            dobTextField.errorMessage = String.cantBeEmpty
            flag = false
        } else {
            dobTextField.errorMessage = nil
            flag = true
        }
        
        if emailTextField.text?.isEmpty == true {
            emailTextField.errorMessage = String.cantBeEmpty
            flag = false
        } else {
            emailTextField.errorMessage = nil
            flag = true
        }
        
        if IAmTextField.text?.isEmpty == true {
            IAmTextField.errorMessage = String.cantBeEmpty
            flag = false
        } else {
            IAmTextField.errorMessage = nil
            flag = true
        }
        
        if companyTextField.text?.isEmpty == true {
            companyTextField.errorMessage = String.cantBeEmpty
            flag = false
        } else {
            companyTextField.errorMessage = nil
            flag = true
        }
        
        if typeTextField.text?.isEmpty == true {
            typeTextField.errorMessage = String.cantBeEmpty
            flag = false
        } else {
            typeTextField.errorMessage = nil
            flag = true
        }
        
        return flag
    }
    
    // MARK: - Actions
    
    @IBAction func didTapEdit(_ sender: UIBarButtonItem) {
        
        editingProfile = !editingProfile
        barButton.title = editingProfile == true ? "Save" : "Edit"
        
        if editingProfile == true {
            
            mobileTextField.isEnabled = true
            dobTextField.isEnabled = true
            emailTextField.isEnabled = true
            IAmTextField.isEnabled = true
            companyTextField.isEnabled = true
            typeTextField.isEnabled = true
            
        } else {
            
            if formValid() == true {
                
                editingProfile = false
                
                mobileTextField.isEnabled = false
                dobTextField.isEnabled   = false
                emailTextField.isEnabled = false
                IAmTextField.isEnabled   = false
                companyTextField.isEnabled  = false
                typeTextField.isEnabled     = false
            
            } else {
                
                editingProfile = true
                barButton.title = "Edit"
            }
        }
    }
    
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }

}

extension ProfileTableViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
}
