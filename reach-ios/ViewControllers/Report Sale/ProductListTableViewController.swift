//
//  ProductListTableViewController.swift
//  reach-ios
//
//  Created by Elie El Khoury on 2/20/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit

struct Product : Codable {
    let name, image, description, part_number : String
    let id : Int
}

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
        searchBar.showsCancelButton = true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if (searchText.count > 0) && searchBar.text?.isEmpty == false {
//            displayResults(for: searchText)
        } else {
            resetDataSource()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if let searchText = searchBar.text, searchText.count > 0, !searchText.isEmpty {
    
            let search = Resource<[Product]>(get: URL(string: NetworkingConstants.search(byName: searchText))!)

            URLSession.shared.load(search) { (results, status) in
                if status.code == 200 {
                    if let list = results, list.count > 0 {
                        
                        self.resetDataSource()
                        self.dataSource.append(contentsOf: list)
                        self.tableView.reloadData()
                        self.searchBar.resignFirstResponder()
                    } else {
                        self.showBanner(message: .NoResults)
                    }
                }
            }

        } else {
            resetDataSource()
            reset(searchBar)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        resetDataSource()
        reset(searchBar)
    }
    
    // MARK: - Helpers
    
    fileprivate func resetDataSource() {
        dataSource.removeAll()
        tableView.reloadData()
    }
    
    fileprivate func reset(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
    }
}
