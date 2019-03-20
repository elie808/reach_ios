//
//  RegisterViewController.swift
//  reach-ios
//
//  Created by Elie El Khoury on 2/23/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit

struct RegisterUserObject : Codable {
    let first_name, last_name, mobile_number, date_of_birth, email, password, gender : String
    var organization, image_id : Int
    var brands : [Int]
}

class RegisterFormCell: UICollectionViewCell {
}

class RegisterViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet var container1: UIView!
    @IBOutlet var container2: UIView!
    
    // MARK: - Properties
    
    let cellID = "cellID"
    let totalViewCount = 2
    var viewIndex = 0

    var personalInfoVC : PersonalInfoTableViewController?
    var brandsFormVC : AddBrandsTableViewController?
//    var vendorsVC : VendorsTableViewController?
    
    // MARK: - Views Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        container1.frame.size = CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        container2.frame.size = CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    // MARK: - Actions
    
    @IBAction func didTapNext(_ sender: UIButton) {
        
        var userToRegister : RegisterUserObject?
        
        if viewIndex == 0 {
            
            if personalInfoVC?.formValid() == true {

                guard let selectedOrg = personalInfoVC?.selectedOrganization else { return }
                brandsFormVC?.passOrganization = selectedOrg
            
                nextButton.setTitle("Done", for: .normal)
                
                viewIndex = viewIndex < totalViewCount-1 ? viewIndex + 1 : viewIndex
                scrollToViewAtIndex(index: viewIndex)
            }
        } else if viewIndex == 1 {

            viewIndex = viewIndex < totalViewCount-1 ? viewIndex + 1 : viewIndex
            
            // get selected brand IDs from brandsFormVC
            guard let selectedBrands = brandsFormVC?.getSelectedBrandIDs() else { return }
            
            userToRegister = personalInfoVC?.getUserInfo()
            userToRegister?.brands = selectedBrands
            
            // Make POST API Call
            
            print("GOOOO")
        }
    }
    
    // MARK: - Helpers
    
    func scrollToViewAtIndex(index: Int) {
        let indexPath = IndexPath(item: index, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        switch segue.identifier {

        case "embedPersonalInfo":
            personalInfoVC   = segue.destination as?  PersonalInfoTableViewController
    
        case "embedBrands":
            if segue.destination is AddBrandsTableViewController {
                brandsFormVC = segue.destination as? AddBrandsTableViewController
            }
            
        default: return
        }
    }
}

extension RegisterViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return totalViewCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! RegisterFormCell

        if indexPath.item == 0 {
            cell.addSubview(self.container1)
        } else if indexPath.item == 1 {
            cell.addSubview(self.container2)
        } else {
            
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension RegisterViewController : UICollectionViewDelegateFlowLayout  {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
