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
    @IBOutlet weak var selectionImageView : UIImageView!
    
    override var model : Brand! {
        didSet {
            cellImageView.urlSetImage(model.image, #imageLiteral(resourceName: "LoginLogo"))
            nameLabel.text = model.name
            
            if model.isSelected == true {
                selectionImageView.image =  #imageLiteral(resourceName: "SelectedRadioGreen")
            } else {
                selectionImageView.image =  #imageLiteral(resourceName: "SurveySelectRadioGreen")
            }
            
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

        if dataSource.data[indexPath.row].isSelected == true {
           dataSource.data[indexPath.row].isSelected = false
        } else {
           dataSource.data[indexPath.row].isSelected = true
        }
        
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    // MARK: - Actions
    
    @IBAction func didTapAddBrands(_ sender: UIButton) {

        let selectedBrands = dataSource.data.filter {
            return $0.isSelected == true
        }

        if selectedBrands.count > 0 {
            performSegue(withIdentifier: Segue.BrandsList.toAddBrands, sender: selectedBrands)
        }
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == Segue.BrandsList.toAddBrands {
            let vc = segue.destination as! AddBrandsTableViewController
            
            if let selectedBrands = sender {
                if selectedBrands is [Brand] && ((selectedBrands as! [Brand]).count > 0){

                    for brand in (selectedBrands as! [Brand]) {
                        
                        if (vc.dataSource.contains { $0.id == brand.id } == false) {
                            vc.dataSource.append(contentsOf: selectedBrands as! [Brand])
                        }
                    }
                }
            }
        }
    }

}
