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
// System
    case .postLogin:
        return "login"
    case .postRenewalToken:
        return  "token"
//User
        //get
    case .getAlgorithm:
        return "algorithm/list/page"
    case .getRule:
        return "algorithm/rule"
    case .getVerify:
        return "verify"
        //post
    case .postBulletin:
        return "algorithm/"
    case .postEmoji:
        return "leaf/"
       //patch
    case let .patchReport(_, idx):
        return "algorithm/\(idx)/status"
//Manager
    case .getAdminAlgorithm:
        return "algorithm/list/page/admin"
    //patch
    case let .patchEditAlgorithm(_, idx):
        return "algorithm/\(idx)"
    }
  }
}
