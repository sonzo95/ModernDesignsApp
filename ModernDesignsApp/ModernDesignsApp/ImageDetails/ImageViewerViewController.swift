//
//  ImageViewerViewController.swift
//  ModernDesignsApp
//
//  Created by Stefano Sonzogni on 02/01/21.
//

import UIKit

class ImageViewerViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    var image: UIImage?
    
    private lazy var dismissButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "icon-close"), for: .normal)
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(closeDidTap(_:))))
        button.tintColor = .black
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        
        view.addSubview(dismissButton)
        NSLayoutConstraint.activate([
            dismissButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            view.safeAreaLayoutGuide.rightAnchor.constraint(equalTo: dismissButton.rightAnchor, constant: 16),
            dismissButton.heightAnchor.constraint(equalToConstant: 24),
            dismissButton.widthAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    @objc private func closeDidTap(_ sender: UITapGestureRecognizer) {
        
    }

}
