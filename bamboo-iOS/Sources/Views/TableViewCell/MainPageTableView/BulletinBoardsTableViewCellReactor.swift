//
//  BulletinBoardsTableViewCellReactor.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/12/22.
//

import ReactorKit
import RxRelay
import RxFlow

class BulletinBoardsTableViewCellReactor: Reactor{
    typealias Action = NoAction
    let initialState: Algorithem
    
    init( bulletinBoards : Algorithem){
        self.initialState = bulletinBoards
    }
}
