//
//  AppleLoginRequest.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2022/02/23.
//

import Foundation

struct AppleLoginRequest : ModelType{
    let name : String
    enum CodingKeys : String , CodingKey{
        case name
    }
    static func == (lhs: AppleLoginRequest, rhs: AppleLoginRequest) -> Bool {
        lhs.name == rhs.name
    }
}
