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
        case pagination(
            contentHeight: CGFloat,
            contentOffsetY: CGFloat,
            scrollViewHeight: CGFloat
        )
        case clickRefusalCancelBtn(Int)
    }
    enum Mutation{
        case updateDataSource([RefusalSection.Item])
        case refusalStatusSuccess
    }
    struct State{
        var mainSection = RefusalSection.Model(model: 0, items: [])
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
//MARK: - Mutation
extension RefusalReactor{
    func mutate(action: Action) -> Observable<Mutation> {
        switch action{
        case .viewDidLoad:
            return getRefusal()
        case let .pagination(contentHeight, contentOffsetY, scrollViewHeight):
            let paddingSpace = contentHeight - contentOffsetY
            if paddingSpace < scrollViewHeight{
                return getRefusal()
            }else{
                return .empty()
            }
        case let .clickRefusalCancelBtn(idx):
            return patchRefusalStatus(idx: idx)
        }
    }
}
//MARK: - Reduce
extension RefusalReactor{
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation{
        case .updateDataSource(let sectionItem):
            state.mainSection.items.append(contentsOf: sectionItem)
            print( state.mainSection.items[0])

        case .refusalStatusSuccess:
            print("Success")
        }
        return state
    }
}

//MARK: - GetAcceptAlgorithm
private extension RefusalReactor{
    private func getRefusal() -> Observable<Mutation>{
        self.currentPage += 1
        let refusalRequest = AdminAlgorithmRequest(page: currentPage, status: "REJECTED")
        return self.provider.managerService.getAdminAlgorithm(algorithmRequest: refusalRequest)
            .map{(algorithm: Algorithm) -> [RefusalSection.Item] in
                let mainSectionItem = algorithm.data.data.map(RefusalSection.Item.main)
                return mainSectionItem
            }
            .map(Mutation.updateDataSource)
    }
    private func patchRefusalStatus(idx : Int) -> Observable<Mutation>{
        let editRequest = EditStatusRequest(status: "ACCEPTED", reason: "")
        return self.provider.managerService.patchRefusalAlgorithm(refusalRequest: editRequest, idx: idx).map{ Mutation.refusalStatusSuccess}
    }
}
