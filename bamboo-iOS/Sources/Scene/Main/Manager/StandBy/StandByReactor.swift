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
        case pagination(
            contentHeight: CGFloat,
            contentOffsetY: CGFloat,
            scrollViewHeight: CGFloat
        )
    }
    enum Mutation{
        case updateDataSource([StandBySection.Item])
    }
    struct State{
        var mainSection = StandBySection.Model(model: 0, items: [])
    }
    //MARK: - Properties
    let provider : ServiceProviderType
    var currentPage = 0
    let initialState: State
    
    init(provider : ServiceProviderType){
        self.initialState = State()
        self.provider = provider
    }
}
//MARK: - Mutatain
extension StandByReactor{
    func mutate(action: Action) -> Observable<Mutation> {
        switch action{
        case .viewDidLoad:
            return getStandBy()
        case let .standbyBtnTap(titleText, message,idx,index):
            steps.accept(BambooStep.alert(titleText: titleText, message: message, idx: idx, index: index))
            return .empty()
        case let .alertRefusalTap(idx, index):
            steps.accept(BambooStep.refusalRequired(idx: idx, index: index))
            return .empty()
        case let .pagination(contentHeight, contentOffsetY, scrollViewHeight):
            let paddingSpace = contentHeight - contentOffsetY
            if paddingSpace < scrollViewHeight{
                return getStandBy()
            }else{
                return .empty()
            }
        }
    }
}

//MARK: - State
extension StandByReactor{
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation{
        case .updateDataSource(let sectionItem):
            state.mainSection.items.append(contentsOf: sectionItem)
        }
        return state
    }
}

//MARK: - GetAcceptAlgorithm
private extension StandByReactor{
    private func getStandBy() -> Observable<Mutation>{
        self.currentPage += 1
        let standByRequest = AlgorithmRequest(page: currentPage)
        return self.provider.userService.getAlgorithm(algorithmRequest: standByRequest)
            .map{(algorithm: Algorithm) -> [StandBySection.Item] in
                let mainSectionItem = algorithm.result.map(StandBySection.Item.main)
                return mainSectionItem
            }
            .map(Mutation.updateDataSource)
    }
}
