//
//  NewsViewController.swift
//  reach-ios
//
//  Created by Elie El Khoury on 2/25/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit

struct NewsItem {
    let imageName, title, date, description : String
}

class NewsViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var collectionView : UICollectionView!
    
    // MARK: - Properties
    
    var dataSource = GenericCollectionDataSource<GenericCollectionCell<NewsItem>, NewsItem>()
    
    // MARK: - Views Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource.data = [NewsItem(imageName: "dummy_pdf", title: "Love to Dance", date: "June 16 2018", description: "Lorem Ipsum is placeholder text commonly the graphic."),
        NewsItem(imageName: "dummy_pdf", title: "Lorem ipsum dolor sit amet consectetur", date: "June 16 2018", description: "Lorem Ipsum is placeholder text commonly the graphic."),
        NewsItem(imageName: "dummy_pdf", title: "Love to Dance", date: "June 16 2018", description: "Lorem Ipsum is placeholder text commonly the graphic. Lorem Ipsum is placeholder text commonly the graphic. Lorem Ipsum is placeholder text commonly the graphic."),]
        
        collectionView.dataSource = dataSource
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }

}
