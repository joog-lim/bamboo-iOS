//
//  MainSection.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/12/23.
//

import RxDataSources

enum MainViewSection{
    case first([MainViewSectionItem])
}
enum MainViewSectionItem {
    
    case main(BulletinBoardsTableViewCellReactor)
}
extension MainViewSection : SectionModelType{
    var items : [MainViewSectionItem]{
        switch self{
        case .first(let items) : return items
        }
    }
    init(original: MainViewSection, items: [MainViewSectionItem]) {
        switch original {
        case .first: self = .first(items)
        }
    }
}
