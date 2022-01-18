//
//  AcceptSection.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/12/28.
//

import RxDataSources

//MARK: - Remake
enum AcceptSection{
    typealias Model = SectionModel<Int,Item>

    enum Item{
        case main(Algorithm.Results)
    }
}
extension AcceptSection.Item : Equatable{}

