//
//  ImageViewerTransitionManager.swift
//  ModernDesignsApp
//
//  Created by Stefano Sonzogni on 03/01/21.
//

import Foundation
import UIKit

enum TransitionType {
    case presenting
    case dismissing
    
    var animationDuration: TimeInterval { return 0.5 }
    var cornerRadius: CGFloat { return self == .presenting ? 0 : 8 }
    var dismissButtonAlpha: CGFloat { return self == .presenting ? 1 : 0 }
    var imageViewerBackgroundColor: UIColor { return self == .presenting ? .black : .white }
    
    var other: TransitionType { return self == .presenting ? .dismissing : .presenting }
}

class ImageViewerTransitionManager: NSObject {
    var transitionType: TransitionType?
}

extension ImageViewerTransitionManager: UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return self.transitionType?.animationDuration ?? 0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let transitionType = transitionType else { return }
        let containerView = transitionContext.containerView
        
        guard let demoViewController = (transitionType == .presenting ? transitionContext.viewController(forKey: .from) : transitionContext.viewController(forKey: .to))?.children.last as? ImageDetailsDemoViewController else { return }
        guard let imageViewerViewController = (transitionType == .presenting ? transitionContext.viewController(forKey: .to) : transitionContext.viewController(forKey: .from)) as? ImageViewerViewController else { return }
        
        let demoView = demoViewController.view as! ImageDetailsDemoView
        
        let demoFrame = demoView.imageView.convert(demoView.imageView.frame, to: nil)
        let imageViewerCopy = ImageViewerView(frame: transitionType == .presenting ? demoFrame : containerView.frame)
        imageViewerCopy.imageView.image = demoView.imageView.image
        imageViewerCopy.clipsToBounds = true
        imageViewerCopy.layer.cornerRadius = transitionType.other.cornerRadius
        imageViewerCopy.dismissButton.alpha = transitionType.other.dismissButtonAlpha
        imageViewerCopy.backgroundColor = transitionType.other.imageViewerBackgroundColor
        containerView.addSubview(imageViewerCopy)
        
        // ESSENTIAL!
        containerView.layoutIfNeeded()
        
        demoView.imageView.isHidden = true
        
        containerView.addSubview(imageViewerViewController.view)
        imageViewerViewController.view.addConstraintsToSuperview(topPadding: 0, leftPadding: 0, rightPadding: 0, bottomPadding: 0)
        imageViewerViewController.view.isHidden = true
        
        let animator = UIViewPropertyAnimator(duration: transitionType.animationDuration, dampingRatio: 0.75)
        animator.addAnimations {
            imageViewerCopy.layer.cornerRadius = transitionType.cornerRadius
            imageViewerCopy.frame = transitionType == .presenting ? containerView.frame : demoFrame
            imageViewerCopy.backgroundColor = transitionType.imageViewerBackgroundColor
            imageViewerCopy.dismissButton.alpha = transitionType.dismissButtonAlpha
        }
        animator.addCompletion { _ in
            imageViewerCopy.removeFromSuperview()
            imageViewerViewController.view.isHidden = false
            demoView.imageView.isHidden = false
            transitionContext.completeTransition(true)
        }
        animator.startAnimation()
    }
    
}
