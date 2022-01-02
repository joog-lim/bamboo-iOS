//
//  DateExt.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/12/28.
//

import Foundation
extension Date{
    func usingDate(timeStamp : Int) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일 a"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        return dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(Double(timeStamp/1000))))
    }
}
