//
//  PersonalInfoTableViewController.swift
//  reach-ios
//
//  Created by Elie El Khoury on 2/23/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class PersonalInfoTableViewController: UITableViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var maleButton: UIButton!
    @IBOutlet weak var femaleButton: UIButton!
    
    @IBOutlet weak var firstNameTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var lastNameTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var mobileTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var dobTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var emailTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var passwordTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var companyTextField : SkyFloatingLabelTextField!
    @IBOutlet weak var TCButton : UIButton!

    // MARK: - Properties

    var selectedOrganization : Organization?
    var acceptedTC : Bool = false
    
    // MARK: - Views Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTCButtonState()
    }

    // MARK: - Helpers
    
    fileprivate func setTCButtonState() {
        
        if acceptedTC == false {
            TCButton.setBackgroundImage(UIImage(named: "SurveySelectRadioGreen"), for: .normal)
        } else {
            TCButton.setBackgroundImage(UIImage(named: "SelectedRadioGreen"), for: .normal)
        }
    }
    
    func formValid() -> Bool {
        
        var isValid = true
        
        guard let firstName = firstNameTextField.text else { return false }
        guard let lastName = lastNameTextField.text else { return false}
        guard let mobile = mobileTextField.text else { return false}
        guard let dob = dobTextField.text else { return false}
        guard let email = emailTextField.text else { return false }
        guard let password = passwordTextField.text else { return false }
        guard let company = companyTextField.text else { return false }

        if firstName.isEmpty {
            firstNameTextField.errorMessage = String.cantBeEmpty
            isValid = false
        } else {
            firstNameTextField.errorMessage = nil
        }
        
        if lastName.isEmpty {
            lastNameTextField.errorMessage = String.cantBeEmpty
            isValid = false
        } else {
            lastNameTextField.errorMessage = nil
        }
        
        if mobile.isEmpty {
            mobileTextField.errorMessage = String.cantBeEmpty
            isValid = false
        } else {
            mobileTextField.errorMessage = nil
        }

        if dob.isEmpty {
            dobTextField.errorMessage = String.cantBeEmpty
            isValid = false
        } else {
            dobTextField.errorMessage = nil
        }
        
        if !email.isEmpty && !email.isValidEmail() {
            emailTextField.errorMessage = String.emailFormatNotValid
            isValid = false
        } else {
            emailTextField.errorMessage = nil
        }
        
        if password.isEmpty {
            passwordTextField.errorMessage = String.passwordRequired
            isValid = false
        } else {
            passwordTextField.errorMessage = nil
        }
        
        if !password.isEmpty && password.count < 6 {
            passwordTextField.errorMessage = String.sixMinimumCharacters
            isValid = false
        } else {
            passwordTextField.errorMessage = nil
        }
        
        if company.isEmpty {
            companyTextField.errorMessage = String.cantBeEmpty
            isValid = false
        } else {
            companyTextField.errorMessage = nil
        }
        
        return isValid
    }
    
    // MARK: - Actions

    @IBAction func didTapMale(_ sender: UIButton) {
        femaleButton.setBackgroundImage(UIImage(named: "RegistrationFemaleOff"), for: .normal)
        maleButton.setBackgroundImage(UIImage(named: "RegistrationMale"), for: .normal)
    }
    
    @IBAction func didTapFemale(_ sender: UIButton) {
        femaleButton.setBackgroundImage(UIImage(named: "RegistrationFemale"), for: .normal)
        maleButton.setBackgroundImage(UIImage(named: "RegistrationMaleOff"), for: .normal)
    }
    
    @IBAction func didTapAcceptTerms(_ sender: UITapGestureRecognizer) {
        acceptedTC = !acceptedTC
        setTCButtonState()
    }
    
    // MARK: - Navigation

    @IBAction func unwindToPersonalInfoVC(segue : UIStoryboardSegue) {
        companyTextField.text = selectedOrganization?.name
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
}
