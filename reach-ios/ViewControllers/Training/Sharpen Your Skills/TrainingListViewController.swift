//
//  TrainingListViewController.swift
//  reach-ios
//
//  Created by Elie El Khoury on 3/1/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit

struct TrainingListItems : Codable {
    var image, category : String
    var id : Int
}

class TrainingListViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    
    var dataSource = GenericCollectionDataSource<TrainingListCell, TrainingListItems>()
    
    // MARK: - Views Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = dataSource

        let trainingList = Resource<[TrainingListItems]>(get: URL(string:NetworkingConstants.allCategories)!)

        URLSession.shared.load(trainingList) { (trainingListItems, status) in
            self.dataSource.data = trainingListItems ?? []
            self.collectionView.reloadData()
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case Segue.PromotionsList.toPromotionPDF:
            if let promotion = sender {
                if promotion is Promotion {
                    
                }
            }
        default: return
        }
    }
    
}

extension TrainingListViewController : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let promotion = dataSource.data[indexPath.row]
//        performSegue(withIdentifier: Segue.PromotionsList.toPromotionPDF, sender: promotion)
    }
    
}
