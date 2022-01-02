//
//  AcceptSection.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/12/28.
//

import RxDataSources

enum AcceptViewSection {
    case first([AcceptViewSectionItem])
}
enum AcceptViewSectionItem {
    case main(AcceptTableViewReactor)
}
extension AcceptViewSection : SectionModelType{
    var items : [AcceptViewSectionItem]{
        switch self{
        case .first(let items) : return items
        }
    }
    init(original: AcceptViewSection, items: [AcceptViewSectionItem]) {
        switch original {
        case .first: self = .first(items)
        }
    }
}
