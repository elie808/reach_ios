//
//  DailyReportViewController.swift
//  reach-ios
//
//  Created by Elie El Khoury on 2/21/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit

//struct DailyReport {
//    let name, serial : String
//    let quantity : Int
//}

class DailyReportViewController: UIViewController {

    // MARK: - Properties
    
    var dataSource = GenericTableDataSource<DailyReportCell, ReportSaleModel>()
    var passedSale : ReportSaleModel?
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView : UITableView!
    
    // MARK: - Views Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        dataSource.data = [DailyReport(name: "Dell Optilex 3000 series / PC's Redington", serial: "T0EC1872ISD", quantity: 3),
//        DailyReport(name: "Dell Optilex 12 000 series / PC's Redington Optimum Prime Flex", serial: "T0EC1872ISD", quantity: 1)]
        tableView.dataSource = dataSource
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let savedSales = PersistenceManager.getAllSavedSales() {
            dataSource.data.removeAll()
            dataSource.data = savedSales
            tableView.reloadData()
        }
    }
    
    // MARK: - Actions
    
    @IBAction func didTapSubmit(_ sender: UIButton) {

        guard let salesList = PersistenceManager.getAllSavedSales() else { return }

        let postObj = ["sales" : salesList]
//
        let sales = Resource<ReportSaleModel>(url: URL(string: NetworkingConstants.sales)!, method: HttpMethod.post(postObj))

        URLSession.shared.load(sales) { (response, status) in

            if status.code == 200 {
                
                self.showBanner(message: .SuccessPostingSales)
                
                PersistenceManager.deleteAddSalesData()
                self.dataSource.data.removeAll()
                self.tableView.reloadData()
                
            } else if status.code == 403 {
                self.showBanner(message: .ErrorPosting)
            }
        }

    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    }
}
