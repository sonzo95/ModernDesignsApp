//
//  ViewController.swift
//  ModernDesignsApp
//
//  Created by Stefano Sonzogni on 01/01/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var coordinator: Coordinator?
    
    private lazy var staticHeaderView: StaticFlexibleHeader = {
        let header = StaticFlexibleHeader()
        header.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(headerDidTap(_:))))
        return header
    }()
    
    private var isInit = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Title"
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset = UIEdgeInsets(top: staticHeaderView.maximumHeight, left: 0, bottom: 0, right: 0)
        
        tableView.addSubview(staticHeaderView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if !isInit {
            staticHeaderView.frame = CGRect(x: 0, y: -staticHeaderView.maximumHeight, width: tableView.frame.width, height: staticHeaderView.maximumHeight)
            isInit = true
        }
    }
    
    @objc private func headerDidTap(_ sender: UITapGestureRecognizer) {
        coordinator?.showImageViewer(for: staticHeaderView.getImage())
    }

}

extension ViewController: UITableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        
        let newFrame = CGRect(x: 0, y: offsetY, width: scrollView.frame.width, height: -offsetY < staticHeaderView.minimumHeight ? staticHeaderView.minimumHeight : -offsetY)
        staticHeaderView.frame = newFrame
        staticHeaderView.frameDidSet()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let oppositeY = -scrollView.contentOffset.y
        if !decelerate,
            oppositeY > staticHeaderView.minimumHeight,
            oppositeY < staticHeaderView.maximumHeight {
            let heightFraction = (oppositeY - staticHeaderView.minimumHeight) / (staticHeaderView.maximumHeight - staticHeaderView.minimumHeight)
            let animator = UIViewPropertyAnimator(duration: 0.3, curve: .easeOut)
            animator.addAnimations {
                self.tableView.setContentOffset(CGPoint(x: 0, y: heightFraction < 0.5 ? -self.staticHeaderView.minimumHeight : -self.staticHeaderView.maximumHeight), animated: false)
            }
            animator.fractionComplete = heightFraction < 0.5 ? 1 - heightFraction : heightFraction
            animator.startAnimation()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let oppositeY = -scrollView.contentOffset.y
        if oppositeY > staticHeaderView.minimumHeight,
            oppositeY < staticHeaderView.maximumHeight {
            let heightFraction = (oppositeY - staticHeaderView.minimumHeight) / (staticHeaderView.maximumHeight - staticHeaderView.minimumHeight)
            let animator = UIViewPropertyAnimator(duration: 0.3, curve: .easeOut)
            animator.addAnimations {
                self.tableView.setContentOffset(CGPoint(x: 0, y: heightFraction < 0.5 ? -self.staticHeaderView.minimumHeight : -self.staticHeaderView.maximumHeight), animated: false)
            }
            animator.fractionComplete = heightFraction < 0.5 ? 1 - heightFraction : heightFraction
            animator.startAnimation()
        }
    }
    
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Yay"
        return cell
    }
    
}

