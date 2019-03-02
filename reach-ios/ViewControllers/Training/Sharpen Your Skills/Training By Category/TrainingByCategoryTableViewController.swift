//
//  TrainingByCategoryTableViewController.swift
//  reach-ios
//
//  Created by Elie El Khoury on 3/2/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit

struct TrainingByCategory : Codable {
    var id : Int
    var title, image, description, url : String
    var type : String
}

class TrainingByCategoryTableViewController: UITableViewController {

    // MARK: - Outlets
    
    // MARK: - Properties

    var trainingItem : TrainingListItem?
    var dataSource = GenericTableDataSource<TrainingByCategoryCell, TrainingByCategory>()
    
    // MARK: - Views Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = dataSource
        
        initializeView()
    }
    
    fileprivate func initializeView() {
        
        guard let trainingItem = trainingItem else { return }
        
        self.title = trainingItem.category
        
        let categoryID = String(describing:trainingItem.id)
        let trainingList = Resource<[TrainingByCategory]>(get: URL(string:NetworkingConstants.trainingCategory+"\(categoryID)")!)
        
        URLSession.shared.load(trainingList) { (trainingListItems, status) in
            self.dataSource.data = trainingListItems ?? []
            self.tableView.reloadData()
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}
