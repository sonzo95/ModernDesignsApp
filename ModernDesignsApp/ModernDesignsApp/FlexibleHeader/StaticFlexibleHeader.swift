//
//  StaticFlexibleHeader.swift
//  ModernDesignsApp
//
//  Created by Stefano Sonzogni on 01/01/21.
//

import Foundation
import UIKit

class StaticFlexibleHeader: UIView, FlexibleHeader {
    var minimumHeight: CGFloat { 50 }
    var maximumHeight: CGFloat { 300 }
    
    var imageName = "headerImage"
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: imageName)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    func setupView() {
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.leftAnchor.constraint(equalTo: self.leftAnchor),
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            self.rightAnchor.constraint(equalTo: imageView.rightAnchor),
            self.bottomAnchor.constraint(equalTo: imageView.bottomAnchor)
        ])
    }
    
    func frameDidSet() {
        
    }
    
}
