//
//  DeleteReactor.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/12/11.
//

import UIKit

import ReactorKit
import RxFlow
import RxRelay

final class DeleteReactor : Reactor, Stepper{
    var steps: PublishRelay<Step> = .init()
    
    enum Action{
        case viewDidLoad
        case deleteBtnTap(titleText : String, message : String, idx : Int, index : Int, algorithmNumber : Int)
        case alertRefusalTap(Int,Int,Int)
        case alertDeleteTap(Int,Int)
        case pagination(
            contentHeight: CGFloat,
            contentOffsetY: CGFloat,
            scrollViewHeight: CGFloat
        )
    }
    enum Mutation{
        case updateDataSource([DeleteSection.Item])
        case deleteSuccess
    }
    struct State{
        var mainSection = DeleteSection.Model(
            model: 0,
            items: []
        )
    }
    
    let provider : ServiceProviderType
    var currentPage = 0
    let initialState: State
    
    init(provider : ServiceProviderType){
        self.initialState = State()
        self.provider = provider
    }
}
//MARK: - Mutation
extension DeleteReactor{
    func mutate(action: Action) -> Observable<Mutation> {
        switch action{
        case .viewDidLoad:
            return getDelete()
        case let .deleteBtnTap(titleText, message,idx,index,algorithmNumber):
            steps.accept(BambooStep.alert(titleText: titleText, message: message, idx: idx, index: index, algorithmNumber: algorithmNumber))
            return .empty()
        case let .alertRefusalTap(idx,algorithmNumber,index):
            steps.accept(BambooStep.refusalRequired(idx: idx, algorithmNumber: algorithmNumber, index: index))
            return .empty()
        case let .alertDeleteTap(idx,_):
            return patchDelete(idx: idx)
        case let .pagination( contentHeight,  contentOffsetY, scrollViewHeight):
            let paddingSpace = contentHeight - contentOffsetY
            if paddingSpace < scrollViewHeight{
                return getDelete()
            }else{
                return .empty()
            }

        }
    }
}
//MARK: - Reduce
extension DeleteReactor{
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation{
        case .updateDataSource(let sectionItem):
            state.mainSection.items.append(contentsOf: sectionItem)
        case .deleteSuccess:
            print("Delete Success")
        }
        return state
    }
}

//MARK: - Method
private extension DeleteReactor{
    private func getDelete() -> Observable<Mutation>{
        self.currentPage += 1
        let deleteRequest = AdminAlgorithmRequest(page: currentPage, status: "REPORTED")
        return self.provider.managerService.getAdminAlgorithm(algorithmRequest: deleteRequest)
            .map{(algorithm : Algorithm) -> [DeleteSection.Item] in
                let mainSectionItem = algorithm.data.data.map(DeleteSection.Item.main)
                return mainSectionItem
            }
            .map(Mutation.updateDataSource)
    }
    
    private func patchDelete(idx : Int) -> Observable<Mutation>{
        return self.provider.managerService.deleteAlgorithm(idx: idx)
            .map{Mutation.deleteSuccess}
    }
}
