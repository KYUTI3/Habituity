//
//  ARSquareViewController.swift
//  Habituity
//
//  Created by Luis Cardenas on 11/10/24.
//
import SwiftUI
import Foundation
import ARKit
import SceneKit

class ARSquareViewController: UIViewController, ARSCNViewDelegate {
    var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        sceneView = ARSCNView(frame: self.view.frame)
        sceneView.delegate = self
        sceneView.scene = SCNScene()
        self.view.addSubview(sceneView)
        
       
        sceneView.autoenablesDefaultLighting = true
        sceneView.automaticallyUpdatesLighting = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
       
        let configuration = ARBodyTrackingConfiguration()
        sceneView.session.run(configuration)
        

        addRandomSquares()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
  
    func addRandomSquares() {
        for _ in 1...5 { 
            let squareNode = createRandomSquare()
            sceneView.scene.rootNode.addChildNode(squareNode)
        }
    }
    
  
    func createRandomSquare() -> SCNNode {
        let size: CGFloat = 0.1
        let square = SCNPlane(width: size, height: size)
        square.firstMaterial?.diffuse.contents = UIColor.random
        
        let squareNode = SCNNode(geometry: square)
        
        
        squareNode.position = SCNVector3(
            Float.random(in: -0.5...0.5), // Random X position
            Float.random(in: -0.5...0.5), // Random Y position
            -1.0 // 1 meter in front of the camera
        )
        
        return squareNode
    }
    
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        guard let bodyAnchor = sceneView.session.currentFrame?.anchors.compactMap({ $0 as? ARBodyAnchor }).first else {
            return
        }
        
        
        let rightWristTransform = bodyAnchor.skeleton.modelTransform(for: .rightWrist)
        
        
        if let firstSquare = sceneView.scene.rootNode.childNodes.first {
            let position = SCNVector3(
                rightWristTransform.columns.3.x,
                rightWristTransform.columns.3.y,
                rightWristTransform.columns.3.z
            )
            firstSquare.position = position
        }
    }
}

// Extension to generate a random color
extension UIColor {
    static var random: UIColor {
        return UIColor(
            red: CGFloat.random(in: 0...1),
            green: CGFloat.random(in: 0...1),
            blue: CGFloat.random(in: 0...1),
            alpha: 1.0
        )
    }
}

// SwiftUI wrapper for ARSquareViewController
struct ARSquareView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> ARSquareViewController {
        return ARSquareViewController()
    }
    
    func updateUIViewController(_ uiViewController: ARSquareViewController, context: Context) {}
}

// SwiftUI ContentView for Preview
struct ContentView: View {
    var body: some View {
        ARSquareView()
            .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    ContentView()
}
