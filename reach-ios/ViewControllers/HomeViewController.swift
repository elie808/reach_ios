//
//  HomeViewController.swift
//  reach-ios
//
//  Created by Elie El Khoury on 2/18/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit

struct Person {
    let firstName, lastName : String
}

class NewsFeedCell: GenericCollectionCell<Person> {
    
    @IBOutlet weak var textLabel : UILabel!
    
    override var model : Person! {
        didSet {
            textLabel?.text = model.firstName
        }
    }
}

class HomeViewController: UIViewController {

    // MARK: - Properties
    
    var collectionDataSource = GenericCollectionDataSource<NewsFeedCell,Person>()
    
    // MARK: - Outlets
    
    @IBOutlet weak var profilePicture: ProfilePictureProgressView!
    @IBOutlet weak var collectionView : UICollectionView!
    
    // MARK: - Views Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionDataSource.data = [Person(firstName: "Greatest", lastName: "Ever"),
                                     Person(firstName: "Zabre Greatest", lastName: "Ever"),
                                    Person(firstName: "Greatest", lastName: "Pop")]
        
        collectionView.dataSource = collectionDataSource
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        profilePicture.animateProgress()
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
