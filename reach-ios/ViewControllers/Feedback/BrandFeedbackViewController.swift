//
//  BrandFeedbackViewController.swift
//  reach-ios
//
//  Created by Elie El Khoury on 2/25/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit

struct Company : Codable {
    let image, name : String
    let id : Int
}

class OrganizationCell: GenericTableCell<Organization> {
    
    @IBOutlet weak var nameLabel : UILabel!
    
    override var model : Organization! {
        didSet {
            nameLabel?.text = model.name
        }
    }
}

class BrandFeedbackViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var tableView : UITableView!

    // MARK: - Properties
    
    var dataSource = GenericTableDataSource<OrganizationCell, Organization>()
    
    // MARK: - Navigation
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = dataSource
        
        let feedbackOrganizations = Resource<[Organization]>(get: URL(string: NetworkingConstants.userOrganizations)!)
        
        URLSession.shared.load(feedbackOrganizations) { (response, status) in
            if let orgList = response {
                self.dataSource.data = orgList
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     
        switch segue.identifier {
        
        case Segue.BrandFeedback.toFeedbackForm:
            if let org = sender, org is Organization {
                let vc = segue.destination as! FeedbackFormTableViewController
                vc.passedOrganization = org as? Organization
            }
        
        default: return
        }
        
    }
}

extension BrandFeedbackViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {   
        let organization = dataSource.data[indexPath.row]
        performSegue(withIdentifier: Segue.BrandFeedback.toFeedbackForm, sender: organization)
    }
}
