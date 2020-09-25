//
//  UIImage+Extension.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 15/09/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import UIKit

extension UIImage {
    static func withColor(_ color: UIColor) -> UIImage {
        let rect = CGRect(origin: .zero, size: CGSize(width: 1, height: 1))
        UIGraphicsBeginImageContext(rect.size)
        //UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        guard let context = UIGraphicsGetCurrentContext() else { return UIImage() }
        context.setFillColor(color.cgColor)
//        context.setFillColor(red: 1, green: 0, blue: 0, alpha: 0)
        context.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image ?? UIImage()
    }
}
