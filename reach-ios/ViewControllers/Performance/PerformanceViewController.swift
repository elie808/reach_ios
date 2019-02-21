//
//  PerformanceViewController.swift
//  reach-ios
//
//  Created by Elie El Khoury on 2/19/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit
import MessageUI

struct PerformanceItem {
    let name, item : String
    let points : Int
    let status : Bool
}

class PerformanceCell: GenericTableCell<PerformanceItem> {
    
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var subtitleLabel : UILabel!
    @IBOutlet weak var pointsLabel : UILabel!
    @IBOutlet weak var pointsView : UIView!
    @IBOutlet weak var statusLabel : UILabel!
    @IBOutlet weak var statusView : UIView!
    
    override var model : PerformanceItem! {
        didSet {
            titleLabel.text = model.name
            subtitleLabel.text = model.item
            pointsLabel.text = String(model.points)
            
            if model.status == true {
                statusLabel.text = "Approved"
                statusLabel.textColor = .reachGreen
                statusView.backgroundColor = .reachGreen
            } else {
                statusLabel.text = "Pending"
                statusLabel.textColor = .gray
                statusView.backgroundColor = .gray
            }
        }
    }
}

class PerformanceViewController: UIViewController {

    // MARK: - Properties
    
    var dataSource = GenericTableDataSource<PerformanceCell, PerformanceItem>()
    
    // MARK: - Outlets
    
    @IBOutlet weak var profilePicture: ProfilePictureProgressView!
    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var pendingPointsLabel : UILabel!
    @IBOutlet weak var approvedPointsLabel : UILabel!
    
    // MARK: - Views Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource.data = [PerformanceItem(name: "Summer Deal", item: "Microsoft Surface", points: 200, status: true),
                           PerformanceItem(name: "PC's Redington Promotion", item: "Office 365", points: 30500, status: false)]
        tableView.dataSource = dataSource
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        profilePicture.animateProgress()
    }
    
    // MARK: - Actions
    
    @IBAction func didTapApprovedPoints(_ sender: UIButton) {
        
        print("SHERHEHREH")
        
        let mailComposer = configureMailController()
        
        if MFMailComposeViewController.canSendMail() == true {
            self.present(mailComposer, animated: true, completion: nil)
        } else {
//            showMailError()
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

extension PerformanceViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 74
    }
}

extension PerformanceViewController : MFMailComposeViewControllerDelegate {
    
    func configureMailController() -> MFMailComposeViewController {
        
        let composeVC = MFMailComposeViewController()
        composeVC.mailComposeDelegate = self
        
        /* //-- EMail Body
         Name:
         Email:
         Organization:
         Phone:
         */
        
        composeVC.setToRecipients([Constants.reachEmail, Constants.pointsEmail])
        composeVC.setSubject("Redeem points")
        composeVC.setMessageBody("boyd", isHTML: false)
        
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
