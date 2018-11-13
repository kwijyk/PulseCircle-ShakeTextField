//
//  ViewController.swift
//  PulseCircle&ShakeTextField
//
//  Created by Sergey Gaponov on 6/7/18.
//  Copyright © 2018 Sergey Gaponov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var shakeTextField: ShakingTextField!
    
    @IBOutlet weak var pulseImageView: UIView!
    
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shakeTextField.delegate = self
        
        pulseImageView.isUserInteractionEnabled = true
        pulseImageView.layer.cornerRadius = pulseImageView.bounds.height / 2
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        tapGesture.numberOfTapsRequired = 1  
        pulseImageView.addGestureRecognizer(tapGesture)
        
        pulseImageView.layer.cornerRadius = pulseImageView.bounds.height / 2
        pulseImageView.backgroundColor = UIColor(red: 124/255, green: 224/255, blue: 254/255, alpha: 1)
        
        startTimer()
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1,
                                     target: self,
                                     selector: #selector(timerAction),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    @objc func timerAction() {
        let pulse = Pulsing(numberOfPulses: 0, radius: 120, position: pulseImageView.center)
        pulse.animationDuration = 4
        pulse.initialPulsScale = 0.3
        pulse.backgroundColor = UIColor(red: 124/255, green: 224/255, blue: 254/255, alpha: 1).cgColor
//         pulse.backgroundColor = UIColor.red.cgColor
        self.view.layer.insertSublayer(pulse, below: pulseImageView.layer)
    }
    
    @objc private func tapAction () {
        let pulse = Pulsing(numberOfPulses: 0, radius: 110, position: pulseImageView.center)
        pulse.animationDuration = 2
        pulse.initialPulsScale = 0
//        pulse.backgroundColor = UIColor(red: 82, green: 232, blue: 207, alpha: 1).cgColor
        self.view.layer.insertSublayer(pulse, below: pulseImageView.layer)

        
//         pulsCercle(image: pulseImageView)
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//            self.pulsCercle(image: self.secondPulsImageView)
//        }
    }
    
    func pulsCercle(image: UIImageView) {
        CATransaction.begin()
        CATransaction.setAnimationDuration(2)
        
        //transform scale animation
        var theAnimation: CABasicAnimation?
        theAnimation = CABasicAnimation(keyPath: "transform.scale.xy")
        theAnimation?.repeatCount = Float.infinity
        theAnimation?.autoreverses = false
        theAnimation?.fromValue = Float(1.0)
        theAnimation?.toValue = Float(2.0)
        theAnimation?.isRemovedOnCompletion = false
        
        image.layer.add(theAnimation!, forKey: "pulse")
     
        image.isUserInteractionEnabled = false
        CATransaction.setCompletionBlock({() -> Void in

            //alpha Animation for the image
            let animation = CAKeyframeAnimation(keyPath: "opacity")
            animation.duration = 2
            animation.repeatCount = Float.infinity
            animation.values = [Float(2.0), Float(0.0)]
            image.layer.add(animation, forKey: "opacity")
        })
        
        CATransaction.commit()
    }

}

extension ViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        shakeTextField.shake()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        shakeTextField.shake()
        return false
    }
}
