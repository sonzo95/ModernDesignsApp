//
//  FlexibleHeaderView.swift
//  ModernDesignsApp
//
//  Created by Stefano Sonzogni on 01/01/21.
//

import Foundation
import UIKit

protocol FlexibleHeader {
    
    var minimumHeight: CGFloat { get }
    var maximumHeight: CGFloat { get }
    
    func frameWillSet(_ newFrame: CGRect) -> CGRect
    func frameDidSet()
    
}

extension FlexibleHeader {
    
    func frameWillSet(_ newFrame: CGRect) -> CGRect {
        let newHeight: CGFloat
        if newFrame.height < minimumHeight {
            newHeight = minimumHeight
        }
        else if newFrame.height > maximumHeight {
            newHeight = maximumHeight
        }
        else {
            newHeight = newFrame.height
        }
        return CGRect(x: newFrame.minX, y: newFrame.minY, width: newFrame.width, height: newHeight)
    }
    
}
