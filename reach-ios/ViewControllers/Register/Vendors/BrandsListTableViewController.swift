//
//  BrandsListTableViewController.swift
//  reach-ios
//
//  Created by Elie El Khoury on 3/15/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit

class BrandsListCell: GenericTableCell<Brand> {
    
    @IBOutlet weak var cellImageView : UIImageView!
    @IBOutlet weak var nameLabel : UILabel!
    
    override var model : Brand! {
        didSet {
            cellImageView.urlSetImage(model.image, #imageLiteral(resourceName: "LoginLogo"))
            nameLabel.text = model.name
        }
    }
}

class BrandsListTableViewController: UITableViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var addButton: UIButton!
    
    // MARK: - Properties
    
    var passedVendor : Vendor?
    var dataSource = GenericTableDataSource<BrandsListCell, Brand>()
    
    // MARK: - Views Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = dataSource
        
        let brandsList = Resource<[Brand]>(get: URL(string: NetworkingConstants.brands(foVendorID: (passedVendor?.id)!))! )
        
        URLSession.shared.load(brandsList) { (brandsListItems, status) in
            self.dataSource.data = brandsListItems!
            self.tableView.reloadData()
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //TODO: Mark item as selected
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    // MARK: - Actions
    
    @IBAction func didTapAddBrands(_ sender: UIButton) {
        //TODO sender = selected Brands
        performSegue(withIdentifier: "unwindToAddBrandsVC", sender: nil)
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }

}
