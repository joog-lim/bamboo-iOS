//
//  AcceptSection.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/12/28.
//

import RxDataSources

//MARK: - Remake
enum AcceptSection{
    typealias Model = SectionModel<Int,Item>

    enum Item{
        case main(Algorithm.Results)
    }
}
extension AcceptSection.Item : Equatable{}


//enum AcceptSection{
//    case result([AcceptSectionItem])
//}
//
//enum AcceptSectionItem : Equatable{
//    case result(Algorithm.Results)
//}
//
//extension AcceptSection: SectionModelType{
//    var items: [AcceptSectionItem]{
//        switch self{
//        case .result(let algorithm):
//            return algorithm
//        }
//    }
//
//    init(original: AcceptSection, items: [AcceptSectionItem]) {
//        switch original{
//        case .result:
//            self = .result(items)
//        }
//    }
//}
//
//extension AcceptSection : Equatable{
//    static func == (lhs : AcceptSection, rhs : AcceptSection) -> Bool{
//        lhs.items == rhs.items
//    }
//}
