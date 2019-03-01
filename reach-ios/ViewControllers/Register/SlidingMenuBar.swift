//
//  SlidingMenuBar.swift
//  reach-ios
//
//  Created by Elie El Khoury on 2/22/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit

class SlidingMenuBar: UIView {

//    @IBOutlet weak var mainV
    
    let cellID = "cellID"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func initializeViews() {
//        collectionView.dataSource = self
//        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellID)
//        collectionView.frame = self.frame
//        addSubview(collectionView)
    }
}

extension SlidingMenuBar : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
}

extension SlidingMenuBar : UICollectionViewDelegateFlowLayout  {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width/4, height: frame.height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
