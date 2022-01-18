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
        case viewDidLoad
        case editContentPresent(idx : Int, index : Int)
        case pagination(
            contentHeight: CGFloat,
            contentOffsetY: CGFloat,
            scrollViewHeight: CGFloat
        )
    }
    enum Mutation{
        case updateDataSource([AcceptSection.Item])
    }
    struct State{
        var mainSection = AcceptSection.Model(model: 0, items: [])
    }
    //MARK: - Properties
    let provider : ServiceProviderType
    var currentPage = 0
    var ispaginating = false
    let initialState: State
    
    init(provider : ServiceProviderType){
        self.initialState = State()
        self.provider = provider
    }
}
//MARK: - Mutation
extension AcceptReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewDidLoad:
            return getAccept()
        case let .editContentPresent(idx,index):
            steps.accept(BambooStep.editContentModalsRequired(idx: idx, index: index))
            return .empty()
        case let .pagination(contentHeight,contentOffsetY,  scrollViewHeight):
            let paddingSpace = contentHeight - contentOffsetY
            if paddingSpace < scrollViewHeight{
                return getAccept()
            }else{
                return .empty()
            }
        }
    }
}
//MARK: - reduce
extension AcceptReactor{
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
private extension AcceptReactor{
    private func getAccept() -> Observable<Mutation>{
        self.currentPage += 1
        let acceptRequest = AdminAlgorithmRequest(page: currentPage, status: "ACCEPTED")
        return self.provider.managerService.getAdminAlgorithm(algorithmRequest: acceptRequest)
            .map{(algorithm: Algorithm) -> [AcceptSection.Item] in
                let mainSectionItem = algorithm.result.map(AcceptSection.Item.main)
                return mainSectionItem
            }
            .map(Mutation.updateDataSource)
    }
}
