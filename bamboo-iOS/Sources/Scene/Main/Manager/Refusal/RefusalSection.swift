//
//  RefusalSection.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/12/29.
//

import RxDataSources

enum RefusalViewSection {
    case first([RefusalViewSectionItem])
}
enum RefusalViewSectionItem {
    case main(RefusalTableViewReactor)
}
extension RefusalViewSection : SectionModelType{
    var items : [RefusalViewSectionItem]{
        switch self{
        case .first(let items) : return items
        }
    }
    init(original: RefusalViewSection, items: [RefusalViewSectionItem]) {
        switch original {
        case .first: self = .first(items)
        }
    }
}

