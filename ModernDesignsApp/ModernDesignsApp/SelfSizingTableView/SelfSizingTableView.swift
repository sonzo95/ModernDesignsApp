//
//  SelfSizingTableView.swift
//  ModernDesignsApp
//
//  Created by Stefano Sonzogni on 14/01/21.
//

import Foundation
import UIKit

class SelfSizingTableView: UITableView {
    
    enum SelfSizingTableViewAxis {
        case none
        case horizontal
        case vertical
        case horizontalVertical
    }
    
    var defaultIntrinsicHeight: CGFloat = 100
    var defaultIntrinsicWidth: CGFloat = 100
    var selfSizingAxis: SelfSizingTableViewAxis = .none
    
    override var intrinsicContentSize: CGSize {
        setNeedsLayout()
        layoutIfNeeded()
        switch selfSizingAxis {
        case .none:
            return super.intrinsicContentSize
        case .horizontal:
            return CGSize(width: contentSize.width, height: defaultIntrinsicHeight)
        case .vertical:
            return CGSize(width: defaultIntrinsicWidth, height: contentSize.height)
        case .horizontalVertical:
            return CGSize(width: contentSize.width, height: contentSize.height)
        }
    }
    
    override func reloadData() {
        super.reloadData()
        invalidateIntrinsicContentSize()
        layoutIfNeeded()
    }
    
}
