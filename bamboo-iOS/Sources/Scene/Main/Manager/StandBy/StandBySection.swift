//
//  StandBySection.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/12/29.
//

import RxDataSources

enum StandByViewSection {
    case first([StandByViewSectionItem])
}
enum StandByViewSectionItem {
    case main(StandByTableViewReactor)
}
extension StandByViewSection : SectionModelType{
    var items : [StandByViewSectionItem]{
        switch self{
        case .first(let items) : return items
        }
    }
    init(original: StandByViewSection, items: [StandByViewSectionItem]) {
        switch original {
        case .first: self = .first(items)
        }
    }
}
