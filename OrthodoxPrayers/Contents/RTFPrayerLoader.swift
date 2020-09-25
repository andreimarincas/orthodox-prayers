//
//  RTFPrayerLoader.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 11/09/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import Foundation

class RTFPrayerLoader {
    static let rtfPrayersDirectory = "Prayers"
    
    func loadPrayerFromRtf(fileNamed prayerFileName: String, parent: String?) -> NSAttributedString? {
        var subdir: String!
        if let parent = parent {
            subdir = RTFPrayerLoader.rtfPrayersDirectory + "/" + parent
        } else {
            subdir = RTFPrayerLoader.rtfPrayersDirectory
        }
        guard let url = Bundle.main.url(forResource: prayerFileName, withExtension: "rtf", subdirectory: subdir) else {
            logError("Resource not found: \(prayerFileName)")
            return nil
        }
        do {
            let data = try Data(contentsOf: url)
            let rtf = NSAttributedString.DocumentType.rtf
            let options: [NSAttributedString.DocumentReadingOptionKey : Any] = [.documentType: rtf]
            let attrStr = try NSAttributedString(data: data, options: options, documentAttributes: nil)
            return attrStr
        } catch {
            fatalError("Unresolved error: \(error)") // TODO: Handle error
        }
    }
}
