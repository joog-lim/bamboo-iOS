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
        case viewDidLoad
        case loadData
        case writeData
        case reportBtnClickAction(idx : String, index : Int)
    }
    enum Mutation{
        case updateDataSource
    }
    struct State{
        var mainSection = [MainViewSection]()
    }
    
    //MARK: - Properties
    let initialState: State
    
    let errorSubject: PublishSubject<Error> = .init()
    
    init(){
        self.initialState = State()
    }
}

//MARK: - Mutation
extension MainReactor{
    func mutate(action: Action) -> Observable<Mutation> {
        switch action{
        case .viewDidLoad:
            return Observable<Mutation>.just(.updateDataSource)
        case.loadData:
            return .empty()
        case .writeData:
            steps.accept(BambooStep.writeModalIsRequired)
            return .empty()
        case let .reportBtnClickAction( idx,index):
            steps.accept(BambooStep.reportModalsRequired(idx: idx, index: index))
            return .empty()
        }
    }
}
//MARK: - reduce
extension MainReactor{
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation{
        case .updateDataSource:
            state.mainSection = getMainData()
        }
        return state
    }
}

func getMainData() -> [MainViewSection]{
    let mainItem1 = MainViewSectionItem.main(BulletinBoardsTableViewCellReactor(bulletinBoards: Algorithem(id: "1", number: 1, title: "집", content: "집가고 싶다", tag: "유머", createdAt: 1640316269465)))

    
    let itemInFirstSection = [mainItem1]
    let firstSection = MainViewSection(original: MainViewSection(original: .first(itemInFirstSection), items: itemInFirstSection), items: itemInFirstSection)
    
    return [firstSection]
}
