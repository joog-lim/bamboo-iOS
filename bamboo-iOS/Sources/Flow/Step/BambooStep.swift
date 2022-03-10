//
//  BambooStep.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/12/02.
//

import RxFlow
import AuthenticationServices

enum BambooStep: Step{
    //Global
    case alert(titleText : String, message : String, idx : Int, index: Int, algorithmNumber: Int)
    
    case dismiss
    
    //MARK: - Main
    //User
    case userMainTabBarIsRequired
    //Home
    case homeIsRequired
    //Rule
    case ruleIsRequired
    //Detail
    case detailIsRequired
    
    
    //MARK: - Modal
    //write
    case writeModalIsRequired
    //report
    case reportModalsRequired(idx : Int, index : Int)
    //NoWifi
    case noWifiRequiered
}
