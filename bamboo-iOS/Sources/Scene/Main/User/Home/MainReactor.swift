//
//  MainReactor.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/12/06.
//
import UIKit

import ReactorKit
import RxFlow
import RxCocoa

final class MainReactor : Reactor, Stepper{
    //MARK: - Stepper
    var steps: PublishRelay<Step> = .init()
    //MARK: - Event
    enum Action{
        case loadData
        case writeData
        case reportBtnClickAction
    }
    enum Mutation{
        
    }
    struct State{
        
    }
    
    //MARK: - Properties
    let initialState: State
    
    let errorSubject: PublishSubject<Error> = .init()
    
    init(){
        self.initialState = State()
    }
    deinit{
        print("\(type(of: self)): \(#function)")
    }
}

//MARK: - Mutation
extension MainReactor{
    func mutate(action: Action) -> Observable<Mutation> {
        switch action{
        case.loadData:
            return .empty()
        case .writeData:
            steps.accept(BambooStep.writeModalIsRequired)
            return .empty()
        case .reportBtnClickAction:
            steps.accept(BambooStep.reportModalsRequired)
            return .empty()
        }
    }
}
