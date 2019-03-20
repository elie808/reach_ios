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
    @IBOutlet weak var TCButton : UIImageView!

    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var TCLabel: UILabel!
    
    // MARK: - Properties

    var selectedOrganization : Organization?
    var acceptedTC : Bool = false {
        didSet {
            if acceptedTC == false {
                TCButton.image = #imageLiteral(resourceName: "SurveySelectRadioGreen")
            } else {
                TCButton.image = #imageLiteral(resourceName: "SelectedRadioGreen")
            }
        }
    }
    
    private enum Gender : String {
        case Male = "Male"
        case Female = "Female"
    }
    
    var selectedGender : String = "" {
        didSet {
            switch selectedGender {
            
            case Gender.Male.rawValue:
                maleButton.setImage(#imageLiteral(resourceName: "RegistrationMale"), for: .normal)
                femaleButton.setImage(#imageLiteral(resourceName: "RegistrationFemaleOff"), for: .normal)
                
            case Gender.Female.rawValue:
                femaleButton.setImage(#imageLiteral(resourceName: "RegistrationFemale"), for: .normal)
                maleButton.setImage(#imageLiteral(resourceName: "RegistrationMaleOff"), for: .normal)
                
            default: return
            }
        }
    }
    
    // MARK: - Views Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
//        stubs()
    }

    private func stubs() {
        firstNameTextField.text = "First"
        lastNameTextField.text = "Last"
        mobileTextField.text = "123456789"
        dobTextField.text = "1995-02-12"
        emailTextField.text = "testwr@mail.com"
        passwordTextField.text = "password"
    }
    
    // MARK: - Helpers
    
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
        
        if !dob.isValidDate() {
            dobTextField.errorMessage = String.wrongDateFormat
            isValid = false
        } else {
            dobTextField.errorMessage = nil
        }
        
        if email.isEmpty {
            emailTextField.errorMessage = String.cantBeEmpty
            isValid = false
        } else {
            emailTextField.errorMessage = nil
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
        
        if selectedGender == "" {
            isValid = false
            genderLabel.textColor = .red
        } else {
            genderLabel.textColor = .reachGreen
        }
        
        if acceptedTC == false {
            isValid = false
            TCLabel.textColor = .red
        } else {
            TCLabel.textColor = .black
        }
        
        return isValid
    }
    
    /// Used to send information to RegisterVC
    func getUserInfo() -> RegisterUserObject {

        return RegisterUserObject(first_name: firstNameTextField.text!,
                                  last_name: lastNameTextField.text!,
                                  mobile_number: mobileTextField.text!,
                                  date_of_birth: dobTextField.text!,
                                  email : emailTextField.text!,
                                  password : passwordTextField.text!,
                                  gender: selectedGender,
                                  organization: (selectedOrganization?.id)!,
                                  image_id: 0,
                                  brands:[],
                                  message:nil)
    }
    
    // MARK: - Actions

    @IBAction func didTapMale(_ sender: UIButton) {
        selectedGender = Gender.Male.rawValue
    }
    
    @IBAction func didTapFemale(_ sender: UIButton) {
        selectedGender = Gender.Female.rawValue
    }
    
    @IBAction func didTapAcceptTerms(_ sender: UITapGestureRecognizer) {
        acceptedTC = !acceptedTC
    }
    
    // MARK: - Navigation

    @IBAction func unwindToPersonalInfoVC(segue : UIStoryboardSegue) {
        companyTextField.text = selectedOrganization?.name
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
}

extension PersonalInfoTableViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == firstNameTextField {
            return lastNameTextField.becomeFirstResponder()
        } else if textField == lastNameTextField {
            return mobileTextField.becomeFirstResponder()
        } else if textField == mobileTextField {
            return dobTextField.becomeFirstResponder()
        } else if textField == dobTextField {
            return emailTextField.becomeFirstResponder()
        } else if textField == emailTextField {
            return passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            return textField.resignFirstResponder()
        } else {
            return textField.resignFirstResponder()
        }
    }
}
