//
//  ARMainVC.swift
//  CameraIQARDemo
//
//  Created by Wei Si on 5/24/18.
//  Copyright © 2018 Wei Si. All rights reserved.
//

import UIKit
import ARKit
import SceneKit


class ARMainVC: UIViewController {

    @IBOutlet weak var sceneView: ARSCNView!
    @IBOutlet weak var mCollectionView: UICollectionView!
    
    private var mCollectionDataSource: ARCollectionViewDataSource<ARCollectionViewCell, ARModelViewModel>!
    private var mCollectionDelegate:ARCollectionViewDelegate<ARCollectionViewCell, ARModelViewModel>!
    
    private var iconListViewModel : ARModelListViewModel!
    private var selectedViewModel: ARModelViewModel?
    var nodeModel : SCNNode?
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
    private func updateUI() {
        
        let firstImage = UIImage(named: "Texture_1")
        let secondImage = UIImage(named: "Texture_11")
        
        let firstARModel = ARModel(nodeName: "Smiley11", image: firstImage!)
        let secondARModel = ARModel(nodeName: "Smiley11", image: secondImage!)
        
        let firstARViewModel = ARModelViewModel(arModel: firstARModel)
        let secondARViewModel = ARModelViewModel(arModel: secondARModel)
        
        var arModelViewModels = [ARModelViewModel]()
        arModelViewModels.append(firstARViewModel)
        arModelViewModels.append(secondARViewModel)
        
        self.iconListViewModel = ARModelListViewModel(viewModels: arModelViewModels)
        // setup binding
        updateDataSource()
        
        sceneView.delegate = self
        sceneView.showsStatistics = false         
        let scene = SCNScene()
        sceneView.scene = scene
        sceneView.autoenablesDefaultLighting = true
    }
    
    private func updateDataSource() {
        self.mCollectionDataSource = ARCollectionViewDataSource(cellIdentifier:Cells.iconCell, items: self.iconListViewModel.arModelViewModels, configureCell: { (cell, vm) in
        
            cell.mBtn.layer.cornerRadius = 30
            cell.mBtn.layer.masksToBounds = true
            cell.mBtn.setImage(vm.arModel.image, for: .normal)
        })
        
        self.mCollectionDelegate = ARCollectionViewDelegate(items:self.iconListViewModel.arModelViewModels, onItemSelected: { index in
            
        })
        self.mCollectionView.delegate = self.mCollectionDelegate
        self.mCollectionView.dataSource = self.mCollectionDataSource
        self.mCollectionView.reloadData()
        
    }
    
    func updateScene(updatedViewModel: ARModelViewModel) {
        print("WEI check selected ViewModel here")
        
        let scene = SCNScene()
        let sphere = SCNSphere(radius: 0.3)
        let material = SCNMaterial()
        material.diffuse.contents = updatedViewModel.arModel.image
        sphere.materials = [material]
        
        let sphereNode = SCNNode(geometry: sphere)
        sphereNode.position = SCNVector3Make(0, 0, -0.5)
        scene.rootNode.addChildNode(sphereNode)
        
        self.sceneView.scene = scene
//        self.nodeModel = updatedViewModel.arModel.nodeModel
//        self.nodeModel?.position = SCNVector3Make(0, 0, -0.5)
        
        
    }

}

extension ARMainVC: ARSCNViewDelegate {
    
    
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
    
    
    func renderer(_ renderer: SCNSceneRenderer, didRemove node: SCNNode, for anchor: ARAnchor) {
        
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        if !anchor.isKind(of: ARPlaneAnchor.self) {
            DispatchQueue.main.async {
                let modelClone = self.nodeModel?.clone()
                modelClone?.position = SCNVector3Zero

                // Add model as a child of the node
                node.addChildNode(modelClone!)
            }
        }
    }
    

}
