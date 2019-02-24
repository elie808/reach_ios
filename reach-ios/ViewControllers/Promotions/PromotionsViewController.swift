//
//  PromotionsViewController.swift
//  reach-ios
//
//  Created by Elie El Khoury on 2/24/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit

struct Promotion {
    let name, description : String
    let imageName : String
}

class PromotionsViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var collectionView : UICollectionView!
    
    // MARK: - Properties
    
    var dataSource = GenericCollectionDataSource<PromotionCell, Promotion>()
    
    // MARK: - Views Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource.data = [Promotion(name: "Summer Deal", description: "Lorem Ipsum set dolor amet", imageName: "dummy_promotion"),
                           Promotion(name: "What will you do with your next 365 ?", description: "Lorem Ipsum set dolor amet", imageName: "dummy_promotion")]
        collectionView.dataSource = dataSource
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }

}

extension PromotionsViewController : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(dataSource.data[indexPath.row])
    }
    
}
