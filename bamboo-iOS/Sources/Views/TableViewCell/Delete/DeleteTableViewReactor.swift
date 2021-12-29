//
//  DeleteTableViewReactor.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/12/29.
//

import ReactorKit
import RxRelay
import RxFlow

class DeleteTableViewReactor: Reactor{
    typealias Action = NoAction

    let initialState: Algorithem
    
    init( AcceptBoard : Algorithem){
        self.initialState = AcceptBoard
    }
}
