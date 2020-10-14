//
//  UIView+Extensions.swift
//  iCol
//
//  Created by Windy on 13/10/20.
//

import UIKit

extension UIView {
 
    func setConstraint(topAnchor: NSLayoutAnchor<NSLayoutYAxisAnchor>? = nil, topAnchorConstant: CGFloat = 0,
                       bottomAnchor: NSLayoutAnchor<NSLayoutYAxisAnchor>? = nil, bottomAnchorConstant: CGFloat = 0,
                       leadingAnchor: NSLayoutAnchor<NSLayoutXAxisAnchor>? = nil, leadingAnchorConstant: CGFloat = 0,
                       trailingAnchor: NSLayoutAnchor<NSLayoutXAxisAnchor>? = nil, trailingAnchorConstant: CGFloat = 0,
                       centerXAnchor: NSLayoutAnchor<NSLayoutXAxisAnchor>? = nil, centerXAnchorConstant: CGFloat = 0,
                       centerYAnchor: NSLayoutAnchor<NSLayoutYAxisAnchor>? = nil, centerYAnchorConstant: CGFloat = 0,
                       heighAnchorConstant: CGFloat = 0, widthAnchorConstant: CGFloat = 0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let topAnchor = topAnchor {
            self.topAnchor.constraint(equalTo: topAnchor, constant: topAnchorConstant).isActive = true
        }
        
        if let bottomAnchor = bottomAnchor {
            self.bottomAnchor.constraint(equalTo: bottomAnchor, constant: bottomAnchorConstant).isActive = true
        }
        
        if let leadingAnchor = leadingAnchor {
            self.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leadingAnchorConstant).isActive = true
        }
        
        if let trailingAnchor = trailingAnchor {
            self.trailingAnchor.constraint(equalTo: trailingAnchor, constant: trailingAnchorConstant).isActive = true
        }
        
        if let centerXAnchor = centerXAnchor {
            self.centerXAnchor.constraint(equalTo: centerXAnchor, constant: centerXAnchorConstant).isActive = true
        }
        
        if let centerYAnchor = centerYAnchor {
            self.centerYAnchor.constraint(equalTo: centerYAnchor, constant: centerYAnchorConstant).isActive = true
        }
        
    }
    
    func addShadow(color: UIColor, opacity: Float, radius: CGFloat, offset: CGSize) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = radius
        self.layer.shadowOffset = offset
    }
    
    func addShadow(color: UIColor, opacity: Float, radius: CGFloat, offset: CGSize) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = radius
        self.layer.shadowOffset = offset
    }

}
