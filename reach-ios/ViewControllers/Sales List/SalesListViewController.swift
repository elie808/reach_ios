//
//  DailyReportViewController.swift
//  reach-ios
//
//  Created by Elie El Khoury on 2/21/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit

class SalesListViewController: UIViewController {

    // MARK: - Properties
    
    var dataSource : [Sale] = [] {
        didSet {
            if dataSource.count == 0 {
                submitButton.backgroundColor = .lightGray
                submitButton.isEnabled = false
            } else {
                submitButton.backgroundColor = .reachGreen
                submitButton.isEnabled = true
            }
        }
    }
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var submitButton : UIButton!
    
    // MARK: - Views Life Cycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let savedSales = PersistenceManager.getAllSavedSales(), savedSales.count > 0 {
            dataSource.removeAll()
            dataSource.append(contentsOf: savedSales)
            tableView.reloadData()
        } else {
            dataSource.removeAll()
            tableView.reloadData()
        }
    }
    
    // MARK: - Actions
    
    @IBAction func didTapSubmit(_ sender: UIButton) {

        guard let salesList = PersistenceManager.getAllSavedSales() else { return }

        if salesList.count > 0 {
         
            let postObj = ["sales" : salesList]
            
            let sales = Resource<Sale>(url: URL(string: NetworkingConstants.sales)!, method: HttpMethod.post(postObj))
            
            URLSession.shared.load(sales) { (response, status) in
                
                if status.code == 200 {
                    
                    self.showBanner(message: .SuccessPostingSales)
                    
                    PersistenceManager.deleteAddSalesData()
                    self.dataSource.removeAll()
                    self.tableView.reloadData()
                    
                } else if status.code == 403 {
                    self.showBanner(message: .ErrorPosting)
                }
            }
        }
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        switch segue.identifier {
        case Segue.DailyReport.toEditSale:
            if let reportSaleItem = sender, reportSaleItem is Sale {
                let vc = segue.destination as? ReportSaleViewController
                vc!.viewModel = reportSaleItem as! Sale
            }
        default: return
        }
    }
}

extension SalesListViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCellID", for: indexPath) as! DailyReportCell
        cell.model = dataSource[indexPath.row]
        cell.cellIndex = indexPath
        cell.cellDelegate = self
        
        return cell
    }
}

extension SalesListViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let saleObject = dataSource[indexPath.row]
        performSegue(withIdentifier: Segue.DailyReport.toEditSale, sender: saleObject)
    }
}

extension SalesListViewController : DailyReportCellDelegate {

    func deleteSaleItem(atIndex index: IndexPath) {
        
        PersistenceManager.removeSalesObject(saleToRemove: dataSource[index.row])
        
        dataSource.remove(at: index.row)
        
        let range = NSMakeRange(0, self.tableView.numberOfSections)
        let sections = NSIndexSet(indexesIn: range)
        tableView.reloadSections(sections as IndexSet, with: .automatic)
    }
}
