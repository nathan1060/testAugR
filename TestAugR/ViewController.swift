//
//  ViewController.swift
//  TestAugR
//
//  Created by Nathan Slippen on 10/2/20.
//  Copyright © 2020 Nathan Slippen. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet var sceneView: ARSCNView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set the view's delegate
        sceneView.delegate = self

        sceneView.autoenablesDefaultLighting = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Check for Support
        if ARImageTrackingConfiguration.isSupported {
            
            // Create a session configuration
            let configuration = ARImageTrackingConfiguration()
            if let imageToTrack = ARReferenceImage.referenceImages(inGroupNamed: "Pokemon Cards", bundle: Bundle.main) {
                configuration.trackingImages = imageToTrack
                configuration.maximumNumberOfTrackedImages = 1 //If you track more than 1 image, change this number, ie. 3
                print("Images added")
            }
            // Run the view's session
            sceneView.session.run(configuration)
        } else {
            print("Your Device does not support the Configuration necessary to run this Product")
            // Or let configuration = Some other type that may be supported; need to review ??
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
            //Empty

    } // End of func
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    // MARK: - ARSCNViewDelegate
    
  
     // Override to create and configure nodes for anchors added to the view's session.
     func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
     let node = SCNNode()
        DispatchQueue.main.async {
        
        if let imageAnchor = anchor as? ARImageAnchor {
            // Look at the item in the camera, the anchor, and determine the size
            if imageAnchor.referenceImage.name == "Ivysaur" {
            
            let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width, height: imageAnchor.referenceImage.physicalSize.height)
            plane.firstMaterial?.diffuse.contents = UIColor(white: 1.0, alpha: 0.7) //Provides some transparency through the plane
            let planeNode = SCNNode(geometry: plane) //of Type <#T##SCNGeometry?#>
            
            // Node's orientation settings
            planeNode.eulerAngles.x = -.pi/2
            node.addChildNode(planeNode)
            // Now we have a Plane where 3D images can be TRACKED !!
            
            if let pokeScene = SCNScene(named: "art.scnassets/Ivysaur.scn"){
                if let pokeNode = pokeScene.rootNode.childNodes.first {
                    pokeNode.eulerAngles.x = .pi/2
                    pokeNode.eulerAngles.z = .pi * 2
                    
                    planeNode.addChildNode(pokeNode)
                    print("Ivysaur added")
                }
            }
            } // End of Reference Name... If we have others, we need to refactor the code to look for others and assign on the pokeScene (named: "art.scnassets/YYYsaur.scn" ) / pokeNode ?
        } // End of imageAnchor
     }
     return node
     }

    
    //    func session(_ session: ARSession, didFailWithError error: Error) {
    //        // Present an error message to the user
    //
    //    }
    //
    //    func sessionWasInterrupted(_ session: ARSession) {
    //        // Inform the user that the session has been interrupted, for example, by presenting an overlay
    //
    //    }
    //
    //    func sessionInterruptionEnded(_ session: ARSession) {
    //        // Reset tracking and/or remove existing anchors if consistent tracking is required
    //
    //    }
} // End of Controller

/*
 // Implemented Delegate method to detect plane's in the REAL World
 func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
     guard let planeAnchor = anchor as? ARPlaneAnchor else {  //As an optional... needs downcasting
         print("Error")
         return
     }
     //let planeNode = createPlane(planeAnchor: planeAnchor)
     //node.addChildNode(planeNode)
     
 }
 
 let scene = SCNScene(named: "art.scnassets/ship.scn")!
 Set the scene to the view
 sceneView.scene = scene
 //let cube = SCNBox(width: 0.1, height: 0.1, length: 0.3, chamferRadius: 0.03)
 let sphere = SCNSphere(radius: 0.2)
 let material = SCNMaterial()
 material.diffuse.contents = UIImage(named: "art.scnassets/moon.jpg")     //UIColor.purple
 sphere.materials = [material]
 let node = SCNNode()
 node.position = SCNVector3(0, 0.1, -0.5)
 node.geometry = sphere
 sceneView.scene.rootNode.addChildNode(node)
 sceneView.autoenablesDefaultLighting = true
 
 */
/* Better way to write this code above
 // Implemented Delegate method to detect plane's in the REAL World
 func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
 if anchor is ARPlaneAnchor {
 let planeAnchor = anchor as! ARPlaneAnchor
 //            let plane = SCNPlane(width: CGFloat(planeAnchor.extent.x), height: CGFloat(planeAnchor.extent.z) )
 //            let planeNode = SCNNode()
 //            planeNode.position = SCNVector3(planeAnchor.center.x, 0, planeAnchor.center.z)
 //            planeNode.transform = SCNMatrix4MakeRotation(-Float.pi/2, 1, 0, 0)
 //            print("Plane detected")
 //
 //            let gridMaterial = SCNMaterial()
 //            gridMaterial.diffuse.contents = UIImage(named: "art.scnassets/grid.png")
 //            plane.materials = [gridMaterial]
 //            planeNode.geometry = plane
 //            node.addChildNode(planeNode)
 
 } else { return }
 }
 */
