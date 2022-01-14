//
//  BamBooAPI+Header.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2022/01/03.
//

import Foundation
import KeychainSwift

extension BamBooAPI{
    func getHeader() -> [String:String]?{
        switch self{
        case let .postRenewalToken(refreshToken):
            return ["Authorization": refreshToken]
        case let .postLogin(idToken):
            return ["Authorization": idToken]
        default:
            return ["Content-Type": "application/json"]
        }
    }
}
