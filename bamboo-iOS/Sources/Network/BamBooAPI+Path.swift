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
       //patch
    case let .patchStatus(_, idx):
        return "algorithm/\(idx)/status"
    }
  }
}
