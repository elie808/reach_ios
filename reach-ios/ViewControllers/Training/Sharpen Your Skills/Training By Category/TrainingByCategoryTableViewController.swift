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
    
    enum trainingType : String {
        case video = "Video"
        case pdf = "pdf"
    }
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
    
        // MARK: - TableView Delegate

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let trainingItem = dataSource.data[indexPath.row]
        
        switch trainingItem.type {
            
        case TrainingByCategory.trainingType.video.rawValue: performSegue(withIdentifier: Segue.TrainingCategory.toVideo, sender: trainingItem)
        case TrainingByCategory.trainingType.pdf.rawValue: performSegue(withIdentifier: Segue.TrainingCategory.toPDF, sender: trainingItem)
        
        default: return
        }
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
            
        case Segue.TrainingCategory.toVideo:
            if let category = sender {
                if category is TrainingListItem {
//                    let vc : TrainingByCategoryTableViewController = segue.destination as! TrainingByCategoryTableViewController
//                    vc.trainingItem = category as? TrainingListItem
                }
            }
            
        case Segue.TrainingCategory.toPDF:
            if let category = sender {
                if category is TrainingListItem {
                    //                    let vc : TrainingByCategoryTableViewController = segue.destination as! TrainingByCategoryTableViewController
                    //                    vc.trainingItem = category as? TrainingListItem
                }
            }
        default: return
        }
    }
}
