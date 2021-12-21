//
//  OSLogEx.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/12/21.
//

import OSLog

extension OSLog{
    private static var subsystem = Bundle.main.bundleIdentifier!
    static let ui = OSLog(subsystem: subsystem, category: "UI")
    static let data = OSLog(subsystem: subsystem, category: "Data")
}
