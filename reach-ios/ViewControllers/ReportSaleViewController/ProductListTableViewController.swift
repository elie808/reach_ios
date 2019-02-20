//
//  ProductListTableViewController.swift
//  reach-ios
//
//  Created by Elie El Khoury on 2/20/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit

class ProductListTableViewController: UITableViewController {

    // MARK: - Properties
    
    var dataSource : [Product] = []
    
    // MARK: - Outlets
    
    @IBOutlet weak var searchBar : UISearchBar!
    
    // MARK: - Views Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCellID", for: indexPath)
        cell.textLabel?.text = dataSource[indexPath.row].name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Segue.ProductList.toReportSale, sender: dataSource[indexPath.row])
    }
    
    // MARK: - Navigation

     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
            
        case Segue.ProductList.toReportSale:
            let vc : ReportSaleViewController = segue.destination as! ReportSaleViewController
            if let product = sender {
                if product is Product {
                    vc.viewModel.productName = (product as! Product).name
                }
            }
            
        default: return
        }
    }
}

extension ProductListTableViewController : UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
        if let query = searchBar.text {
        
            let filteredCandies = dataSource.filter({( candy : Product) -> Bool in
                return candy.name.lowercased().contains(query)
            })
            
            print(filteredCandies.first)
        }
    }
    
}
