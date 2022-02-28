//
//  AuthenticationNumberRequest.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2022/02/23.
//

import Foundation

struct AuthenticationNumberRequest : ModelType{
    let authenticationNumber : String
    enum CodingKeys : String , CodingKey{
        case authenticationNumber
    }
    static func == (lhs: AuthenticationNumberRequest, rhs: AuthenticationNumberRequest) -> Bool {
        lhs.authenticationNumber == rhs.authenticationNumber
    }
}

