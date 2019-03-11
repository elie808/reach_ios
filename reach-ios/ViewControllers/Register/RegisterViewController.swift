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
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet var container1: UIView!
    @IBOutlet var container2: UIView!
    
    // MARK: - Properties
    
    let cellID = "cellID"
    let totalViewCount = 3
    var viewIndex = 0
    
    // MARK: - Views Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        container1.frame.size = CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        container2.frame.size = CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    // MARK: - Actions
    
    @IBAction func didTapNext(_ sender: UIButton) {
        viewIndex = viewIndex < totalViewCount-1 ? viewIndex + 1 : viewIndex
        scrollToViewAtIndex(index: viewIndex)
    }
    
    // MARK: - Helpers
    
    func scrollToViewAtIndex(index: Int) {
        let indexPath = IndexPath(item: index, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
}

extension RegisterViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return totalViewCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! RegisterFormCell
        let colors : [UIColor] = [.red, .gray, .blue]
        cell.backgroundColor = colors[indexPath.item]
        
//        self.container1.frame = cell.frame
        
        if indexPath.item == 0 {
            cell.addSubview(self.container1)
        } else if indexPath.item == 1 {
            cell.addSubview(self.container2)
        } else {
            
        }
        
        
//        switch indexPath.item {
//        case 0:
//            self.container1.frame = cell.frame
//            cell.addSubview(self.container1)
//        case 1:
////            self.container2.frame = cell.frame
////            cell.addSubview(self.container2)
//        default: return UICollectionViewCell()
//        }
        
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
