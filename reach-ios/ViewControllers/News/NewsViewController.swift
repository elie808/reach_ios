//
//  NewsViewController.swift
//  reach-ios
//
//  Created by Elie El Khoury on 2/25/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit

struct NewsItem : Codable {
//    let image, name, description : String
//    var id : Int?
    var image : String?
    let name : String
    let date : String
    let description : String
}

//"name": "HELP YOUR CUSTOMER TO CHOOSE A DREAM LENOVO LAPTOP",
//"image": "http://test.channelpro.co/images/news/lenovo-yoga-c630-wos-laptop-012019-01-29-03-03-04.jpg",
//"description": "<p><a title=\"LEARN MORE\" href=\"https://www.lenovo.com/ae/en/laptops/c/Laptops\">LEARN MORE</a></p>",
//"date": "2019-01-28"

class NewsViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var collectionView : UICollectionView!
    
    // MARK: - Properties
    
    var dataSource = GenericCollectionDataSource<GenericCollectionCell<NewsItem>, NewsItem>()
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh(_:)), for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.reachGreen
        return refreshControl
    }()
    
    // MARK: - Views Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = dataSource
        collectionView.addSubview(self.refreshControl)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getNews()
    }
    
    // MARK: - Helpers
    
    fileprivate func getNews() {
        
        let newsList = Resource<[NewsItem]>(get: URL(string:NetworkingConstants.allNews)!)
        
        URLSession.shared.load(newsList, completion: { (newsItems, status) in
            self.dataSource.data.removeAll()
            self.dataSource.data = newsItems ?? []
            self.collectionView.reloadData()
        }) { (error, status) in
            
        }
    }
    
    // MARK: - Actions
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        
        getNews()
        collectionView.reloadData()
        refreshControl.endRefreshing()
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        switch segue.identifier {
        
        case Segue.NewsList.toNewsDetails:
            if let newsItem = sender {
                if newsItem is NewsItem {
                    let vc : NewsDetailsViewController = segue.destination as! NewsDetailsViewController
//                    vc.newsItemID = (newsItem as! NewsItem).id
                    
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
