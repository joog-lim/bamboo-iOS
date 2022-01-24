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
//        case let .postLogin(idToken):
//            return ["Authorization": idToken]
        case .getAlgorithm, .getAdminAlgorithm, .postEmoji:
            return ["Authorization":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InMyMDA0NEBnc20uaHMua3IiLCJpc0FkbWluIjp0cnVlLCJuaWNrbmFtZSI6IjIxMDjslYjsp4Dtm4giLCJpZGVudGl0eSI6InN0dWRlbnQiLCJ0b2tlblR5cGUiOiJBY2Nlc3NUb2tlbiIsImlhdCI6MTY0Mjk5MzU0NywiZXhwIjoxNjQyOTk3MTQ3LCJpc3MiOiJqb29nLWxpbS5pbmZvIn0.mqxqcGZUngeQ2yF5xXBJJXV4d910j1d7Q9em9nk6HTY"]
        default:
            return ["Content-Type": "application/json"]
        }
    }
}
///list/page/admin?count=10&criteria=1&status=PENDING
