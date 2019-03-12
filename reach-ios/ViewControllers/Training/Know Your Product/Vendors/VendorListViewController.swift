//
//  VendorListViewController.swift
//  reach-ios
//
//  Created by Elie El Khoury on 3/10/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit

class VendorListViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var tableView : UITableView!
    
    // MARK: - Properties
    
    var dataSource = GenericTableDataSource<BrandFeedbackCell, Company>()
    
    // MARK: - Navigation
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = dataSource
        
        let vendors = Resource<[Company]>(get: URL(string: NetworkingConstants.userVendorsList)!)
        
        URLSession.shared.load(vendors) { (vendorsList, status) in
            if let list = vendorsList {
                self.dataSource.data = list
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
        case Segue.UserVendorList.toCategories:
            if let company = sender {
                if company is Company {
                    let vc = segue.destination as! BrandsViewController
                    vc.title = (company as! Company).name
                    vc.vendor = company as? Company
                }
            }
        default: return
        }
    }
}

extension VendorListViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let company = dataSource.data[indexPath.row]
        performSegue(withIdentifier: Segue.UserVendorList.toCategories, sender: company)
    }
}
