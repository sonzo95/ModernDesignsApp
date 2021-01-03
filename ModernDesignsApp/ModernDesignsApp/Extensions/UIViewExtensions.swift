//
//  UIViewExtensions.swift
//  ModernDesignsApp
//
//  Created by Stefano Sonzogni on 03/01/21.
//

import UIKit

extension UIView {
    
    func addConstraintsToSuperview(topPadding: CGFloat? = nil,
                                   leftPadding: CGFloat? = nil,
                                   rightPadding: CGFloat? = nil,
                                   bottomPadding: CGFloat? = nil,
                                   height: CGFloat? = nil,
                                   width: CGFloat? = nil) {
        guard let superview = superview else { return }
        
        self.translatesAutoresizingMaskIntoConstraints = false
        var constraints = [NSLayoutConstraint]()
        
        if let topPadding = topPadding {
            constraints.append(self.topAnchor.constraint(equalTo: superview.topAnchor, constant: topPadding))
        }
        if let leftPadding = leftPadding {
            constraints.append(self.leftAnchor.constraint(equalTo: superview.leftAnchor, constant: leftPadding))
        }
        if let rightPadding = rightPadding {
            constraints.append(superview.rightAnchor.constraint(equalTo: self.rightAnchor, constant: rightPadding))
        }
        if let bottomPadding = bottomPadding {
            constraints.append(superview.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: bottomPadding))
        }
        if let height = height {
            constraints.append(self.heightAnchor.constraint(equalToConstant: height))
        }
        if let width = width {
            constraints.append(self.widthAnchor.constraint(equalToConstant: width))
        }
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func addConstraintsToSafeArea(topPadding: CGFloat? = nil,
                                  leftPadding: CGFloat? = nil,
                                  rightPadding: CGFloat? = nil,
                                  bottomPadding: CGFloat? = nil,
                                  height: CGFloat? = nil,
                                  width: CGFloat? = nil) {
        guard let superview = superview else { return }
        
        self.translatesAutoresizingMaskIntoConstraints = false
        var constraints = [NSLayoutConstraint]()
        
        if let topPadding = topPadding {
            constraints.append(self.topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor, constant: topPadding))
        }
        if let leftPadding = leftPadding {
            constraints.append(self.leftAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.leftAnchor, constant: leftPadding))
        }
        if let rightPadding = rightPadding {
            constraints.append(superview.safeAreaLayoutGuide.rightAnchor.constraint(equalTo: self.rightAnchor, constant: rightPadding))
        }
        if let bottomPadding = bottomPadding {
            constraints.append(superview.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: bottomPadding))
        }
        if let height = height {
            constraints.append(self.heightAnchor.constraint(equalToConstant: height))
        }
        if let width = width {
            constraints.append(self.widthAnchor.constraint(equalToConstant: width))
        }
        
        NSLayoutConstraint.activate(constraints)
    }
    
}
