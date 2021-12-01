//
//  TextFieldStatusViewModel.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/11/22.
//

import Foundation

protocol TextFieldStatusModel {
    func updateForm()
}
protocol TextfieldModel {
    var tfEmpty: Bool{get}
}
struct ManagerPasswordSearchModel : TextfieldModel {
    var search : String?
    var tfEmpty: Bool{
        return search?.isEmpty == false
    }
    var showView: Bool{
        return tfEmpty
    }
}
