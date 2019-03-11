//
//  SubCategoryTableViewController.swift
//  reach-ios
//
//  Created by Elie El Khoury on 3/10/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit

struct SubCategory : Codable {
    let id : Int
    let name, category : String
}

class SubCategoryCell: GenericTableCell<SubCategory> {
    
    @IBOutlet weak var nameLabel : UILabel!
    
    override var model : SubCategory! {
        didSet {
            nameLabel.text = model.name
        }
    }
}

class SubCategoryTableViewController: UITableViewController {

    // MARK: - Properties
    
    var category : BrandTraining?
    var tableDataSource = GenericTableDataSource<SubCategoryCell, SubCategory>()
    
    // MARK: - Views Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = tableDataSource
        
        let trainings = Resource<[SubCategory]>(get: URL(string: NetworkingConstants.categoryTraining(forCategory: category?.id ?? 0))!)
        
        URLSession.shared.load(trainings) { (trainingList, status) in
            if let list = trainingList {
                self.tableDataSource.data = list
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let subCategory = tableDataSource.data[indexPath.row]
        performSegue(withIdentifier: Segue.SubCategories.toMediaVC, sender: subCategory)
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
        
        case Segue.SubCategories.toMediaVC:
            if let subCategory = sender {
                if subCategory is SubCategory {
                    let vc = segue.destination as! ProductMediaViewController
                    vc.title = (subCategory as! SubCategory).name
                    vc.subCategory = subCategory as? SubCategory
                }
            }
            
        default: return
        }
        
    }

}
