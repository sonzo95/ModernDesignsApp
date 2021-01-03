//
//  ViewController.swift
//  ModernDesignsApp
//
//  Created by Stefano Sonzogni on 01/01/21.
//

import UIKit

class ContentTableViewController: UIViewController {
    
    enum Contents: Int, CaseIterable {
        case flexibleHeader = 0
        case customTransition
        
        var title: String {
            switch self {
            case Self.flexibleHeader:
                return "Flexible Header"
            case Self.customTransition:
                return "Custom Transition"
            }
        }
        
        func continueNavigation(coordinator: Coordinator?) {
            switch self {
            case Self.flexibleHeader:
                coordinator?.showFlexibleHeaderDemo()
            case Self.customTransition:
                coordinator?.showImageDetailsDemo()
            }
        }
    }

    @IBOutlet weak var tableView: UITableView!

    var coordinator: Coordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Demos"
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}

extension ContentTableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Contents(rawValue: indexPath.row)?.continueNavigation(coordinator: coordinator)
    }
    
}

extension ContentTableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Contents.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = Contents(rawValue: indexPath.row)?.title
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
}

