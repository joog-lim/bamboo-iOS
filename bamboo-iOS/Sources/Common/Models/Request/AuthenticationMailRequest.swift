//
//  AuthenticationMailRequest.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2022/02/23.
//

import Foundation

struct AuthenticationMailRequest : ModelType{
    let email : String
    enum CodingKeys : String , CodingKey{
        case email
    }
    static func == (lhs: AuthenticationMailRequest, rhs: AuthenticationMailRequest) -> Bool {
        lhs.email == rhs.email
    }
}
