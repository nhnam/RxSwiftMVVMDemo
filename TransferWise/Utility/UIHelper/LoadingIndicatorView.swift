//
//  LoadingIndicatorView.swift
//  TransferWise
//
//  Created by Nam Nguyen on 24/11/18.
//  Copyright © 2018 Nam Nguyen. All rights reserved.
//

import UIKit

class LoadingIndicatorView: UIView {
    let circlePathLayer = CAShapeLayer()
    let circleRadius = 20.0
    var progess: CGFloat {
        get {
            return circlePathLayer.strokeEnd
        }
        set {
            if newValue > 1 {
                circlePathLayer.strokeEnd = 1
            } else if newValue < 0 {
                circlePathLayer.strokeEnd = 0
            } else {
                circlePathLayer.strokeEnd = newValue
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configurate()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configurate()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        circlePathLayer.frame = self.bounds
        circlePathLayer.path = circlePath.cgPath
        progess = 0.8
    }
    
    private func configurate() {
        circlePathLayer.frame = self.bounds
        circlePathLayer.lineWidth = 2.0
        circlePathLayer.fillColor = UIColor.clear.cgColor
        circlePathLayer.strokeColor = UIColor.darkGray.cgColor
        circlePathLayer.lineCap = CAShapeLayerLineCap.round
        self.layer.addSublayer(circlePathLayer)
        self.backgroundColor = UIColor.white
    }
    
    private var circleFrame: CGRect {
        var circleFrame = CGRect(x: 0, y: 0, width: 2*circleRadius, height: 2*circleRadius)
        let circlePathBounds = circlePathLayer.bounds
        circleFrame.origin.x = circlePathBounds.midX - circleFrame.midX
        circleFrame.origin.y = circlePathBounds.midY - circleFrame.midY
        return circleFrame
    }
    
    private var circlePath: UIBezierPath {
        return UIBezierPath(ovalIn: circleFrame)
    }
    
    func spin(speed: CGFloat = 1.0) {
        circlePathLayer.add(spinAnimation(speed), forKey: "rotationAnimation")
    }
    
    func stop() {
        if Thread.isMainThread {
            circlePathLayer.removeAnimation(forKey: "rotationAnimation")
            self.reveal()
        } else {
            DispatchQueue.main.async { [unowned self] in
                self.circlePathLayer.removeAnimation(forKey: "rotationAnimation")
                self.reveal()
            }
        }
    }
    
    private func reveal() {
        UIView.animate(withDuration: 0.3, delay: 0.0, options: UIView.AnimationOptions.curveEaseOut, animations: { [unowned self] in
            self.backgroundColor = .clear
            self.circlePathLayer.removeFromSuperlayer()
        }, completion: nil)
    }
    
    private func spinAnimation(_ speed: CGFloat) -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.duration = TimeInterval(1.0)
        animation.fromValue = 0
        animation.toValue = Double.pi * 2
        animation.repeatCount = .infinity
        return animation
    }
    
}
