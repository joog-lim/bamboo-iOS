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
    //Login 여부
    case userLoginIsRequired
    case userIsLoggedIn
    case managerLoginIsRequired
    case managerIsLoggedIn
    
    
    
    
}
