//
//  ImageViewerViewController.swift
//  ModernDesignsApp
//
//  Created by Stefano Sonzogni on 02/01/21.
//

import UIKit

class ImageViewerView: UIView {
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var dismissButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "icon-close"), for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
        self.backgroundColor = .black
        self.addSubview(imageView)
        self.addSubview(dismissButton)
        
        NSLayoutConstraint.activate([
            // image
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.rightAnchor.constraint(equalTo: imageView.rightAnchor),
            self.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
            
            // dismiss button
            dismissButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16),
            self.safeAreaLayoutGuide.rightAnchor.constraint(equalTo: dismissButton.rightAnchor, constant: 16),
            dismissButton.heightAnchor.constraint(equalToConstant: 24),
            dismissButton.widthAnchor.constraint(equalToConstant: 24)
        ])
    }
    
}

class ImageViewerViewController: UIViewController {

    var image: UIImage?
    var coordinator: Coordinator?
    private let animator = ImageViewerTransitionManager()
    
    override func loadView() {
        super.loadView()
        
        self.view = ImageViewerView()
        self.transitioningDelegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let view = self.view as? ImageViewerView else { return }
        view.imageView.image = image
        view.dismissButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(closeDidTap(_:))))
    }
    
    @objc private func closeDidTap(_ sender: UITapGestureRecognizer) {
        coordinator?.dismissImageViewer()
    }

}

extension ImageViewerViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        animator.transitionType = .presenting
        return animator
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        animator.transitionType = .dismissing
        return animator
    }
}
