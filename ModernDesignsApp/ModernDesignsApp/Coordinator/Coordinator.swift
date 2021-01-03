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
    
    func showImageViewer(for image: UIImage?) {
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "ImageViewerViewController") as! ImageViewerViewController
        vc.image = image
        navigationController.present(vc, animated: true, completion: nil)
    }
    
    func showFlexibleHeaderDemo() {
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "FlexibleHeaderDemoViewController") as! FlexibleHeaderDemoViewController
        navigationController.pushViewController(vc, animated: true)
    }
}
