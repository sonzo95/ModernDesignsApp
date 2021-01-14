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
        case selfSizingTableView
        
        var title: String {
            switch self {
            case .flexibleHeader:
                return "Flexible Header"
            case .customTransition:
                return "Custom Transition"
            case .selfSizingTableView:
                return "Self Sizing Table View"
            }
        }
        
        func continueNavigation(coordinator: Coordinator?) {
            switch self {
            case .flexibleHeader:
                coordinator?.showFlexibleHeaderDemo()
            case .customTransition:
                coordinator?.showImageDetailsDemo()
            case .selfSizingTableView:
                coordinator?.showSelfSizingTableDemo()
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

