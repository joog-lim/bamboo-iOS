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
        case standbyBtnTap(titleText : String, message : String, idx : Int, index : Int,algorithmNumber: Int)
        case alertRefusalTap(Int,Int,Int)
        case alertAcceptTap(Int,Int)
        case pagination(
            contentHeight: CGFloat,
            contentOffsetY: CGFloat,
            scrollViewHeight: CGFloat
        )
    }
    enum Mutation{
        case updateDataSource([StandBySection.Item])
        case acceptedSuccess
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
        case let .standbyBtnTap(titleText, message,idx,index,algorithmNumber):
            steps.accept(BambooStep.alert(titleText: titleText, message: message, idx: idx, index: index, algorithmNumber: algorithmNumber))
            return .empty()
        case let .alertRefusalTap(idx, index,algorithmNumber):
            steps.accept(BambooStep.refusalRequired(idx: idx, algorithmNumber: algorithmNumber, index: index))
            return .empty()
        case let .alertAcceptTap(idx, _):
            return patchAcceptStatus(idx: idx)
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
        case .acceptedSuccess:
            print("Success")
        }
        return state
    }
}

//MARK: - Method
private extension StandByReactor{
    private func getStandBy() -> Observable<Mutation>{
        self.currentPage += 1
        let standByRequest = AdminAlgorithmRequest(page: currentPage, status: "PENDING")
        return self.provider.managerService.getAdminAlgorithm(algorithmRequest: standByRequest)
            .map{(algorithm: Algorithm) -> [StandBySection.Item] in
                let mainSectionItem = algorithm.data.data.map(StandBySection.Item.main)
                return mainSectionItem
            }
            .map(Mutation.updateDataSource)
    }
    private func patchAcceptStatus(idx : Int) -> Observable<Mutation>{
        let acceptstatusRequest  = EditStatusRequest(status: "ACCEPTED", reason: "")
        return self.provider.managerService.patchRefusalAlgorithm(refusalRequest: acceptstatusRequest, idx: idx)
            .map(Mutation.acceptedSuccess)
    }
}
