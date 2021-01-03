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
        
        let copyView = ImageViewerView(frame: (demoViewController.view as! ImageDetailsDemoView).imageView.convert((demoViewController.view as! ImageDetailsDemoView).imageView.frame, to: nil))
        copyView.imageView.image = (demoViewController.view as! ImageDetailsDemoView).imageView.image
        let blurView = makeBlurView()
        
        containerView.addSubview(blurView)
        blurView.addConstraintsToSuperview(topPadding: 0, leftPadding: 0, rightPadding: 0, bottomPadding: 0)
        blurView.contentView.addSubview(copyView)
        
        transitionContext.completeTransition(true)
    }
    
    private func makeBlurView() -> UIVisualEffectView {
        let blur = UIBlurEffect(style: .regular)
        let view = UIVisualEffectView(effect: blur)
        return view
    }
    
    
}
