//
//  VendorsTableViewController.swift
//  reach-ios
//
//  Created by Elie El Khoury on 3/1/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit

struct Vendor : Codable {
    let id : Int
    let name, image : String
}

class VendorCell: GenericTableCell<Vendor> {
    
    @IBOutlet weak var cellImageView : UIImageView!
    @IBOutlet weak var nameLabel : UILabel!
    
    override var model : Vendor! {
        didSet {
            cellImageView.urlSetImage(model.image, #imageLiteral(resourceName: "LoginLogo"))
            nameLabel.text = model.name
        }
    }
}

class VendorsTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    var passOrganization : Organization?
    var dataSource = GenericTableDataSource<VendorCell, Vendor>()
    
    // MARK: - Views Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = dataSource
        
        getVendors()
    }
    
    func getVendors() {
        
        if let org = passOrganization {
            
            let vendorList = Resource<[Vendor]>(get: URL(string:NetworkingConstants.vendors(forOrganizationID: org.organization_id!))!)
            
            URLSession.shared.load(vendorList) { (vendorListItems, status) in
                self.dataSource.data = vendorListItems!
                self.tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "VendorListToBrandsListVC" , sender: dataSource.data[indexPath.row])
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
        case "VendorListToBrandsListVC":
            let vc = segue.destination as? BrandsListTableViewController
            if let vendorObj = sender {
                if vendorObj is Vendor {
                    vc?.passedVendor = sender as! Vendor
                }
            }
            
        default: return
        }
        
    }
}
