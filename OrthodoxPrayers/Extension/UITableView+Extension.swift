//
//  UITableView+Extension.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 20/09/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import UIKit

extension UITableView {
    func reloadDataAnimated(numberOfSections sectionsCount: Int, previousNumberOfSections prevSectionsCount: Int) {
        var sectionsToInsert = IndexSet()
        var sectionsToDelete = IndexSet()
        var sectionsToReload = IndexSet()
        if prevSectionsCount < sectionsCount {
            sectionsToInsert = IndexSet(integersIn: prevSectionsCount..<sectionsCount)
        } else if prevSectionsCount > sectionsCount {
            sectionsToDelete = IndexSet(integersIn: sectionsCount..<prevSectionsCount)
        }
        if prevSectionsCount > 0 && sectionsCount > 0 {
            sectionsToReload = IndexSet(integersIn: 0..<min(prevSectionsCount, sectionsCount))
        }
        performBatchUpdates({
            insertSections(sectionsToInsert, with: .fade)
            deleteSections(sectionsToDelete, with: .fade)
            reloadSections(sectionsToReload, with: .fade)
        })
        hideVerticalScrollIndicator()
    }
}
