//
//  BambooStep.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/12/02.
//

import RxFlow

enum BambooStep: Step{
    //Global
    case dismiss
    
    //MARK: - 어떤 행동을 했다로 정의
    //Login
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
    
    //Manager
    case managerMainTabBarIsRequired
    //Accept
    case managerAcceptIsRequired
    //StandBy
    case managerStandByIsRequired
    //Refusal
    case managerRefusalIsRequired
    //Delete
    case managerDeleteIsRequired
    
}
