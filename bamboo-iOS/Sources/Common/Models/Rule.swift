//
//  Rule.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2022/01/02.
//

import RxDataSources

struct Rule : ModelType{
    var content : String
    var thirteen : [String]
    var fifteen : [String]
    
    enum CodingKeys: String, CodingKey{
        case content
        case thirteen = "bold13"
        case fifteen = "bold15"
    }
    static func == (lhs: Rule, rhs: Rule) -> Bool {
        lhs.content == rhs.content
    }
}
