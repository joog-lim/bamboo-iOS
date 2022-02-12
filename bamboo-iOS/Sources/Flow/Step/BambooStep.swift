//
//  BambooStep.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/12/02.
//

import RxFlow

enum BambooStep: Step{
    //Global
    case alert(titleText : String, message : String, idx : Int, index: Int, algorithmNumber: Int)

    case dismiss
    //navigation Action
    case backBtnRequired
    
    //MARK: - 작성 방법 : 어떤 행동을 했다로 정의
    
    //MARK: - Login
    case LoginIsRequired
    //User일때
    case userLoginIsRequired
    case userIsLoggedIn
    //Manager일때
    case managerLoginIsRequired
    case managerIsLoggedIn
    //Guest일때
    case guestLoginIsRequired
    
    //MARK: - Main
    //User
    case userMainTabBarIsRequired
    //Home
    case homeIsRequired
    //Rule
    case ruleIsRequired
    //Detail
    case detailIsRequired
    
    //MARK: - Manager
    case managerMainTabBarIsRequired
    //Accept
    case managerAcceptIsRequired
    //StandBy
    case managerStandByIsRequired
    //Refusal
    case managerRefusalIsRequired
    //Delete
    case managerDeleteIsRequired
    
    //MARK: - Modal
    //write
    case writeModalIsRequired
    //report
    case reportModalsRequired(idx : Int, index : Int)
    //googleLogin
    case googleLoginIsRequired
    //EditContent
    case editContentModalsRequired(idx : Int, index : Int)
    // Refusal
    case refusalRequired(idx: Int, algorithmNumber : Int,index : Int)
    
    //NoWifi
    case noWifiRequiered
}
