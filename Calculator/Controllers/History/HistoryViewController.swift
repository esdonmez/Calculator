//
//  HistoryViewController.swift
//  Calculator
//
//  Created by Onur Celik on 10/10/2017.
//  Copyright © 2017 Onur Celik. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var historyUITableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.historyUITableView.dataSource = self
        self.historyUITableView.delegate = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return MainViewController.historyTextArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell()
        cell.textLabel?.text = MainViewController.historyTextArray[indexPath.row]
        
        return cell
    }
    
    @IBAction func backUIBarButtonItem(_ sender: Any) {
        dismiss(animated: true) {
            
        }
    }
}
