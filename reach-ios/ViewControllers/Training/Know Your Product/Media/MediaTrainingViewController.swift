//
//  MediaTrainingViewController.swift
//  reach-ios
//
//  Created by Elie El Khoury on 3/12/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit

struct MediaTraining : Codable {
    let id : Int
    let title, image, description, type, is_preferred, url : String
}

class MediaTrainingCell: GenericTableCell<MediaTraining> {
    
    @IBOutlet weak var cellImageView : UIImageView!
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var dateLabel : UILabel!
    @IBOutlet weak var descriptionLabel : UILabel!
    
    override var model : MediaTraining! {
        didSet {
            cellImageView.urlSetImage(model.image)
            titleLabel.text = model.title
            dateLabel.text = model.type
            descriptionLabel.text = model.description
        }
    }
}

class MediaTrainingViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var headerImageView : UIImageView!
    @IBOutlet weak var tableView : UITableView!
    
    // MARK: - Properties
    
    var subCategory : SubCategory?
    var tableDataSource = GenericTableDataSource<MediaTrainingCell, MediaTraining>()
    
    // MARK: - Views Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        headerImageView.urlSetImage(subCategory?.image)
        tableView.dataSource = tableDataSource

        let media = Resource<[MediaTraining]>(get: URL(string: NetworkingConstants.mediaTraining(forSubCategory: subCategory?.id ?? 0))! )
        
        URLSession.shared.load(media) { (mediaList, status) in
            if let list = mediaList {
                self.tableDataSource.data = list
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
    
}

extension MediaTrainingViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
