//
//  SelfSizingTableDemoViewController.swift
//  ModernDesignsApp
//
//  Created by Stefano Sonzogni on 14/01/21.
//

import Foundation
import UIKit

class SelfSizingTableDemoViewController: UIViewController {
    
    @IBOutlet weak var tableView: SelfSizingTableView!
    @IBOutlet weak var removeButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    
    private var rows = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.selfSizingAxis = .vertical
        tableView.layer.cornerRadius = 12
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    @IBAction func removeButtonDidTap(_ sender: Any) {
        rows.removeLast()
        UIView.animate(withDuration: 0.2) {
            self.tableView.reloadData()
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func addButtonDidTap(_ sender: Any) {
        rows.append("Option \(rows.count + 1)")
        UIView.animate(withDuration: 0.2) {
            self.tableView.reloadData()
            self.view.layoutIfNeeded()
        }
    }
}

extension SelfSizingTableDemoViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = rows[indexPath.row]
        return cell
    }
}
