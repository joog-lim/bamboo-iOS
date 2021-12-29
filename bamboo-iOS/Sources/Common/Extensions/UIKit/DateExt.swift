//
//  DateExt.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/12/28.
//

import Foundation
extension Date{
    func currentTimeMillis() -> Int64{
        return Int64(self.timeIntervalSince1970 * 1000)
    }
}
