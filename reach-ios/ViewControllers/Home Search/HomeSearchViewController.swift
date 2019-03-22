//
//  HomeSearchViewController.swift
//  reach-ios
//
//  Created by Elie El Khoury on 3/22/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit

class SearchCell: GenericTableCell<Product> {
    
    @IBOutlet weak var brandImageView : UIImageView!
    @IBOutlet weak var nameLabel : UILabel!
    
    override var model : Product! {
        didSet {
            brandImageView?.urlSetImage(model.image, #imageLiteral(resourceName: "Reach_logo_white"))
            nameLabel?.text = model.name
        }
    }
}

class HomeSearchViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var emptyView : UIView!
    
    // MARK: - Properties
    
    var searchText : String?
    var dataSource = GenericTableDataSource<SearchCell, Product>()
    
    // MARK: - Navigation
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = dataSource
        
        let search = Resource<[Product]>(get: URL(string: NetworkingConstants.search(byName: searchText!))!)
        
        URLSession.shared.load(search) { (response, status) in
            if let results = response, results.count > 0 {
                self.dataSource.data = results
                self.tableView.reloadData()
            } else {
                self.emptyView.frame = self.tableView.frame
                self.view.addSubview(self.emptyView)
            }
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
            
        case Segue.HomeSearch.toTraining:
            if let product = sender, product is Product {
                let vc = segue.destination as! MediaTrainingViewController
                vc.subCategory = SubCategory(name: "", image: "", part_number: "", description: "", id : (product as! Product).id, subcategory_id : 0)
            }
            
        default: return
        }
        
    }
}

extension HomeSearchViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = dataSource.data[indexPath.row]
        performSegue(withIdentifier: Segue.HomeSearch.toTraining, sender: product)
    }
}
