//
//  ChakingTextField.swift
//  PulseCircle&ShakeTextField
//
//  Created by Sergey Gaponov on 6/7/18.
//  Copyright © 2018 Sergey Gaponov. All rights reserved.
//

import UIKit

class ShakingTextField: UITextField {

    func shake() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.05
        animation.repeatCount = 5
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: center.x - 4, y: center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: center.x + 4, y: center.y))
        
        layer.add(animation, forKey: "position")
    }

}
