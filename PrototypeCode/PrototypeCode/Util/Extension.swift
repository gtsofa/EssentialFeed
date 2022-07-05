//
//  Extension.swift
//  PrototypeCode
//
//  Created by Julius on 05/07/2022.
//

import Foundation
import UIKit

extension UIColor {
    static func hex(_ hex: String) -> UIColor {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) { cString.remove(at: cString.startIndex) }

        if ((cString.count) != 6) { return UIColor.gray }

        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    static func randomCGFloat() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }

    static func randomColor() -> UIColor {
        let r = UIColor.randomCGFloat()
        let g = UIColor.randomCGFloat()
        let b = UIColor.randomCGFloat()

        return UIColor(red: r, green: g, blue: b, alpha: 1)
    }
}


extension UIView {
    
    /**
    Adds autolayout constraints to innerView to center it in its superview and fix its size.
    `innerView` should have a superview.
    */
    func centerViewInSuperview() {
        assert(self.superview != nil, "`view` should have a superview")
        
        translatesAutoresizingMaskIntoConstraints = false
        
        let constraintH = NSLayoutConstraint(
            item: self,
            attribute: NSLayoutConstraint.Attribute.centerX,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: superview,
            attribute: NSLayoutConstraint.Attribute.centerX,
            multiplier: 1,
            constant: 0
        )
        let constraintV = NSLayoutConstraint(
            item: self,
            attribute: NSLayoutConstraint.Attribute.centerY,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: superview,
            attribute: NSLayoutConstraint.Attribute.centerY,
            multiplier: 1,
            constant: 0
        )
        let constraintWidth = NSLayoutConstraint(
            item: self,
            attribute: NSLayoutConstraint.Attribute.width,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: nil,
            attribute: NSLayoutConstraint.Attribute.notAnAttribute,
            multiplier: 1,
            constant: frame.size.width
        )
        let constraintHeight = NSLayoutConstraint(
            item: self,
            attribute: NSLayoutConstraint.Attribute.height,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: nil,
            attribute: NSLayoutConstraint.Attribute.notAnAttribute,
            multiplier: 1,
            constant: frame.size.height
        )
        superview!.addConstraints([constraintV, constraintH, constraintWidth, constraintHeight])
    }
    
    
    
    func anchor(top: NSLayoutYAxisAnchor? = nil,
                    left: NSLayoutXAxisAnchor? = nil,
                    bottom: NSLayoutYAxisAnchor? = nil,
                    right: NSLayoutXAxisAnchor? = nil,
                    paddingTop: CGFloat = 0,
                    paddingLeft: CGFloat = 0,
                    paddingBottom: CGFloat = 0,
                    paddingRight: CGFloat = 0,
                    width: CGFloat? = nil,
                    height: CGFloat? = nil) {
            translatesAutoresizingMaskIntoConstraints = false
            if let top = top {
                topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
            }
    
            if let left = left {
                leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
            }
        
            if let bottom = bottom {
                bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
            }
            
            if let right = right {
                rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
            }
            
            if let width = width {
                widthAnchor.constraint(equalToConstant: width).isActive = true
            }
            
            if let height = height {
                heightAnchor.constraint(equalToConstant: height).isActive = true
            }
        }
        
        func centerX(inView view: UIView) {
            centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        }
        
        func centerY(inView view: UIView) {
            centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        }
}
