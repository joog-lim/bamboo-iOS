//
//  AcceptReactor.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/12/06.
//

import UIKit

import ReactorKit
import RxFlow
import RxRelay

final class AcceptReactor : Reactor, Stepper{
    var steps: PublishRelay<Step> = .init()
    
    enum Action{
        case backBtnTap
        case viewDidLoad
        case editContentPresent(idx : Int, index : Int)
    }
    enum Mutation{
        case updateDataSource
    }
    struct State{
        var mainSection = [AcceptViewSection]()
    }
    
    let initialState: State
    
    let errorSubject: PublishSubject<Error> = .init()

    init(){
        self.initialState = State()
    }
}
//MARK: - Mutation
extension AcceptReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .backBtnTap:
            steps.accept(BambooStep.backBtnRequired)
            return .empty()
        case .viewDidLoad:
            return Observable<Mutation>.just(.updateDataSource)
        case let .editContentPresent(idx,index):
            steps.accept(BambooStep.editContentModalsRequired(idx: idx, index: index))
            return .empty()

        }
    }
}
//MARK: - reduce
extension AcceptReactor{
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation{
        case .updateDataSource:
            state.mainSection = getMainData()
        }
        return state
    }
}

func getMainData() -> [AcceptViewSection]{

    let mainItem1 = AcceptViewSectionItem.main(AcceptTableViewReactor(AcceptBoard: Algorithm(idx: 27, algorithmNumber: 1, title: "Joog-Lim", content: "집", tag: "유머", createdAt: "2021-09-23T02:41:00.457Z", isClicked: false, emojiCount: 1)))
    
    let itemInFirstSection = [mainItem1]
    let firstSection = AcceptViewSection(original: AcceptViewSection(original: .first(itemInFirstSection), items: itemInFirstSection), items: itemInFirstSection)
    
    return [firstSection]
}
