//
//  Logs.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 23/08/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import Foundation

// Enable/disable logging.
private let loggingEnabled = true

func log(_ item: Any, filePath: String = #file, line: Int = #line, funcName: String = #function) {
    logMessage("\(funcName) -> \(item)", filePath: filePath, line: line)
}

func logMessage(_ item: Any, filePath: String = #file, line: Int = #line, funcName: String = #function) {
    logMessage("\(funcName) -> \(item)", filePath: filePath, line: line)
}

func logSuccess(_ item: Any, filePath: String = #file, line: Int = #line, funcName: String = #function) {
    logMessage("\(funcName) -> ✅ \(item)", filePath: filePath, line: line)
}

func logWarn(_ item: Any, filePath: String = #file, line: Int = #line, funcName: String = #function) {
    logMessage("\(funcName) -> ⚠️ \(item)", filePath: filePath, line: line)
}

func logError(_ item: Any, filePath: String = #file, line: Int = #line, funcName: String = #function) {
    logMessage("\(funcName) -> ❗ \(item)", filePath: filePath, line: line)
}

func logIN(_ filePath: String = #file, line: Int = #line, funcName: String = #function) {
    logMessage("\(funcName) -> IN", filePath: filePath, line: line)
}

func logOUT(_ filePath: String = #file, line: Int = #line, funcName: String = #function) {
    logMessage("\(funcName) -> OUT", filePath: filePath, line: line)
}

private func logMessage(_ text: String, filePath: String, line: Int) {
    guard loggingEnabled else { return }
    let timestamp = dateFormatter.string(from: Date())
    let filename = filePath.components(separatedBy: "/").last ?? ""
    print("\(timestamp) 🙏 [\(filename):\(line)] \(text)")
}

private var dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ssSSS"
    formatter.locale = Locale.current
    formatter.timeZone = TimeZone.current
    return formatter
}()
