//
//  DeleteSection.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/12/29.
//

import RxDataSources

//MARK: - Remake
enum DeleteSection{
    typealias Model = SectionModel<Int,Item>
    
    enum Item{
        case main(Algorithm.Results)
    }
}
extension DeleteSection.Item : Equatable{}

