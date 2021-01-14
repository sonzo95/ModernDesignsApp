//
//  Coordinator.swift
//  ModernDesignsApp
//
//  Created by Stefano Sonzogni on 02/01/21.
//

import Foundation
import UIKit

class Coordinator {
    
    private let navigationController: UINavigationController
    private let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func showImageDetailsDemo() {
        let vc = ImageDetailsDemoViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showImageViewer(for image: UIImage?, animatorDataSource: ImageViewerAnimatedTransitioningDataSource?) {
        let vc = ImageViewerViewController()
        vc.image = image
        vc.coordinator = self
        if let animatorDataSource = animatorDataSource {
            vc.transitioningDelegate = vc
            vc.modalPresentationStyle = .custom
            vc.animator.dataSource = animatorDataSource
        }
        navigationController.present(vc, animated: true, completion: nil)
    }
    
    func dismissImageViewer() {
        navigationController.dismiss(animated: true, completion: nil)
    }
    
    func showFlexibleHeaderDemo() {
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "FlexibleHeaderDemoViewController") as! FlexibleHeaderDemoViewController
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showSelfSizingTableDemo() {
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "SelfSizingTableDemoViewController") as! SelfSizingTableDemoViewController
        navigationController.pushViewController(vc, animated: true)
    }
}
