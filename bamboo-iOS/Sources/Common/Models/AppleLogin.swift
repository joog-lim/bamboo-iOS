//
//  AppleLogin.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2022/02/23.
//

import Foundation

struct AppleLogin : ModelType{
    let data : Datas
    struct Datas : ModelType{
        let isAuth : Bool?
        let sub : String?
        let access : String?
        let refresh : String?
        let isAdmin : Bool?
        enum CodingKeys  : String, CodingKey{
            case isAuth
            case sub
            case access = "accessToken"
            case refresh = "refreshToken"
            case isAdmin
        }
    }
    static func  == (lhs : AppleLogin, rhs : AppleLogin) -> Bool{
        lhs.data == rhs.data
    }
}
