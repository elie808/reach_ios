//
//  SubCategoryTableViewController.swift
//  reach-ios
//
//  Created by Elie El Khoury on 3/10/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit

struct Category : Codable {
    let id : Int
    let name, category : String
}

class SubCategoryCell: GenericTableCell<Category> {
    
    @IBOutlet weak var nameLabel : UILabel!
    
    override var model : Category! {
        didSet {
            nameLabel.text = model.name
        }
    }
}

class CategoryTableViewController: UITableViewController {

    // MARK: - Properties
    
    var brand : BrandTraining?
    var tableDataSource = GenericTableDataSource<SubCategoryCell, Category>()
    
    // MARK: - Views Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = tableDataSource
        
        let trainings = Resource<[Category]>(get: URL(string: NetworkingConstants.categoryTraining(forBrandID: brand?.id ?? 0))! )
            
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
        performSegue(withIdentifier: Segue.Categories.toSubCategories, sender: subCategory)
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
        
        case Segue.Categories.toSubCategories:
            if let category = sender {
                if category is Category {
                    let vc = segue.destination as! SubCategoryTableViewController
                    vc.title = (category as! Category).name
                    vc.category = category as? Category
                }
            }
            
        default: return
        }
        
    }

}
