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
    @IBOutlet weak var toolbar : UIToolbar!
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var firstNameTextfield: SkyFloatingLabelTextField!
    @IBOutlet weak var lastNameTextfield: SkyFloatingLabelTextField!
    @IBOutlet weak var mobileTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var dobTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var emailTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var IAmTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var companyTextField: SkyFloatingLabelTextField!
//    @IBOutlet weak var typeTextField: SkyFloatingLabelTextField!
    
    // MARK: - Properties
    
    var org : Organization?
    
    // MARK: - Views Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeView()
    }

    // MARK: - Helpers
    
    func initializeView() {

        self.mobileTextField.inputAccessoryView = self.toolbar
        self.dobTextField.inputAccessoryView = self.toolbar
        
        let profile = Resource<User>(get: URL(string: NetworkingConstants.profile)!)
        
        URLSession.shared.load(profile) { (user, status) in
           
            self.org = (user?.organization)!
            
            self.profileImageView.urlSetImage(user?.image)
            
            self.firstNameTextfield.text? = user?.firstName ?? ""
            self.lastNameTextfield.text? = user?.lastName ?? ""
            
            self.mobileTextField.text? = user?.mobileNumber ?? ""
            self.dobTextField.text? = user?.mobileNumber ?? ""
            self.IAmTextField.text? = user?.gender ?? ""
            self.emailTextField.text? = user?.email ?? ""
            self.companyTextField.text? = user?.organization.name ?? ""
        }
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
        
//        if typeTextField.text?.isEmpty == true {
//            typeTextField.errorMessage = String.cantBeEmpty
//            flag = false
//        } else {
//            typeTextField.errorMessage = nil
//            flag = true
//        }
        
        return flag
    }
    
    // MARK: - Actions
    
    @IBAction func didTapDone(_ sender: UIBarButtonItem) {
        mobileTextField.resignFirstResponder()
        dobTextField.resignFirstResponder()
    }
    
    @IBAction func didTapEdit(_ sender: UIBarButtonItem) {
        
        if formValid() == true {
            
            guard let firstName = firstNameTextfield.text else { return }
            guard let lastName = lastNameTextfield.text else { return }
            guard let mobile = mobileTextField.text else { return }
            guard let dob = dobTextField.text else { return }
            guard let gender = IAmTextField.text else { return }
            
            let postParameters = [
                "first_name": firstName,
                "last_name": lastName,
                "mobile_number": mobile,
                "date_of_birth": dob,
                "gender": gender,
                "image": "123",
                "organization": "3"//String(self.org!.id)
                ]
            
            let updateProfile = Resource<AuthenticationData>(url: URL(string: NetworkingConstants.profile)!, method: HttpMethod.patch(postParameters))
            
//            URLSession.shared.load(updateProfile) { (updatedProfile, status) in
//
//            }
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
