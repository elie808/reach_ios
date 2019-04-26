//
//  LoginTableViewController.swift
//  reach-ios
//
//  Created by Elie El Khoury on 2/21/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit
import MessageUI
import SkyFloatingLabelTextField

class LoginTableViewController: UITableViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var usernameTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var passwordTextField: SkyFloatingLabelTextField!

    // MARK: - Properties
    
    var showPassword = false
    
    // MARK: - Views Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
//        usernameTextField.text = "test@mail.com"//"devteam1@channelpro.co"
//        passwordTextField.text = "password"//"2234118Rr."
    }
    
    // MARK: - Helpers
    
    private func formValid() -> Bool {

        var isValid = true
        
        guard let username = usernameTextField.text else { return false }
        guard let password = passwordTextField.text else { return false }

        if username.isEmpty {
            usernameTextField.errorMessage = String.cantBeEmpty
            isValid = false
        }
        
        if !username.isEmpty && !username.isValidEmail() {
            usernameTextField.errorMessage = String.emailFormatNotValid
            isValid = false
        }
        
        if password.isEmpty {
            passwordTextField.errorMessage = String.passwordRequired
            isValid = false
        }
        
        if !password.isEmpty && password.count < 6 {
            passwordTextField.errorMessage = String.sixMinimumCharacters
            isValid = false
        }
        
        return isValid
    }
    
    // MARK: - Actions
    
    @IBAction func didTapLogin(_ sender: UIButton) {
        
        if formValid() == true {

            guard let userName = usernameTextField.text else { return }
            guard let password = passwordTextField.text else { return }

            let postParameters = [
                "email" : userName,
                "password" : password
            ]
            
            let loginAttempt = Resource<AuthenticationData>(url: URL(string:NetworkingConstants.login)!, method: HttpMethod.post(postParameters))

            URLSession.shared.load(loginAttempt, completion: { (member, status) in
               
                if status.status == .Success {
                    if let returnedMember = member {
                        AuthenticationManager.persistToUserDefaults(authenticationData: returnedMember)
                        self.performSegue(withIdentifier: Segue.Login.toMainVC, sender: nil)
                    }
                }
                
            }) { (error, status) in
                
                guard let errorObj = error else {
                    self.show(alert: "Error", message: "An unnknown error has occured", buttonTitle: "OK", onSuccess: nil)
                    return }
                self.show(alert: "Error \(String(describing:(errorObj.code)))", message: (errorObj.message), buttonTitle: "OK", onSuccess: nil)
            }
        }
    }
    
    @IBAction func didTapCreateAccount(_ sender: UIButton) {
    }
    
    @IBAction func didTapPasswordToggle(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        passwordTextField.isSecureTextEntry = !sender.isSelected
    }

    @IBAction func didTapNeedHelp(_ sender: UIButton) {
    
        let mailComposer = configureMailController()
        
        if MFMailComposeViewController.canSendMail() == true {
            self.present(mailComposer, animated: true, completion: nil)
        }
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }

}

extension LoginTableViewController : MFMailComposeViewControllerDelegate {
    
    func configureMailController() -> MFMailComposeViewController {
        
        let composeVC = MFMailComposeViewController()
        composeVC.mailComposeDelegate = self
        composeVC.setToRecipients([Constants.supportEmail])
        composeVC.setSubject("Need help for login")
        
        return composeVC
    }
    
    func showMailError() {
        let sendMailErrorAlert = UIAlertController(title: "Error", message: "Device doesn't support sending e-mail", preferredStyle: .alert)
        let dismiss = UIAlertAction(title: "OK", style: .default, handler: nil)
        sendMailErrorAlert.addAction(dismiss)
        self.present(sendMailErrorAlert, animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}

extension LoginTableViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
        case usernameTextField: return passwordTextField.becomeFirstResponder()
        default: return textField.resignFirstResponder()
        }
    }
}
