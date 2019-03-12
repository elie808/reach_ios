//
//  SubCategoryTableViewController.swift
//  reach-ios
//
//  Created by Elie El Khoury on 3/12/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit

struct SubCategory : Codable {
    let name, image, part_number, description : String
    let id, subcategory_id : Int
}

class SubCategoryTableViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView : UITableView!
    
    // MARK: - Properties
    
    var category : Category?
    var dataSource = GenericTableDataSource<SharpenSkillsCell, SubCategory>()
    
    // MARK: - Views Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = dataSource
    
        let media = Resource<[SubCategory]>(get: URL(string: NetworkingConstants.subCategoryTraining(forCategoryID: category?.id ?? 0))! )
        
        URLSession.shared.load(media) { (trainingList, status) in
            if let list = trainingList {
                self.dataSource.data = list
                self.tableView.reloadData()
            }
        }
        
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
    
}

extension SubCategoryTableViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
