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
    @IBOutlet var datePickerView: UIView!
    
    // MARK: - Properties
    
    struct postObj : Codable  {
        let first_name, last_name, mobile_number, date_of_birth, gender : String
        let image, organization : Int
    }
    
    var pickedImageID : Int?
    var org : Organization?
    
    // MARK: - Views Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dobTextField.inputView = datePickerView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        initializeView()
    }

    // MARK: - Helpers
    
    func initializeView() {

        self.mobileTextField.inputAccessoryView = self.toolbar
//        self.dobTextField.inputAccessoryView = self.toolbar
        
        let profile = Resource<User>(get: URL(string: NetworkingConstants.profile)!)
        
        URLSession.shared.load(profile) { (user, status) in
           
            self.org = (user?.organization)!
            
            self.profileImageView.urlSetImage(user?.image)
            
            self.firstNameTextfield.text? = user?.firstName ?? ""
            self.lastNameTextfield.text? = user?.lastName ?? ""
            
            self.mobileTextField.text? = user?.mobileNumber ?? ""
            self.dobTextField.text? = user?.dob ?? ""
            self.IAmTextField.text? = user?.gender ?? ""
            self.emailTextField.text? = user?.email ?? ""
            self.companyTextField.text? = user?.organization.name ?? ""
        }
    }
    
    func formValid() -> Bool {
        
        var isValid = true
        
        guard let dob = dobTextField.text else { return false }
  
        if firstNameTextfield.text?.isEmpty == true {
            firstNameTextfield.errorMessage = String.cantBeEmpty
            isValid = false
        } else {
            firstNameTextfield.errorMessage = nil
        }
        
        if lastNameTextfield.text?.isEmpty == true {
            lastNameTextfield.errorMessage = String.cantBeEmpty
            isValid = false
        } else {
            lastNameTextfield.errorMessage = nil
        }
        
        if mobileTextField.text?.isEmpty == true {
            mobileTextField.errorMessage = String.cantBeEmpty
            isValid = false
        } else {
            mobileTextField.errorMessage = nil
        }
        
        if dobTextField.text?.isEmpty == true {
            dobTextField.errorMessage = String.cantBeEmpty
            isValid = false
        } else {
            dobTextField.errorMessage = nil
        }
        
        if !dob.isEmpty && !dob.isValidDate() {
            dobTextField.errorMessage = String.wrongDateFormat
            isValid = false
        } else {
            dobTextField.errorMessage = nil
        }
        
        if emailTextField.text?.isEmpty == true {
            emailTextField.errorMessage = String.cantBeEmpty
            isValid = false
        } else {
            emailTextField.errorMessage = nil
        }
        
        if IAmTextField.text?.isEmpty == true {
            IAmTextField.errorMessage = String.cantBeEmpty
            isValid = false
        } else {
            IAmTextField.errorMessage = nil
        }
        
        if companyTextField.text?.isEmpty == true {
            companyTextField.errorMessage = String.cantBeEmpty
            isValid = false
        } else {
            companyTextField.errorMessage = nil
        }
        
        return isValid
    }
    
    // MARK: - Actions
    
    @IBAction func didTapProfilePicture(_ sender: UITapGestureRecognizer) {
        
        let alertActions = [ UIAlertAction(title: "Take picture", style: .default) { (action) in self.openCamera() },
                             UIAlertAction(title: "Choose picture from gallery", style: .default) { (action) in self.openGallery() },
                             UIAlertAction(title: "Cancel", style: .cancel, handler: nil) ]
        
        present(UIAlertController.createActionSheet(title: "Add a photo", message: nil, actions: alertActions), animated: true, completion: nil)
    }
    
    @IBAction func didTapDone(_ sender: UIBarButtonItem) {
        mobileTextField.resignFirstResponder()
        dobTextField.resignFirstResponder()
    }
    
    @IBAction func didTapDoneDatePicker(_ sender: UIBarButtonItem) {
        dobTextField.resignFirstResponder()
    }
    
    @IBAction func didSelectDate(_ sender: UIDatePicker) {
        let selectedDate = sender.date
        dobTextField.text = selectedDate.toString(withFormat: .YearMonthDay)
    }
    
    @IBAction func didTapEdit(_ sender: UIBarButtonItem) {
        
        if formValid() == true {
            
            guard let firstName = firstNameTextfield.text else { return }
            guard let lastName = lastNameTextfield.text else { return }
            guard let mobile = mobileTextField.text else { return }
            guard let dob = dobTextField.text else { return }
            guard let gender = IAmTextField.text else { return }
            
            let postObject = postObj(first_name: firstName, last_name: lastName, mobile_number: mobile, date_of_birth: dob, gender: gender,
                                     image: self.pickedImageID != nil ? self.pickedImageID! : 1,
                                     organization: self.org!.id)
            
            let updateProfile = Resource<AuthenticationData>(url: URL(string: NetworkingConstants.profile)!, method: HttpMethod<postObj>.patch(postObject))
            
            URLSession.shared.load(updateProfile, completion: { (updatedProfile, status) in
                self.showBanner(message: .SuccessUpdate)
            }) { (errorObj, status) in
                self.show(alert: "Error \(String(describing:(errorObj?.code)!))", message: errorObj?.message ?? "An error has occured", buttonTitle: "OK", onSuccess: nil)
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

extension ProfileTableViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        dismiss(animated: true) {

            let image = Resource<ImageObject>(upload: URL(string: NetworkingConstants.imageUpload)!, image: pickedImage)
            
            URLSession.shared.upload(image, completion: { (imageData, status) in
                self.pickedImageID = imageData?.id
                self.profileImageView.urlSetImage(imageData?.image)
            })
        }
    }
}
