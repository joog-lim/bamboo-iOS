//
//  Data.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/09/28.
//

import UIKit

struct Data {
    enum tag : String{
        case Humor = "유머"
        case Study = "공부"
        case DailyRoutine = "일상"
        case School = "학교"
        case Employment = "취업"
        case Relationship = "관계"
        case etc = "기타"
    }
    let numberOfAlgorithm : Int
    let data : String
    let tag : tag
    let title : String
    let content : String
    let like : Int
    var isSelected : Bool? = false
}