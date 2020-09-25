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
    
    // MARK: Initialization
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View life-cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        configureTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.flashScrollIndicators()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        adjustContentInset()
    }
    
    // MARK: Private methods
    
    private func configureTableView() {
        tableView = TableView()
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.automaticallyAdjustsScrollIndicatorInsets = false
        tableView.alwaysBounceVertical = true
        tableView.dataSource = self
        view.addSubviewAligned(tableView)
    }
    
    private func adjustContentInset() {
        var inset = UIEdgeInsets.zero
        inset.top = navBarHeight + statusBarHeight
        inset.bottom = tabBarHeight
        tableView.contentInset = inset
        tableView.verticalScrollIndicatorInsets = inset
    }
    
    // MARK: TableViewDataSource
    
    func numberOfRows(in tableView: TableView) -> Int {
        return 0
    }
    
    func tableView(_ tableView: TableView, cellForRowAt index: Int) -> UIView {
        return UIView()
    }
}
