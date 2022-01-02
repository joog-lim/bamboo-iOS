//
//  DeleteSection.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/12/29.
//

import RxDataSources

enum DeleteViewSection{
    case first([DeleteViewSectionItem])
}
enum DeleteViewSectionItem{
    case main(DeleteTableViewReactor)
}
extension DeleteViewSection : SectionModelType{
    var items: [DeleteViewSectionItem]{
        switch self{
        case .first(let items): return items
        }
    }
    init(original: DeleteViewSection, items: [DeleteViewSectionItem]) {
        switch original{
        case .first: self = .first(items)
        }
    }
}

