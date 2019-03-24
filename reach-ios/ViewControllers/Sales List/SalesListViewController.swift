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
    
    var dataSource : [SaleViewModel] = [] {
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

        if let savedSales = PersistenceManager.allSavedSales(), savedSales.count > 0 {
            dataSource.removeAll()
            dataSource.append(contentsOf: savedSales)
            tableView.reloadData()
        } else {
            dataSource.removeAll()
            tableView.reloadData()
        }
    }
    
    fileprivate func animateTableView() {
        let range = NSMakeRange(0, self.tableView.numberOfSections)
        let sections = NSIndexSet(indexesIn: range)
        self.tableView.reloadSections(sections as IndexSet, with: .automatic)
    }
    
    // MARK: - Actions
    
    @IBAction func didTapSubmit(_ sender: UIButton) {

        guard let savedSaleModels = PersistenceManager.allSavedSales() else { return }

        if savedSaleModels.count > 0 {
            
            let allSales = savedSaleModels.map( { $0.sale} )
         
            let postObj = ["sales" : allSales]
            
            let sales = Resource<Sale>(url: URL(string: NetworkingConstants.sales)!, method: HttpMethod.post(postObj))
            
            URLSession.shared.load(sales, completion: { (response, status) in
                
                self.showBanner(message: .SuccessPostingSales)
                
                PersistenceManager.removeAllSales()
                self.dataSource.removeAll()
                
                self.animateTableView()
                
            }) { (error, status) in
                self.show(alert: "Error \(String(describing:(error?.code)!))", message: (error?.message)!, buttonTitle: "OK", onSuccess: nil)
            }
            
        }
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        switch segue.identifier {
            
        case Segue.DailyReport.toEditSale:
                if let reportSaleItem = sender, reportSaleItem is SaleViewModel {
                    let vc = segue.destination as? ReportSaleViewController
                    vc?.viewModel = (reportSaleItem as? SaleViewModel)!
                    vc?.isUpdatingExistingSale = true
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
        cell.model = dataSource[indexPath.row].sale
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

        PersistenceManager.remove(saleObject: dataSource[index.row])
        dataSource.remove(at: index.row)
        
        animateTableView()
    }
}
