//
//  ARModelListViewModel.swift
//  CameraIQARDemo
//
//  Created by Wei Si on 5/25/18.
//  Copyright © 2018 Wei Si. All rights reserved.
//

import UIKit

protocol ARViewModelProtocol {
    
    var iconDidSelected:((ARViewModelProtocol)->())? { get set }
    func selectIcon()
    
}


class ARModelListViewModel: NSObject {

    var arModelViewModels : [ARModelViewModel] = [ARModelViewModel]()
    
    required init(viewModels: [ARModelViewModel]) {
        self.arModelViewModels = viewModels
        
    }

}
