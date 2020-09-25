//
//  TableViewLayoutManager.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 21/09/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import UIKit

class TableViewLayoutManager {
    private weak var tableView: TableView!
    private var needsLayout = false
    private var lastWidth: CGFloat = 0
    
    let setContentInsetDuration = UINavigationController.hideShowBarDuration
    
    init(tableView: TableView) {
        self.tableView = tableView
    }
    
    func setNeedsLayout() {
        needsLayout = true
        tableView.setNeedsLayout()
    }
    
    var frame: CGRect {
        return tableView.frame
    }
    
    // MARK: Content size & inset
    
    var contentSize: CGSize {
        return tableView.contentSize
    }
    
    var contentInset: UIEdgeInsets {
        return tableView.contentInset
    }
    
    var contentOffset: CGPoint {
        return tableView.contentOffset
    }
    
    func setContentInset(_ inset: UIEdgeInsets, animated: Bool) {
        let contentScrolledToTop = (contentOffset.y == -contentInset.top)
        let duration = animated ? TimeInterval(setContentInsetDuration) : 0
        UIView.animate(withDuration: duration) {
            self.tableView.contentInset = inset
            self.tableView.scrollIndicatorInsets = inset
            if contentScrolledToTop {
                self.tableView.contentOffset = CGPoint(x: 0, y: -inset.top)
            }
        }
    }
    
    func contentSizeDidChange() {
        adjustContentInset(animated: false)
    }
    
    // MARK: Safe area size & insets
    
    var safeAreaSize: CGSize {
        return tableView.safeAreaSize
    }
    
    var safeAreaInsets: UIEdgeInsets {
        return tableView.safeAreaInsets
    }
    
    func safeAreaInsetsDidChange() {
        adjustContentInset(animated: true)
    }
    
    // MARK: Layout calculations
    
    func layoutSubviews() {
        guard needsLayout || (frame.width != lastWidth) else { return }
        var y: CGFloat = 0
        // Layout cells
        for cell in tableView.cells {
            let cellSize = cell.sizeThatFits(CGSize(width: frame.width, height: -1))
            cell.frame = CGRect(x: 0, y: y, width: frame.width, height: cellSize.height)
            y += cellSize.height
        }
        // Layout footer view
        if let footer = tableView.footerView {
            let footerSize = footer.sizeThatFits(CGSize(width: frame.width, height: -1))
            footer.frame = CGRect(x: 0, y: y, width: frame.width, height: footerSize.height)
            y += footerSize.height
        }
        tableView.contentSize = CGSize(width: frame.width, height: y)
        needsLayout = false
        lastWidth = frame.width
    }
    
    private func adjustContentInset(animated: Bool) {
        guard contentSize != .zero else {
            setContentInset(.zero, animated: false)
            return
        }
        if contentSize.height < safeAreaSize.height {
            var inset = safeAreaInsets
            inset.top += (safeAreaSize.height - contentSize.height) / 2
            setContentInset(inset, animated: animated)
            // Pin footer to the bottom
            if let footer = tableView.footerView {
                let adjustedContentHeight = frame.height - inset.top - inset.bottom
                let y = adjustedContentHeight - footer.frame.height
                footer.frame = CGRect(x: 0, y: y, width: frame.width, height: footer.frame.height)
            }
        } else {
            setContentInset(safeAreaInsets, animated: animated)
        }
    }
}
