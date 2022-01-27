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
//        case let.postLogin(loginRequest):
//            return loginRequest.toDictionary()
        case .getAlgorithm, .getAdminAlgorithm, .postEmoji, .patchEditAlgorithm, .patchStatus:
            return ["Authorization":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InMyMDA0NEBnc20uaHMua3IiLCJpc0FkbWluIjp0cnVlLCJuaWNrbmFtZSI6IjIxMDjslYjsp4Dtm4giLCJpZGVudGl0eSI6InN0dWRlbnQiLCJ0b2tlblR5cGUiOiJBY2Nlc3NUb2tlbiIsImlhdCI6MTY0MzI2OTAxNiwiZXhwIjoxNjQzMjcyNjE2LCJpc3MiOiJqb29nLWxpbS5pbmZvIn0.pdEU0Lng7b5QsE49LNDCYF_JN_iH5rIa8rKsSZVnpXA"]
        default:
            return ["Content-Type": "application/json"]
        }
    }
}
///list/page/admin?count=10&criteria=1&status=PENDING
