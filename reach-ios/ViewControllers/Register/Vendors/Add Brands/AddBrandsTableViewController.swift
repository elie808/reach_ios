//
//  AddBrandsTableViewController.swift
//  reach-ios
//
//  Created by Elie El Khoury on 3/15/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit

class AddBrandsTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    var passOrganization : Organization?
    var dataSource : [Brand] = [] //GenericTableDataSource<AddBrandCell, Brand>()
    
    // MARK: - Views Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCellID", for: indexPath) as! AddBrandCell
        cell.model = dataSource[indexPath.row]
        cell.cellIndex = indexPath
        cell.cellDelegate = self
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    // MARK: - Helpers
    
    func getSelectedBrandIDs() -> [Int] {
        
        if dataSource.count > 0 {
            return dataSource.map {$0.id}
        } else {
            show(alert: "Warning", message: "Please select at least 1 brand.", buttonTitle: "Ok", onSuccess: nil)
            return []
        }
    }
    
    // MARK: - Navigation
    
    @IBAction func unwindToAddBrandsVC (segue : UIStoryboardSegue) {
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segue.AddBrandList.toVendorList {
            let vc = segue.destination as? VendorsTableViewController
            vc?.passOrganization = passOrganization
        }
    }
    
}

extension AddBrandsTableViewController : AddBrandCellDelegate {
    
    func deleteBrand(atIndex index:IndexPath) {
        
        dataSource.remove(at: index.row)
        
        let range = NSMakeRange(0, self.tableView.numberOfSections)
        let sections = NSIndexSet(indexesIn: range)
        tableView.reloadSections(sections as IndexSet, with: .automatic)
    }
}
