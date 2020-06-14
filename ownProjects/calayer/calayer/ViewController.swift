//
//  ViewController.swift
//  calayer
//
//  Created by Marina Beatriz Santana de Aguiar on 14.06.20.
//  Copyright © 2020 Marina Beatriz Santana de Aguiar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let layerA = CALayer()
    let layerB = CALayer()
    let layerC = CALayer()
    
    var label: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        layerA.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        layerA.backgroundColor = UIColor.black.cgColor
        layerA.delegate = self
        
        layerB.frame = CGRect(x: (view.bounds.width) * 6/7, y: 0, width: view.bounds.width / 7, height: view.bounds.height)
        layerB.backgroundColor = UIColor.darkGray.cgColor

        layerC.frame = CGRect(x: (view.bounds.width) * 6/7, y: 0, width: view.bounds.width / 7, height: view.bounds.height)
        layerC.backgroundColor = UIColor.lightGray.cgColor
      
        view.layer.addSublayer(layerA)
        view.layer.addSublayer(layerB)
    
        label = UILabel(frame: CGRect(x: (view.bounds.width / 2) - 50, y: (view.bounds.height / 2) - 50, width: 100, height: 100))
        label.text = "YOU"
        label.textColor = UIColor.white
        self.view.addSubview(label)
    }
    
    
    public func layerFor(_ touch: UITouch) -> CALayer? {
        // Get location of the touch
        let view = self.view
        let touchLocation = touch.location(in: view)

        // Get the layer on this location
        let hitPresentationLayer = view!.layer.presentation()?.hitTest(touchLocation)
        return hitPresentationLayer?.model()
    }
}

extension ViewController: CALayerDelegate {
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first, let touchedLayer = self.layerFor(touch) {
            touchedLayer.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width , height: self.view.bounds.height)
            if (touchedLayer.backgroundColor == UIColor.darkGray.cgColor) {
                self.view.layer.addSublayer(self.layerC)
                
                // on top of layerC
                self.view.addSubview(label)
                self.label.text = "MADE"
            } else if (touchedLayer.backgroundColor == UIColor.lightGray.cgColor) {
                self.label.textColor = UIColor.black
                self.label.text = "IT"
            }
        }
    }
}

