//
//  CircleView.swift
//  CircleProgressBar
//
//  Created by Rodrigo Gonzalez on 08/02/2018.
//  Copyright © 2018 Rodrigo Gonzalez. All rights reserved.
//

import UIKit

class CircleView: UIView {
// basic idea from https://stackoverflow.com/questions/26578023/animate-drawing-of-a-circle
    
    var currentValue: Double = 0.0
    var maxValue: Double = 0.0
    var minValue: Double = 0.0
    var circleLayer: CAShapeLayer?
    var text: NSAttributedString?
    var label: UILabel?
    
    var animateCircleColor: UIColor = .red
    var staticCircleColor: UIColor = .black
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        outerCircle()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        outerCircle()
    }
    
    // radian angles for drawing the circle
    private static let min: Double = 1.5
    private static let max: Double = 3.5
    
    private let ratio: CGFloat = 2.0
    private let strokeWidth: CGFloat = 2.0
    
    func createCircle() {
        guard maxValue != 0 && maxValue != minValue else {
            return
        }
        let x = frame.size.width / ratio
        let y = frame.size.height / ratio
        // Use UIBezierPath as an easy way to create the CGPath for the layer.
        // The path should be the entire circle.
        
        let endAngle = CircleView.min +
                       (    (CircleView.max - CircleView.min) *
                            ( (currentValue - minValue) / ( maxValue - minValue) )
                        )
        
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: x , y: y), radius: (frame.size.width - 20)/2, startAngle: CGFloat(.pi * CircleView.min), endAngle: CGFloat(.pi * endAngle), clockwise: true)
        
        // Setup the CAShapeLayer with the path, colors, and line width
        let circleLayer = CAShapeLayer()
        
        circleLayer.path = circlePath.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.strokeColor = animateCircleColor.cgColor
        circleLayer.lineWidth = strokeWidth;
        
        // Don't draw the circle initially
        circleLayer.strokeEnd = 0.0
        layer.addSublayer(circleLayer)
        
        self.circleLayer = circleLayer
    }
    
    func outerCircle() {
        let x = frame.size.width / ratio
        let y = frame.size.height / ratio
        
        // Use UIBezierPath as an easy way to create the CGPath for the layer.
        // The path should be the entire circle.
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: x , y: y), radius: (frame.size.width)/2, startAngle: CGFloat(.pi * CircleView.min), endAngle: CGFloat(.pi * CircleView.max), clockwise: true)
        
        // Setup the CAShapeLayer with the path, colors, and line width
        let outerlayer = CAShapeLayer()
        outerlayer.path = circlePath.cgPath
        outerlayer.fillColor = UIColor.clear.cgColor
        outerlayer.strokeColor = staticCircleColor.cgColor
        outerlayer.lineWidth = strokeWidth;
        
        layer.addSublayer(outerlayer)
    }

    func animateCircle(duration: TimeInterval) {
        if circleLayer?.superlayer == nil {
            createCircle()
        }
        setText(text: text)
        // We want to animate the strokeEnd property of the circleLayer
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        
        // Set the animation duration appropriately
        animation.duration = duration
        
        // Animate from 0 (no circle) to 1 (full circle)
        animation.fromValue = 0
        animation.toValue = 1
        
        // Do a linear animation (i.e. the speed of the animation stays the same)
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        
        // Set the circleLayer's strokeEnd property to 1.0 now so that it's the
        // right value when the animation ends.
        circleLayer?.strokeEnd = 1.0
        
        // Do the actual animation
        circleLayer?.add(animation, forKey: "animateCircle")
    }

    private func setText(text: NSAttributedString?) {
        guard let text = text else {
            return
        }
        
        if label == nil {
            setupLabel()
        }
        
        label?.attributedText = text
    }
    
    private let offset: CGFloat = -32
    func setupLabel() {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byCharWrapping
        label.textAlignment = .center
        
        addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false;
        
        label.widthAnchor.constraint(equalTo: widthAnchor, constant: offset).isActive = true
        label.heightAnchor.constraint(equalTo: heightAnchor, constant: offset).isActive = true
        label.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

        
        self.label = label
    }
}
