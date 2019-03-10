//
//  CategoriesViewController.swift
//  reach-ios
//
//  Created by Elie El Khoury on 3/10/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit

struct Brand : Codable {
    let id, vendor_id : Int
    let name, image : String
}

class CategoriesViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var collectionView : UICollectionView!
    
    // MARK: - Properties
    
    var vendor : Company?
    var dataSource = GenericCollectionDataSource<BrandsCell, Brand>()
    
    // MARK: - Views Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = dataSource
        
        let brands = Resource<[Brand]>(get: URL(string: NetworkingConstants.vendorBrands(forVendorID: vendor?.id ?? 0) )! )
        
        URLSession.shared.load(brands) { (brandsList, status) in
            if let list = brandsList {
                self.dataSource.data = list
                self.collectionView.reloadData()
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension CategoriesViewController : UICollectionViewDelegate {
  
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension CategoriesViewController : UICollectionViewDelegateFlowLayout  {
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
//    }
//
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
