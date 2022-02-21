//
//  SceneDelegate.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/09/06.
//

import UIKit

import RxFlow
import RxSwift
import GoogleSignIn

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private let coordinator : FlowCoordinator = .init()
    private let disposeBag : DisposeBag = .init()
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else {return}
        coordinatorLogger()
        coordinatorToAppFlow(with: windowScene)
    }
    private func coordinatorLogger(){
        coordinator.rx.willNavigate
            .subscribe(onNext: { flow, step in
                let currentFlow = "\(flow)".split(separator: ".").last ?? "no flow"
                print("➡️ will navigation to flow = \(currentFlow) and step = \(step)")
            }).disposed(by: disposeBag)
    }
    
    private func coordinatorToAppFlow(with windowScene: UIWindowScene){
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        
        let provider : ServiceProviderType = ServiceProvider()
        let appFlow = AppFlow(with: window, and: provider)
        let appStepper = AppStepper(provider: provider)
        
        coordinator.coordinate(flow: appFlow,with: appStepper)
        window.makeKeyAndVisible()
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let scheme = URLContexts.first?.url.scheme else {return }
        if scheme.contains("com.googleusercontent.apps") {
            GIDSignIn.sharedInstance.handle((URLContexts.first?.url)!)
        }
    }
}

