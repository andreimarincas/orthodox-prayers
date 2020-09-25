//
//  PrayerReadingTableViewController.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 09/09/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import UIKit

class PrayerReadingTableViewController: TableViewController {
    private var prayerTitle: String!
    private var parentPrayerTitle: String?
    private var section: String!
    
    private var dataSource: PrayerReadingTableDataSource!
    
    private var statusBarVisibleHeight: CGFloat = 0
    
    // MARK: Initialization
    
    convenience init(prayerTitle: String, parentPrayerTitle: String?, section: String) {
        self.init()
        self.prayerTitle = prayerTitle
        self.parentPrayerTitle = parentPrayerTitle
        self.section = section
    }
    
    // MARK: View life-cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = PrayerReadingTableDataSource(prayer: prayerTitle, parent: parentPrayerTitle, section: section)
        tableView.footerView = PrayerReadingFooter()
    }
    
    // MARK: TableViewDataSource
    
    override func numberOfRows(in tableView: TableView) -> Int {
        return dataSource.numberOfItems
    }
    
    override func tableView(_ tableView: TableView, cellForRowAt index: Int) -> UIView {
        let cell = PrayerReadingCell()
        cell.attributedString = dataSource.prayerItem(at: index)
        return cell
    }
    
    // MARK: UIScrollViewDelegate
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let navBarHidden = navigationController?.isNavigationBarHidden ?? false
        if navBarHidden && statusBarVisibleHeight > 0 {
            notifyStatusBarAppearanceUpdate(animation: .slide)
        }
    }
    
    // MARK: Status bar appearance update
    
    override func viewSafeAreaInsetsDidChange() {
        let navBarHidden = navigationController?.isNavigationBarHidden ?? false
        if navBarHidden && view.safeAreaInsets.top > 0 {
            statusBarVisibleHeight = view.safeAreaInsets.top
            notifyStatusBarAppearanceUpdate(animation: .fade)
        }
    }
    
    private func textOverlapsStatusBar() -> Bool {
        guard let firstCell = tableView.cells.first as? PrayerReadingCell else { return false }
        let cellFrameInView = view.convert(firstCell.frame, from: tableView)
        let textTopMargin = firstCell.dropCapTextView.textTopMargin
        return cellFrameInView.origin.y + textTopMargin < statusBarVisibleHeight
    }
    
    private func notifyStatusBarAppearanceUpdate(animation: UIStatusBarAnimation) {
        let hidden = textOverlapsStatusBar()
        let appearance = StatusBarAppearance(hidden: hidden, animation: animation)
        notifyStatusBarAppearanceUpdate(appearance: appearance)
    }
}
