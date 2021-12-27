//
//  DropdownTableViewReactor.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/12/26.
//

import ReactorKit
import RxRelay
import RxFlow

class DropdownTableViewReactor: Reactor{
    typealias Action = NoAction

    let initialState: DropDown
    
    init( bulletinBoards : DropDown){
        self.initialState = bulletinBoards
    }
}

