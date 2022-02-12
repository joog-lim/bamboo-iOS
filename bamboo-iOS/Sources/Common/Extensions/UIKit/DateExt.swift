//
//  DateExt.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/12/28.
//

import Foundation
extension Date{
    func usingDate(time : String) -> String{
        let iso8601DateFormatter = ISO8601DateFormatter()
        iso8601DateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        let date = iso8601DateFormatter.date(from: time)
        let dataFormatter = DateFormatter()
        dataFormatter.dateFormat = "yyyy-MM-dd a"
        return dataFormatter.string(from: date!)
    }
}
