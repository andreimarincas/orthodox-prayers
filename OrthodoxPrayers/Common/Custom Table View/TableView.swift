//
//  TableView.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 13/09/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import UIKit

protocol TableViewDataSource: class {
    func numberOfRows(in tableView: TableView) -> Int
    func tableView(_ tableView: TableView, cellForRowAt index: Int) -> UIView
}

class TableView: UIScrollView {
    private var layoutManager: TableViewLayoutManager!
    weak var dataSource: TableViewDataSource?
    
    // MARK: Initialization
    
    convenience init() {
        self.init(frame: .zero)
        layoutManager = TableViewLayoutManager(tableView: self)
        backgroundColor = .clear
        showsHorizontalScrollIndicator = false
        contentInsetAdjustmentBehavior = .never
        automaticallyAdjustsScrollIndicatorInsets = false
        alwaysBounceVertical = true
    }
    
    // MARK: Cells management
    
    private(set) var cells = [UIView]() {
        didSet {
            for oldCell in oldValue {
                oldCell.removeFromSuperview()
            }
            for newCell in cells {
                addSubview(newCell)
            }
        }
    }
    
    func reloadData() {
        guard let dataSource = self.dataSource else {
            cells = []
            return
        }
        var newCells = [UIView]()
        let numberOfRows = dataSource.numberOfRows(in: self)
        for index in 0..<numberOfRows {
            let newCell = dataSource.tableView(self, cellForRowAt: index)
            newCells.append(newCell)
        }
        cells = newCells
        layoutManager.setNeedsLayout()
    }
    
    var isEmpty: Bool {
        return cells.isEmpty
    }
    
    var footerView: UIView? {
        didSet {
            oldValue?.removeFromSuperview()
            if let footer = footerView {
                addSubview(footer)
            }
            layoutManager.setNeedsLayout()
        }
    }
    
    // MARK: Layout updates
    
    override var contentSize: CGSize {
        didSet {
            if contentSize != oldValue {
                layoutManager.contentSizeDidChange()
            }
        }
    }
    
    override func safeAreaInsetsDidChange() {
        layoutManager.safeAreaInsetsDidChange()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutManager.layoutSubviews()
    }
    
    // MARK: Vertical offset
    
    var verticalContentOffset: (row: Int, percent: CGFloat)? {
        for index in 0..<cells.count {
            let cellFrame = cells[index].frame
            let adjustedBounds = bounds.offsetBy(dx: 0, dy: contentInset.top)
            if cellFrame.intersects(adjustedBounds) {
                let rect = cellFrame.intersection(adjustedBounds)
                let offset = rect.origin.y - cellFrame.origin.y
                let percent = offset / cellFrame.height
                return (index, percent)
            }
        }
        return nil
    }
    
    func scrollToRow(at index: Int, percent: CGFloat) {
        let cellFrame = cells[index].frame
        let offsetY = cellFrame.origin.y + percent * cellFrame.height
        let cappedOffsetY = min(offsetY, maximumContentOffset.y)
        contentOffset = CGPoint(x: 0, y: cappedOffsetY - contentInset.top)
    }
}
