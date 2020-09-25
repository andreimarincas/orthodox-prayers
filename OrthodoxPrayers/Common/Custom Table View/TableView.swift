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
    weak var dataSource: TableViewDataSource?
    
    // MARK: Initialization
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .clear
        showsHorizontalScrollIndicator = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Cells reloading
    
    private var cells = [UIView]() {
        didSet {
            for oldCell in oldValue {
                oldCell.removeFromSuperview()
            }
            for newCell in cells {
                addSubview(newCell)
            }
            needsLayoutUpdate = true
            setNeedsLayout()
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
    }
    
    // MARK: Layout updates
    
    /// True when the cells are modified or when the view's width changes.
    /// If true, cells' frames and contentSize are calculated in layoutSubviews(). If false, layoutSubviews() does nothing.
    private var needsLayoutUpdate = false
    
    private var width: CGFloat = 0 {
        didSet {
            if width != oldValue {
                needsLayoutUpdate = true
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        width = frame.width
        guard needsLayoutUpdate else { return }
        var y: CGFloat = 0
        for cell in cells {
            let size = cell.sizeThatFits(CGSize(width: frame.width, height: -1))
            cell.frame = CGRect(x: 0, y: y, width: frame.width, height: size.height)
            y += size.height
        }
        contentSize = CGSize(width: frame.width, height: y)
        needsLayoutUpdate = false
    }
}
