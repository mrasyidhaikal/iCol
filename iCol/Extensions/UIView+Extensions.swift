//
//  UIView+Extensions.swift
//  iCol
//
//  Created by Windy on 13/10/20.
//

import UIKit

extension UIView {
 
    func setConstraint(topAnchor: NSLayoutAnchor<NSLayoutYAxisAnchor>?, topAnchorConstant: CGFloat = 0,
                       bottomAnchor: NSLayoutAnchor<NSLayoutYAxisAnchor>?, bottomAnchorConstant: CGFloat = 0,
                       leadingAnchor: NSLayoutAnchor<NSLayoutXAxisAnchor>?, leadingAnchorConstant: CGFloat = 0,
                       trailingAnchor: NSLayoutAnchor<NSLayoutXAxisAnchor>?, trailingAnchorConstant: CGFloat = 0,
                       centerXAnchor: NSLayoutAnchor<NSLayoutXAxisAnchor>?, centerXAnchorConstant: CGFloat = 0,
                       centerYAnchor: NSLayoutAnchor<NSLayoutYAxisAnchor>?, centerYAnchorConstant: CGFloat = 0) {
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

}
