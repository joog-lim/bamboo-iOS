//
//  SceneDelegate.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2022/05/18.
//

import UIKit
import RxSwift
import RxFlow

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private let disposeBag: DisposeBag = .init()
    private let coordinator: FlowCoordinator = .init()
    
    let appFlow = AppFlow()
    let appStepper = AppStepper()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        coordinateLogger()
        coordinateToAppFlow(with: windowScene)
    }
    private func coordinateToAppFlow(with scene: UIWindowScene){
        let window = UIWindow(windowScene: scene)
        self.window = window
        
        coordinator.coordinate(flow: appFlow, with: appStepper)
        Flows.use(
            appFlow,
            when: .created
        ) { [weak self] root in
            self?.window?.rootViewController = root
            self?.window?.makeKeyAndVisible()
        }
    }
    
    private func coordinateLogger(){
        coordinator.rx.willNavigate
            .subscribe(onNext: { flow, step in
                let currentFlow = "\(flow)".split(separator: " ").last ?? "No Flow"
                print("➡️ will navigate to flow = \(currentFlow) and step = \(step)")
            })
            .disposed(by: disposeBag)
    }
}

