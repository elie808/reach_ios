//
//  DailyReportViewController.swift
//  reach-ios
//
//  Created by Elie El Khoury on 2/21/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit

struct DailyReport {
    let name, serial : String
    let quantity : Int
}

class DailyReportViewController: UIViewController {

    // MARK: - Properties
    
    var dataSource = GenericTableDataSource<DailyReportCell, DailyReport>()
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView : UITableView!
    
    // MARK: - Views Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource.data = [DailyReport(name: "Dell Optilex 3000 series / PC's Redington", serial: "T0EC1872ISD", quantity: 3),
        DailyReport(name: "Dell Optilex 12 000 series / PC's Redington Optimum Prime Flex", serial: "T0EC1872ISD", quantity: 1)]
        tableView.dataSource = dataSource
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    }
}
