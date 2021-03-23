//
//  BezierViewController.swift
//  VKsimulator
//
//  Created by Admin on 26.01.2021.
//

import UIKit

final class BezierViewController: UIViewController {

    
    @IBOutlet weak var greenView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
     
    }
    
    @IBAction func buttonTap(_ sender: UIButton) {
        animateCloud()
    }
    
    @IBAction func logOutButtonTap(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func animateCloud() {
        let layer = CAShapeLayer()
        

        
        let shape = UIBezierPath()
        shape.move(to: CGPoint(x: 45.12, y: 16.99))
        shape.addLine(to: CGPoint(x: 124.56, y: 16.99))
        shape.addCurve(to: CGPoint(x: 164.31, y: -22.12), controlPoint1: CGPoint(x: 147.17, y: 16.99), controlPoint2: CGPoint(x: 164.31, y: -0.24))
        shape.addCurve(to: CGPoint(x: 124.51, y: -61.47), controlPoint1: CGPoint(x: 164.31, y: -44.29), controlPoint2: CGPoint(x: 147.22, y: -61.47))
        shape.addCurve(to: CGPoint(x: 81.54, y: -86.62), controlPoint1: CGPoint(x: 117.24, y: -75.49), controlPoint2: CGPoint(x: 103.61, y: -86.62))
        shape.addCurve(to: CGPoint(x: 32.57, y: -44.43), controlPoint1: CGPoint(x: 55.81, y: -86.62), controlPoint2: CGPoint(x: 35.94, y: -68.12))
        shape.addCurve(to: CGPoint(x: 11.28, y: -14.89), controlPoint1: CGPoint(x: 20.41, y: -40.19), controlPoint2: CGPoint(x: 11.28, y: -29.44))
        shape.addCurve(to: CGPoint(x: 45.12, y: 16.99), controlPoint1: CGPoint(x: 11.28, y: 3.13), controlPoint2: CGPoint(x: 24.76, y: 16.99))
        shape.close()
        //shape.stroke()
        
        shape.fit(into: greenView.bounds).moveCenter(to: greenView.bounds.center).fill()
        
        layer.strokeColor = UIColor.blue.cgColor
        layer.path = shape.cgPath
        
        layer.lineWidth = 10
        layer.fillColor = UIColor.gray.cgColor
        layer.lineCap = .round
        //layer.strokeEnd = 0
        //greenView.layer.mask = layer
                
//        let circleLayer1 = CAShapeLayer()
//        circleLayer1.backgroundColor = UIColor.red.cgColor
//        circleLayer1.bounds = CGRect(x: 0, y: 0, width: 10, height: 10)
//        circleLayer1.position = CGPoint(x: 40, y: 20)
//        circleLayer1.cornerRadius = 5
//        let followPathAnimation1 = CAKeyframeAnimation(keyPath: "position")
//        followPathAnimation1.beginTime  = 0.001
//        followPathAnimation1.path = shape.cgPath
//        followPathAnimation1.calculationMode = CAAnimationCalculationMode.paced
//        followPathAnimation1.speed = 0.05
//        followPathAnimation1.repeatCount = Float.infinity
//        circleLayer1.add(followPathAnimation1, forKey: nil)
        let duration = CFTimeInterval(5)
        
        let strokeStartAnimation = CABasicAnimation(keyPath: "strokeStart")
        strokeStartAnimation.fromValue = 0.0
        strokeStartAnimation.toValue = 1.0
        strokeStartAnimation.duration = duration
        strokeStartAnimation.fillMode = .both
        //strokeStartAnimation.beginTime = 0.5

        let strokeEndAnimation = CABasicAnimation(keyPath: "strokeEnd")
        strokeEndAnimation.fromValue = 0.1
        strokeEndAnimation.toValue = 1.1
        strokeEndAnimation.duration = duration
        strokeEndAnimation.fillMode = .both

        let animationGroup = CAAnimationGroup()
        animationGroup.duration = duration
        animationGroup.fillMode = CAMediaTimingFillMode.both// backwards
        animationGroup.repeatDuration = .infinity
        animationGroup.animations = [strokeStartAnimation, strokeEndAnimation]
        
        layer.add(animationGroup, forKey: nil)
        greenView.layer.addSublayer(layer)
        
//        greenView.layer.addSublayer(circleLayer1)

    }
}


extension CGRect{
    var center: CGPoint {
        return CGPoint( x: self.size.width/2.0,y: self.size.height/2.0)
    }
}
extension CGPoint{
    func vector(to p1:CGPoint) -> CGVector{
        return CGVector(dx: p1.x-self.x, dy: p1.y-self.y)
    }
}

extension UIBezierPath{
    func moveCenter(to:CGPoint) -> Self{
        let bound  = self.cgPath.boundingBox
        let center = bounds.center
        
        let zeroedTo = CGPoint(x: to.x-bound.origin.x, y: to.y-bound.origin.y)
        let vector = center.vector(to: zeroedTo)
        
        _ = offset(to: CGSize(width: vector.dx, height: vector.dy))
        return self
    }
    
    func offset(to offset:CGSize) -> Self{
        let t = CGAffineTransform(translationX: offset.width, y: offset.height)
        _ = applyCentered(transform: t)
        return self
    }
    
    func fit(into:CGRect) -> Self{
        let bounds = self.cgPath.boundingBox
        
        let sw     = into.size.width/bounds.width
        let sh     = into.size.height/bounds.height
        let factor = min(sw, max(sh, 0.0))
        
        return scale(x: factor, y: factor)
    }
    
    func scale(x:CGFloat, y:CGFloat) -> Self{
        let scale = CGAffineTransform(scaleX: x, y: y)
        _ = applyCentered(transform: scale)
        return self
    }
    
    
    func applyCentered(transform: @autoclosure () -> CGAffineTransform ) -> Self{
        let bound  = self.cgPath.boundingBox
        let center = CGPoint(x: bound.midX, y: bound.midY)
        var xform  = CGAffineTransform.identity
        
        xform = xform.concatenating(CGAffineTransform(translationX: -center.x, y: -center.y))
        xform = xform.concatenating(transform())
        xform = xform.concatenating( CGAffineTransform(translationX: center.x, y: center.y))
        apply(xform)
        
        return self
    }
    
}
