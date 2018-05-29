//
//  ARCollectionViewDelegate.swift
//  CameraIQARDemo
//
//  Created by Wei Si on 5/25/18.
//  Copyright © 2018 Wei Si. All rights reserved.
//

import UIKit

class ARCollectionViewDelegate<Cell: UICollectionViewCell, ARModelViewModel>: NSObject, UICollectionViewDelegate {

    private var items: [ARModelViewModel]!
    var onItemSelected: (Int) -> ()
    
    init(items: [ARModelViewModel], onItemSelected:@escaping(Int)->()){
        self.items = items
        self.onItemSelected = onItemSelected
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("WEI check select index \(indexPath.row)")
        self.onItemSelected(indexPath.row)
        
    }
    
}
