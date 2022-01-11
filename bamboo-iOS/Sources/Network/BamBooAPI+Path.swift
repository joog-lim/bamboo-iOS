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
        return "algorithm/page"
    case .getRule:
        return "algorithm/rule"
    case .renewalToken(_):
        return  "token" 
    }
  }
}
