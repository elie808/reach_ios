//
//  NewsViewController.swift
//  reach-ios
//
//  Created by Elie El Khoury on 2/25/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit

struct NewsItem : Codable {
    let image, name, description : String
    let id : Int
    let date : Double
}

class NewsViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var collectionView : UICollectionView!
    
    // MARK: - Properties
    
    var dataSource = GenericCollectionDataSource<GenericCollectionCell<NewsItem>, NewsItem>()
    
    // MARK: - Views Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = dataSource
        
        let trainingList = Resource<[NewsItem]>(get: URL(string:NetworkingConstants.allNews)!)
        
        URLSession.shared.load(trainingList) { (trainingListItems, status) in
            self.dataSource.data = trainingListItems ?? []
            self.collectionView.reloadData()
        }
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        switch segue.identifier {
        
        case Segue.NewsList.toNewsDetails:
            if let newsItem = sender {
                if newsItem is NewsItem {
                    let vc : NewsDetailsViewController = segue.destination as! NewsDetailsViewController
                    vc.newsItemID = (newsItem as! NewsItem).id
                    
                }
            }

        default: return
        }
        
    }
}

extension NewsViewController : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let newsItem = dataSource.data[indexPath.row]
        performSegue(withIdentifier: Segue.NewsList.toNewsDetails, sender: newsItem)
    }
}
