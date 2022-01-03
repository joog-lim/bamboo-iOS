//
//  RefusalTableViewReactor.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/12/29.
//

import ReactorKit
import RxRelay
import RxFlow

class RefusalTableViewReactor: Reactor{
    typealias Action = NoAction

    let initialState: Algorithem
    
    init( RefusalBoard : Algorithem){
        self.initialState = RefusalBoard
    }
}