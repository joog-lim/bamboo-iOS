//
//  ManagerData.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/10/06.
//

import UIKit


struct ManagerTextData {
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
}

struct DeleteContent {
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
    let deleteContente : String?
}
