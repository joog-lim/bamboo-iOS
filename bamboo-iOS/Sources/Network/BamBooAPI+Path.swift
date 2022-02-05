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
        //get
    case .getAlgorithm:
        return "algorithm/list/page"
    case .getRule:
        return "algorithm/rule"
    case .getVerify:
        return "verify"
    case .getAdminAlgorithm:
        return "algorithm/list/page/admin"
        //post
    case .postBulletin:
        return "algorithm/"
    case .postEmoji:
        return "leaf/"
       //patch
    case let .patchStatus(_, idx):
        return "algorithm/\(idx)/status"
    case let .patchEditAlgorithm(_, idx):
        return "algorithm/\(idx)"
        //delete
    case let .deleteAlgorithm(idx):
        return "algorithm/\(idx)"
    case .deleteEmoji:
        return "leaf/"
    }
  }
}
