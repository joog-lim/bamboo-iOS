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
        case main(Algorithm.Results)
    }
}
extension MainSection.Item : Equatable{}


////MARK: - RemakeDataSource
//enum MainViewSection {
//  case result([MainViewSectionItem])
//}
//
//enum MainViewSectionItem: Equatable {
//  case result(Algorithm.Results)
//}
//
//extension MainViewSection: SectionModelType {
//  var items: [MainViewSectionItem] {
//    switch self {
//    case .result(let photos): return photos
//    }
//  }
//
//  init(original: MainViewSection, items: [MainViewSectionItem]) {
//    switch original {
//    case .result: self = .result(items)
//    }
//  }
//}
//
//extension MainViewSection: Equatable {
//  static func == (lhs: MainViewSection, rhs: MainViewSection) -> Bool {
//    lhs.items == rhs.items
//  }
//}
//
