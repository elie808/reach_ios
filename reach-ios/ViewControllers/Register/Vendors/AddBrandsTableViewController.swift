//
//  AddBrandsTableViewController.swift
//  reach-ios
//
//  Created by Elie El Khoury on 3/15/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit

class AddBrandCell: GenericTableCell<Vendor> {
    
    @IBOutlet weak var cellImageView : UIImageView!
    @IBOutlet weak var nameLabel : UILabel!
    
    override var model : Vendor! {
        didSet {
            cellImageView.urlSetImage(model.image, #imageLiteral(resourceName: "LoginLogo"))
            nameLabel.text = model.name
        }
    }
}

class AddBrandsTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    var passOrganization : Organization?
    var dataSource = GenericTableDataSource<VendorCell, Vendor>()
    
    // MARK: - Views Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        performSegue(withIdentifier: Segue.AddBrandList.toVendorList, sender: nil)
    }
    
    // MARK: - Navigation
    
    @IBAction func unwindToAddBrandsVC (segue : UIStoryboardSegue) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segue.AddBrandList.toVendorList {
            let vc = segue.destination as? VendorsTableViewController
            vc?.passOrganization = passOrganization
        }
    }
    
}
