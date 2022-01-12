//
//  StandByReactor.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/12/11.
//

import UIKit

import ReactorKit
import RxFlow
import RxRelay

final class StandByReactor : Reactor, Stepper{
    var steps: PublishRelay<Step> = .init()
    
    enum Action{
        case viewDidLoad
        case standbyBtnTap(titleText : String, message : String, idx : Int, index : Int)
        case alertRefusalTap(Int,Int)
    }
    enum Mutation{
        case updateDataSource
    }
    struct State{
        var mainSection = [StandByViewSection]()
    }
    
    let initialState: State
    
    let errorSubject: PublishSubject<Error> = .init()

    init(){
        self.initialState = State()
    }
}
//MARK: - Mutatain
extension StandByReactor{
    func mutate(action: Action) -> Observable<Mutation> {
        switch action{
        case .viewDidLoad:
            return Observable<Mutation>.just(.updateDataSource)
        case let .standbyBtnTap(titleText, message,idx,index):
            steps.accept(BambooStep.alert(titleText: titleText, message: message, idx: idx, index: index))
            return .empty()
        case let .alertRefusalTap(idx, index):
            steps.accept(BambooStep.refusalRequired(idx: idx, index: index))
            return .empty()
        }
    }
}

//MARK: - State
extension StandByReactor{
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation{
        case .updateDataSource:
            state.mainSection = getMainData()
        }
        return state
    }
}

func getMainData() -> [StandByViewSection]{

    let mainItem1 = StandByViewSectionItem.main(StandByTableViewReactor(StandByBoard: Algorithm(idx: 27, algorithmNumber: 1, title: "Joog-Lim", content: "집", tag: "유머", createdAt: "2021-09-23T02:41:00.457Z", isClicked: false, emojiCount: 1)))
    
    let itemInFirstSection = [mainItem1]
    let firstSection = StandByViewSection(original: StandByViewSection(original: .first(itemInFirstSection), items: itemInFirstSection), items: itemInFirstSection)
    
    return [firstSection]
}
