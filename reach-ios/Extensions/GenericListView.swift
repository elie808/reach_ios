//
//  GenericTableView.swift
//  reach-ios
//
//  Created by Elie El Khoury on 2/18/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit

// Mark: - UITableView

class GenericTableCell<U>: UITableViewCell {
    
    var model : U!
    var index : IndexPath!
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}

class GenericTableDataSource<T: GenericTableCell<U>, U>: NSObject, UITableViewDataSource {
    
    var data = [U]()
    
    let cellID = "tableCellID" // set as Reuse Identifier in StoryBoard
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! GenericTableCell<U>
        cell.model = data[indexPath.row]
        cell.index = indexPath
        
        return cell
    }
}

// Mark: - UICollectionView

class GenericCollectionCell<U>: UICollectionViewCell {
    
    var model : U!
    var index : IndexPath!
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}

class GenericCollectionDataSource<T: GenericCollectionCell<U>, U>: NSObject, UICollectionViewDataSource {
    
    var data = [U]()
    
    let cellID = "collectionCellID" // set as Reuse Identifier in StoryBoard
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! GenericCollectionCell<U>
        cell.model = data[indexPath.row]
        cell.index = indexPath
        
        return cell
    }
}
