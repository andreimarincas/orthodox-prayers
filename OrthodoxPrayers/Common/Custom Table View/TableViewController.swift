//
//  TableViewController.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 13/09/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, TableViewDataSource {
    private(set) var tableView: TableView!
    
    // MARK: View life-cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if tableView.isEmpty {
            tableView.reloadData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.flashScrollIndicators()
    }
    
    // MARK: Configure methods
    
    private func configureTableView() {
        tableView = TableView()
        tableView.dataSource = self
        view.addSubviewAligned(tableView)
    }
    
    // MARK: TableViewDataSource
    
    func numberOfRows(in tableView: TableView) -> Int {
        return 0
    }
    
    func tableView(_ tableView: TableView, cellForRowAt index: Int) -> UIView {
        return UIView()
    }
}
