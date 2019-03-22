//
//  RegisterViewController.swift
//  reach-ios
//
//  Created by Elie El Khoury on 2/23/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit

class RegisterFormCell: UICollectionViewCell {
}

class RegisterViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var slidingMenuBar : SlidingMenuBar!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet var container1: UIView!
    @IBOutlet var container2: UIView!
    
    // MARK: - Properties
    
    let cellID = "cellID"
    let totalViewCount = 2
    var viewIndex = 0
    var personalInfoFormValid : Bool = false

    var personalInfoVC : PersonalInfoTableViewController?
    var brandsFormVC : AddBrandsTableViewController?

    var userToRegister : RegisterUserObject?
    
    // MARK: - Views Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        container1.frame.size = CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        container2.frame.size = CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    fileprivate func post() {
        
        let userToPost = Resource<RegisterUserObject>(url: URL(string: NetworkingConstants.register)!, method: .post(userToRegister!))
        
        URLSession.shared.load(userToPost, completion: { (response, status) in
            
            self.show(alert: "Success", message: (response?.message)!, buttonTitle: "Ok", onSuccess: {
                _ = self.navigationController?.popViewController(animated: true)
            })
            
        }) { (error, status) in
            self.show(alert: "Error \(String(describing:(error?.code)!))", message: (error?.message)!, buttonTitle: "OK", onSuccess: nil)
        }
    }
    
    // MARK: - Actions
    
    @IBAction func didTapNext(_ sender: UIButton) {
        
        if viewIndex == 0 {
            
            if personalInfoVC?.formValid() == true {

                personalInfoFormValid = true
                
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
            
            if personalInfoFormValid == true && selectedBrands.count > 0 {
            
                userToRegister = personalInfoVC?.getUserInfo()
                userToRegister?.brands = selectedBrands
                
                post()
            }
        }
    }
    
    // MARK: - Helpers
    
    func scrollToViewAtIndex(index: Int) {
        let indexPath = IndexPath(item: index, section: 0)
        collectionView.isScrollEnabled = true
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        collectionView.isScrollEnabled = false
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
        
        if collectionView == self.collectionView {
            
        } else { //sliding bar
            viewIndex = indexPath.row
            scrollToViewAtIndex(index: indexPath.row)
        }
    }
    
}

extension RegisterViewController : UICollectionViewDelegateFlowLayout  {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.collectionView {
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        } else { //sliding bar
            return CGSize(width: collectionView.frame.width/2, height: collectionView.frame.height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
