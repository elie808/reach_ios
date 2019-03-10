//
//  PromotionsViewController.swift
//  reach-ios
//
//  Created by Elie El Khoury on 2/24/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit

struct Promotion : Codable {
    let id, organization_id : Int
    let name, pdf, start_date, end_date, description, image : String
}

class PromotionsViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var collectionView : UICollectionView!
    
    // MARK: - Properties
    
    var dataSource = GenericCollectionDataSource<PromotionCell, Promotion>()
    
    // MARK: - Views Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = dataSource
        
        let promotions = Resource<[Promotion]>(get: URL(string: NetworkingConstants.allPromotions)!)
        
        URLSession.shared.load(promotions) { (promotions, status) in
            if let list = promotions {
                self.dataSource.data = list
                self.collectionView.reloadData()
            }
        }
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case Segue.PromotionsList.toPromotionPDF:
            if let promotion = sender {
                if promotion is Promotion {
                    let vc = segue.destination as! PDFViewController
                    vc.title = (promotion as! Promotion).name
                    vc.loadFromUrl(url: (promotion as! Promotion).pdf )
                }
            }
        default: return
        }
    }

}

extension PromotionsViewController : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let promotion = dataSource.data[indexPath.row]
        performSegue(withIdentifier: Segue.PromotionsList.toPromotionPDF, sender: promotion)
    }
    
}
