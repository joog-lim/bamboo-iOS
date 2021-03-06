//
//  BamBooAPI+Method.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2022/01/03.
//

import Foundation
import Moya

extension BamBooAPI{
    func getMethod() -> Moya.Method{
        switch self{
        //Post
        case .postBulletin:
            return .post

            // Get
        case .getAlgorithm:
            return  .get
        case .getRule:
            return .get
        case .getVerify:
            return .get
        // Patch
        case .patchStatus:
            return .patch
        }
    }
}
