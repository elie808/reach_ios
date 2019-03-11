//
//  SharpenSkillsViewController.swift
//  reach-ios
//
//  Created by Elie El Khoury on 2/24/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit

struct ProductMedia : Codable {
    let title, image, description, type, is_preferred, url : String
    let id : Int
}

class ProductMediaViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var tableView : UITableView!
    
    // MARK: - Properties
    
    var subCategory : SubCategory?
    var dataSource = GenericTableDataSource<SharpenSkillsCell, ProductMedia>()
    
    // MARK: - Views Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = dataSource
        
//        print("URL: ", NetworkingConstants.mediaTraining(forSubCategory: subCategory?.id ?? 0))
        
        let media = Resource<[ProductMedia]>(get: URL(string: NetworkingConstants.mediaTraining(forSubCategory: subCategory?.id ?? 0))! )
        
        URLSession.shared.load(media) { (trainingList, status) in
            print("Status: ", status, "List count: ", trainingList?.count)
            if let list = trainingList {
                self.dataSource.data = list
                self.tableView.reloadData()
            }
        }
        
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }

}

extension ProductMediaViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
