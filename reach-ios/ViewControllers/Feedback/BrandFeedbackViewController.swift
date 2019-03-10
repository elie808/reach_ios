//
//  BrandFeedbackViewController.swift
//  reach-ios
//
//  Created by Elie El Khoury on 2/25/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit

struct Company : Codable {
    let image, name : String
    let id : Int
}

class BrandFeedbackViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var tableView : UITableView!

    // MARK: - Properties
    
    var dataSource = GenericTableDataSource<BrandFeedbackCell, Company>()
    
    // MARK: - Navigation
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        dataSource.data = [Company(imageName: "", name: "Microsoft"), Company(imageName: "", name: "Dell")]
//        tableView.dataSource = dataSource
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}

extension BrandFeedbackViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {   
        let company = dataSource.data[indexPath.row]
        performSegue(withIdentifier: Segue.BrandFeedback.toFeedbackForm, sender: company)
    }
}
