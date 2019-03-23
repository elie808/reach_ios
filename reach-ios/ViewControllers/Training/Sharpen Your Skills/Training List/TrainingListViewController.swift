//
//  TrainingListViewController.swift
//  reach-ios
//
//  Created by Elie El Khoury on 3/1/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit

struct TrainingListItem : Codable {
    var image, category : String
    var id : Int
}

class TrainingListViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    
    var dataSource : [TrainingListItem] = [] //GenericCollectionDataSource<TrainingListCell, TrainingListItem>()
    
    // MARK: - Views Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let trainingList = Resource<[TrainingListItem]>(get: URL(string:NetworkingConstants.allCategories)!)

        URLSession.shared.load(trainingList) { (trainingListItems, status) in
            self.dataSource = trainingListItems ?? []
            self.collectionView.reloadData()
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
            
        case Segue.TrainingList.toTrainingByCategory:
            if let category = sender {
                if category is TrainingListItem {
                    let vc : TrainingByCategoryTableViewController = segue.destination as! TrainingByCategoryTableViewController
                    vc.trainingItem = category as? TrainingListItem
                }
            }
        default: return
        }
    }
}

extension TrainingListViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCellID", for: indexPath) as! TrainingListCell
        cell.model = dataSource[indexPath.row]
        cell.cellIndex = indexPath
        
        return cell
    }
}

extension TrainingListViewController : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let trainingItem = dataSource[indexPath.row]
        performSegue(withIdentifier: Segue.TrainingList.toTrainingByCategory, sender: trainingItem)
    }
    
}
