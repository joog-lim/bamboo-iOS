//
//  Login.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2022/01/03.
//

import RxDataSources

struct Login : ModelType{
    var access : String
    var refresh : String
    enum CodingKeys : String, CodingKey{
        case access =  "accessToken"
        case refresh = "refreshToken"
    }
    static func == (lhs: Login, rhs: Login) -> Bool {
        lhs.access == rhs.access
    }
}

