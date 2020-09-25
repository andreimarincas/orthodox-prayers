//
//  BackBarButtonItem.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 19/09/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import UIKit

//extension UIAction {
//    convenience init(title: String, handler: @escaping UIActionHandler) {
//        self.init(title: title, image: nil, identifier: nil, discoverabilityTitle: nil, attributes: [], state: .off, handler: handler)
//    }
//}

class BackBarButtonItem: UIBarButtonItem {
//    var menuAction: UIAction!
//
//    convenience init(title: String, menuTitle: String, menuHandler: @escaping UIActionHandler) {
//        self.init(title: title, style: .plain, target: nil, action: nil)
//        menuAction = UIAction(title: menuTitle, handler: menuHandler)
//    }
    
    var menuTitle: String?
    
    convenience init(title: String, menuTitle: String) {
        self.init(title: title, style: .plain, target: nil, action: nil)
        self.menuTitle = menuTitle
    }
    
    @available(iOS 14.0, *)
    override var menu: UIMenu? {
        set {
//            super.menu = newValue?.replacingChildren([menuAction])
            
            if newValue?.children.last?.title == menuTitle {
                super.menu = newValue
            }
            
//            if newValue?.children.last == menuAction {
//                super.menu = newValue
//            }
            
//            if let menu = newValue {
//                var children = menu.children
////                _ = children.popLast()
//                children.append(menuAction)
//                super.menu = menu.replacingChildren(children)
//            } else {
//                super.menu = nil
//            }
            
//            guard let menu = newValue else { return }
//            var children = menu.children
//            _ = children.popLast()
//            children.append(menuAction)
            
            
            
            //super.menu = newValue
            
//            var items = newValue?.children ?? []
//            _ = items.popLast()
//            let newMenu = UIMenu(title: "", image: nil, identifier: nil, options: [], children: items)
//            super.menu = newMenu
            
//            if let menu = newValue {
                
                
//                let action = UIAction(title: "sasfdsngd") { _ in
//                    log("hey, menu!")
//                }
//                let action = UIAction(title: "Rugăciuni", image: nil, identifier: nil, discoverabilityTitle: nil, attributes: [], state: .off) { action in
////                    guard let weakSelf = self else { return }
//                    log("hey, menu!")
//                }
                
//                items.append(action)
                
//                let save = UIAction(__title: "Save", image: ni, identifier: nil) { action in
//                            // whatever
//                        }
//                let item = UIMenuItem(title: "Rugăciuni", action: #selector(didTapMenuItem))
//                items[items.count - 1] =
//                let last = items.popLast()!
                
//                log(items)
                
//                let newMenu = UIMenu(title: "", image: nil, identifier: nil, options: [], children: items)
//                super.menu = newMenu
                
//                super.menu = menu
                //return UIMenu(_title: "Menu", image: nil, identifier: nil, children:[save, edit])
//            }
        }
        get {
            return super.menu
        }
    }
}
