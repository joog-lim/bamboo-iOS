//
//  RuleReactor.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/12/06.
//

import UIKit

import ReactorKit
import RxFlow
import RxCocoa
import Network
import Moya

final class RuleReactor : Reactor, Stepper{
    //MARK: - Stepper
    var steps: PublishRelay<Step> = .init()
    //MARK: - Event
    enum Action{
        case loadData
    }
    enum Mutation{
        case setRule(_ rule: String, thirteen: [String], fifteen: [String])
    }
    struct State{
        var rule: String?
        var thirteen: [String]?
        var fifteen : [String]?
    }
    
    //MARK: - Properties
    let initialState: State
    
    let errorSubject: PublishSubject<Error> = .init()
    
    init(){
        self.initialState = State()
    }
}

//MARK: - Mutation
extension RuleReactor{
    func mutate(action: Action) -> Observable<Mutation> {
        switch action{
        case.loadData:
            return fetchRule()
        }
    }
}

//MARK: - Reduce
extension RuleReactor{
    func reduce(state: State, mutation: Mutation) -> State {
        var new = state
        switch mutation{
        case .setRule(let rule, thirteen: let thriteen, fifteen: let fifteen):
            new.rule = rule
            new.thirteen = thriteen
            new.fifteen = fifteen
        }
        return new
    }
}

//MARK: - Method
private extension RuleReactor{
    func fetchRule() -> Observable<Mutation>{
        return BamBooAPI.getRule
            .request()
            .map{
                let jsonString = try $0.mapString()
                guard let value = jsonString.data(using: .utf8) else {return $0}
                let newResponse = Response(
                    statusCode: $0.statusCode,
                    data: value,
                    request: $0.request,
                    response: $0.response)
                return newResponse
            }
        .map(Rule.self,using: BamBooAPI.jsonDecoder)
        .asObservable()
        .map{ Mutation.setRule($0.content, thirteen: $0.thirteen, fifteen: $0.fifteen)}
    }
}
