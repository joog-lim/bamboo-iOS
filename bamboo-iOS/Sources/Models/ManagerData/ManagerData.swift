//
//  ManagerData.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/10/06.
//

import UIKit

struct ManagerData{
    enum status : String{
        case Accept = "수락"
        case StandBy = "대기"
        case Refusal = "거절"
        case Delete = "삭제"
    }
    let menuStatus : status
}
