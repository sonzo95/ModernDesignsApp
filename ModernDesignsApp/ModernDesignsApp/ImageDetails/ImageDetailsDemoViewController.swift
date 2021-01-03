//
//  ImageDetailsDemoViewController.swift
//  ModernDesignsApp
//
//  Created by Stefano Sonzogni on 03/01/21.
//

import UIKit

class ImageDetailsDemoView: UIView {
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    lazy var shadowView: UIView = {
        let view = UIView()
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.layer.shadowRadius = 8
        view.layer.shadowOpacity = 0.5
        return view
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
        self.backgroundColor = .white
        
        addSubview(shadowView)
        shadowView.addConstraintsToSafeArea(topPadding: 16, leftPadding: 16, rightPadding: 16)
        shadowView.heightAnchor.constraint(equalTo: shadowView.widthAnchor).isActive = true
        
        shadowView.addSubview(imageView)
        imageView.addConstraintsToSuperview(topPadding: 0, leftPadding: 0, rightPadding: 0, bottomPadding: 0)
    }
    
}

class ImageDetailsDemoViewController: UIViewController {

    var coordinator: Coordinator?
    
    override func loadView() {
        super.loadView()
        view = ImageDetailsDemoView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Image Details"

        (view as! ImageDetailsDemoView).imageView.image = UIImage(named: "headerImage")
        (view as! ImageDetailsDemoView).imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageDidTap(_:))))
    }

    @objc private func imageDidTap(_ sender: UITapGestureRecognizer) {
        coordinator?.showImageViewer(for: (view as! ImageDetailsDemoView).imageView.image)
    }

}
