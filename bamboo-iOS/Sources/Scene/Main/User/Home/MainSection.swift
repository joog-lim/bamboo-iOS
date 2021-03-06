//
//  MainSection.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/12/23.
//

import RxDataSources

//MARK: - Remake
enum MainSection{
    typealias Model = SectionModel<Int,Item>
    
    enum Item{
        case main(Algorithm.Datas.Results)
    }
}
extension MainSection.Item : Equatable{}

