//
//  PerformanceViewController.swift
//  reach-ios
//
//  Created by Elie El Khoury on 2/19/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit
import MessageUI

struct Sales : Codable {
    let sales : [PerformanceItem]
    let total_approved, total_pending : Int
}

struct PerformanceItem : Codable {
    let promotion, product : String
    let points : Int
    let approved : Bool
}

class PerformanceViewController: UIViewController {

    // MARK: - Properties
    
    var dataSource = GenericTableDataSource<PerformanceCell, PerformanceItem>()
    var user : User?
    
    // MARK: - Outlets
    
    @IBOutlet weak var profilePicture: ProfilePictureProgressView!
    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var pointsLabel : UILabel!
    @IBOutlet weak var pendingPointsLabel : UILabel!
    @IBOutlet weak var approvedPointsLabel : UILabel!
    
    // MARK: - Views Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        intializeViews()
    }
    
    fileprivate func intializeViews() {
        
        let profile = Resource<User>(get: URL(string: NetworkingConstants.profile)!)
        
        URLSession.shared.load(profile) { (user, status) in
            self.profilePicture.profilePicture?.urlSetImage(user?.image)
            self.profilePicture.totalPoints = (user?.totalApprovedPoints)!
            self.profilePicture.maxPoints = (user?.maxPoints)!
            self.profilePicture.animateProgress()
            self.pointsLabel.text = "\(user?.totalApprovedPoints ?? 0)"
            
            self.user = user
        }
        
        let performance = Resource<Sales>(get: URL(string:NetworkingConstants.sales)!)
        
        URLSession.shared.load(performance) { (salesObject, status) in
            self.pendingPointsLabel.text = "\(salesObject?.total_pending ?? 0)"
            self.approvedPointsLabel.text = "\(salesObject?.total_approved ?? 0)"
            
            self.dataSource.data = (salesObject?.sales)!
            self.tableView.dataSource = self.dataSource
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Actions
    
    @IBAction func didTapApprovedPoints(_ sender: UIButton) {
        
        let mailComposer = configureMailController()
        
        if MFMailComposeViewController.canSendMail() == true {
            self.present(mailComposer, animated: true, completion: nil)
        } else {
//            showMailError()
        }
    }
}

extension PerformanceViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 74
    }
}

extension PerformanceViewController : MFMailComposeViewControllerDelegate {
    
    func configureMailController() -> MFMailComposeViewController {
        
        let composeVC = MFMailComposeViewController()
        composeVC.mailComposeDelegate = self
        
        var emailBody : String = ""
        if let profile = user {
            let name  = "Name: " + profile.firstName + " " + (self.user?.lastName)! + "\n"
            let email = "Email: " + profile.email + "\n"
            let org   = "Organization: " + profile.organization.name + "\n"
            let phone = "Phone: " + profile.mobileNumber
            
            emailBody = name + email + org + phone
        }
        
        composeVC.setToRecipients([Constants.reachEmail, Constants.pointsEmail])
        composeVC.setSubject("Redeem points")
        composeVC.setMessageBody(emailBody, isHTML: false)
        
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
