//
//  OrganizationListTableViewController.swift
//  reach-ios
//
//  Created by Elie El Khoury on 3/13/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit

class OrganizationListTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    var dataSource : [Organization] = []
    var completeDataSource : [Organization] = [] // use to revert back after done messing around with filtering
    
    // MARK: - Outlets
    
    @IBOutlet weak var searchBar : UISearchBar!
    
    // MARK: - Views Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let trainingList = Resource<[Organization]>(get: URL(string:NetworkingConstants.allOrganizations)!)
        
        URLSession.shared.load(trainingList) { (trainingListItems, status) in
            self.dataSource = trainingListItems ?? []
            self.completeDataSource = self.dataSource
            self.tableView.reloadData()
        }
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
        //        performSegue(withIdentifier: Segue.ProductList.toReportSale, sender: dataSource[indexPath.row])
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //        switch segue.identifier {
        //
        //        case Segue.ProductList.toReportSale:
        //            let vc : ReportSaleViewController = segue.destination as! ReportSaleViewController
        //            if let organization = sender {
        //                if organization is Organization {
        //                    vc.viewModel.productName = (product as! Product).name
        //                }
        //            }
        //
        //        default: return
        //        }
    }
}

extension OrganizationListTableViewController : UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if (searchText.count > 0) && searchBar.text?.isEmpty == false {
            displayResults(for: searchText)
        } else {
            resetDataSource()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        resetDataSource()
        reset(searchBar)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        resetDataSource()
        reset(searchBar)
    }
    
    // MARK: - Helpers
    
    fileprivate func displayResults(for text: String) {
        
        let filteredData = dataSource.filter({( organization : Organization) -> Bool in
            return organization.name.lowercased().contains(text)
        })
        
        dataSource = filteredData
        tableView.reloadData()
    }
    
    fileprivate func resetDataSource() {
        dataSource = completeDataSource
        tableView.reloadData()
    }
    
    fileprivate func reset(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
    }
}
