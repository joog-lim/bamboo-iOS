//
//  BamBooAPI+Path.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2022/01/03.
//

import Foundation

extension BamBooAPI {
  func getPath() -> String {
    switch self {
    case .postLogin:
        return "login"
    case .getAlgorithem:
        return ""
    case .getRule:
        return "algorithm/rule"

    }
  }
}
