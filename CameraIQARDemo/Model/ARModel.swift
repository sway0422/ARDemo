//
//  ARModel.swift
//  CameraIQARDemo
//
//  Created by Wei Si on 5/25/18.
//  Copyright © 2018 Wei Si. All rights reserved.
//

import UIKit
import ARKit
import SceneKit

class ARModel: NSObject {

    var nodeModel: SCNNode!
    var scene: SCNScene!
    var image: UIImage
    
    init(nodeName: String, image: UIImage){
        self.scene = SCNScene(named: "art.scnassets/emojibase.scn")
        self.image = image
        self.nodeModel = self.scene.rootNode.childNode(withName: nodeName, recursively: true)
    }
    
    
    
}
