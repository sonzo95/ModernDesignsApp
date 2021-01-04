//
//  ImageViewerTransitionManager.swift
//  ModernDesignsApp
//
//  Created by Stefano Sonzogni on 03/01/21.
//

import Foundation
import UIKit

fileprivate enum TransitionType {
    case presenting
    case dismissing
    
    var animationDuration: TimeInterval { return 0.5 }
}

class ImageViewerTransitionManager: NSObject {
    private var transitionType: TransitionType?
}

extension ImageViewerTransitionManager: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.transitionType = .presenting
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.transitionType = .dismissing
        return self
    }
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
        
        let imageViewerCopy = ImageViewerView(frame: demoView.imageView.convert(demoView.imageView.frame, to: nil))
        imageViewerCopy.imageView.image = demoView.imageView.image
        imageViewerCopy.layer.cornerRadius = 8
        imageViewerCopy.clipsToBounds = true
        imageViewerCopy.dismissButton.alpha = 0
        imageViewerCopy.backgroundColor = .white
        containerView.addSubview(imageViewerCopy)
        
        // ESSENTIAL!
        containerView.layoutIfNeeded()
        
        demoView.imageView.isHidden = true
        
        containerView.addSubview(imageViewerViewController.view)
        imageViewerViewController.view.addConstraintsToSuperview(topPadding: 0, leftPadding: 0, rightPadding: 0, bottomPadding: 0)
        imageViewerViewController.view.isHidden = true
        
        let animator = UIViewPropertyAnimator(duration: transitionType.animationDuration, dampingRatio: 0.75)
        animator.addAnimations {
            imageViewerCopy.layer.cornerRadius = 0
            imageViewerCopy.frame = containerView.frame
            imageViewerCopy.backgroundColor = .black
            imageViewerCopy.dismissButton.tintColor = .white
            imageViewerCopy.dismissButton.alpha = 1
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
