//
//  AcceptTableViewReactor.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/12/28.
//

import ReactorKit
import RxRelay
import RxFlow

class AcceptTableViewReactor: Reactor{
    typealias Action = NoAction

    let initialState: Algorithm
    
    init( AcceptBoard : Algorithm){
        self.initialState = AcceptBoard
    }
}
