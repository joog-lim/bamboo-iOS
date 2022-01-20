//
//  RefusalSection.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/12/29.
//

import RxDataSources

enum RefusalSection{
    typealias Model = SectionModel<Int,Item>
    
    enum Item{
        case main(Algorithm.Results)
    }
}
extension RefusalSection.Item : Equatable{}

