//
//  StandBySection.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/12/29.
//

import RxDataSources

//MARK: - Remake
enum StandBySection{
    typealias Model = SectionModel<Int,Item>
    
    enum Item{
        case main(Algorithm)
    }
}
extension StandBySection.Item : Equatable{}
