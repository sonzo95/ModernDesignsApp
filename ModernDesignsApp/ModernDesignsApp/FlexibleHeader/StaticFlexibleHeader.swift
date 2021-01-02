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
    
    private lazy var blurView: UIVisualEffectView = {
        return UIVisualEffectView(effect: nil)
    }()
    
    private lazy var blurAnimator: UIViewPropertyAnimator = {
        let animator = UIViewPropertyAnimator(duration: 1, curve: .easeIn)
        animator.addAnimations {
            self.blurView.effect = UIBlurEffect(style: .regular)
        }
        animator.fractionComplete = 0
        return animator
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
        self.clipsToBounds = true
        blurView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        imageView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        addSubview(imageView)
        imageView.addSubview(blurView)
    }
    
    func frameDidSet() {
        blurAnimator.fractionComplete = 1 - ((frame.height - minimumHeight) / (maximumHeight - minimumHeight))
    }
    
}
