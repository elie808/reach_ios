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

//{
//    "image": "http://reach.xtnd.io/cms/www/images/news/lenovo-yoga-c630-wos-laptop-012019-01-29-03-03-04.jpg",
//    "date": 1548633600,
//    "id": 6,
//    "name": "HELP YOUR CUSTOMER TO CHOOSE A DREAM LENOVO LAPTOP",
//    "description": "<p><a title=\"LEARN MORE\" href=\"https://www.lenovo.com/ae/en/laptops/c/Laptops\">LEARN MORE</a></p>"
//},

class NewsViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var collectionView : UICollectionView!
    
    // MARK: - Properties
    
    var dataSource = GenericCollectionDataSource<GenericCollectionCell<NewsItem>, NewsItem>()
    
    // MARK: - Views Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        dataSource.data = [NewsItem(imageName: "dummy_pdf", title: "Love to Dance", date: "June 16 2018", description: "Lorem Ipsum is placeholder text commonly the graphic."),
//        NewsItem(imageName: "dummy_pdf", title: "Lorem ipsum dolor sit amet consectetur", date: "June 16 2018", description: "Lorem Ipsum is placeholder text commonly the graphic."),
//        NewsItem(imageName: "dummy_pdf", title: "Love to Dance", date: "June 16 2018", description: "Lorem Ipsum is placeholder text commonly the graphic. Lorem Ipsum is placeholder text commonly the graphic. Lorem Ipsum is placeholder text commonly the graphic."),]
        
        collectionView.dataSource = dataSource
        
        let trainingList = Resource<[NewsItem]>(get: URL(string:NetworkingConstants.allNews)!)
        
        URLSession.shared.load(trainingList) { (trainingListItems, status) in
            self.dataSource.data = trainingListItems ?? []
            self.collectionView.reloadData()
        }
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }

}
