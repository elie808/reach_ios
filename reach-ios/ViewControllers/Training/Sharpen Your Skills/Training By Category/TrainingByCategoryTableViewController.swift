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
    
        // MARK: - TableView Delegate

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let trainingItem = dataSource.data[indexPath.row]
        
        switch trainingItem.type {
            
        case MediaType.video.rawValue: performSegue(withIdentifier: Segue.TrainingCategory.toVideo, sender: trainingItem)
        case MediaType.pdf.rawValue: performSegue(withIdentifier: Segue.TrainingCategory.toPDF, sender: trainingItem)
        
        default: return
        }
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
            
        case Segue.TrainingCategory.toVideo:
            if let trainingObj = sender {
                if trainingObj is TrainingByCategory {
                    let vc = segue.destination as! VideoPlayerViewController
                    vc.title = (trainingObj as! TrainingByCategory).title
                    vc.urlString = (trainingObj as! TrainingByCategory).url
                }
            }
            
        case Segue.TrainingCategory.toPDF:
            if let trainingObj = sender {
                if trainingObj is TrainingByCategory {
                    let vc = segue.destination as! PDFViewController
                    vc.title = (trainingObj as! TrainingByCategory).title
                    vc.loadFromUrl(url: (trainingObj as! TrainingByCategory).url )
                }
            }
        default: return
        }
    }
}
