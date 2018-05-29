//
//  ARCollectionViewDataSource.swift
//  CameraIQARDemo
//
//  Created by Wei Si on 5/25/18.
//  Copyright © 2018 Wei Si. All rights reserved.
//

import UIKit
import Foundation

class ARCollectionViewDataSource<Cell :UICollectionViewCell,ARModelViewModel> : NSObject, UICollectionViewDataSource {

    private var cellIdentifier : String!
    private var items: [ARModelViewModel]!
    var configureCell : (Cell,ARModelViewModel) -> ()
    
    init(cellIdentifier: String, items: [ARModelViewModel], configureCell: @escaping (Cell,ARModelViewModel) ->()){
        self.cellIdentifier = cellIdentifier
        self.items = items
        self.configureCell = configureCell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: indexPath) as! Cell
        let item = self.items[indexPath.row]
        self.configureCell(cell, item)
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


}
