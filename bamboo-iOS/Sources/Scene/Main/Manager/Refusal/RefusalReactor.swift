//
//  RefusalReactor.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/12/11.
//

import UIKit

import ReactorKit
import RxFlow
import RxRelay

final class RefusalReactor : Reactor, Stepper{
    var steps: PublishRelay<Step> = .init()
    
    enum Action{
        case viewDidLoad
    }
    enum Mutation{
        case updateDataSource
    }
    struct State{
        var mainSection = [RefusalViewSection]()
    }
    
    let initialState: State
    
    let errorSubject: PublishSubject<Error> = .init()

    init(){
        self.initialState = State()
    }
}
//MARK: - Mutation
extension RefusalReactor{
    func mutate(action: Action) -> Observable<Mutation> {
        switch action{
        case .viewDidLoad:
            return Observable<Mutation>.just(.updateDataSource)
        }
    }
}
//MARK: - Reduce
extension RefusalReactor{
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation{
        case .updateDataSource:
            state.mainSection = getMainData()
        }
        return state
    }
}

func getMainData() -> [RefusalViewSection]{

    let mainItem1 = RefusalViewSectionItem.main(RefusalTableViewReactor(RefusalBoard: Algorithem(id: "1", number: 1, title: "저녁", content: "테스트", tag: "유머", createdAt: 1640316269465)))
    
    let itemInFirstSection = [mainItem1]
    let firstSection = RefusalViewSection(original: RefusalViewSection(original: .first(itemInFirstSection), items: itemInFirstSection), items: itemInFirstSection)
    
    return [firstSection]
}
