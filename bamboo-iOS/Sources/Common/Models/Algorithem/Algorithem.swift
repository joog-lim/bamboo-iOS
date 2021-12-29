//
//  User.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/12/22.
//

import RxDataSources

struct Algorithem : ModelType{
    var id  : String
    var number : Int
    var title : String
    var content : String
    var tag : String
    var createdAt : Int64
    var reason : String?
    var isDone = false
}

extension Algorithem : Equatable{
    static func == (lhs : Algorithem, rhs : Algorithem) -> Bool{
        lhs.id == rhs.id
    }
}
