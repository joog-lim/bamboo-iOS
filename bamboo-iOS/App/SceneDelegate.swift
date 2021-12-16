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
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // App Switcher 모드였다가 돌아올때
        callBackgroundImage(false)
    }
    func sceneWillResignActive(_ scene: UIScene) {
        //쓸어 올렸을때, App Switcher 모드
        callBackgroundImage(true)
    }
    func sceneWillEnterForeground(_ scene: UIScene) {
        //완전 백그라운드로 갔다 다시 돌아올때
        callBackgroundImage(false)
    }
    func sceneDidEnterBackground(_ scene: UIScene) {
        //백그라운드로 갔을 때, 홈 눌렀을때
        callBackgroundImage(true)
    }
    
    //MARK: - BackGround 진입시 정보 가리기
    func callBackgroundImage(_ bShow: Bool) {
           let TAG_BG_IMG = -101
           let backgroundView = window?.rootViewController?.view.window?.viewWithTag(TAG_BG_IMG)
           if bShow {
               if backgroundView == nil {
                   //여기서 보여주고 싶은 뷰 자유롭게 생성
                   let bgView = UIView()
                   bgView.frame = UIScreen.main.bounds
                   bgView.tag = TAG_BG_IMG
                   bgView.backgroundColor = .white
                    let imageView = UIImageView(image: UIImage(named: "BAMBOO_Logo"))
                   imageView.frame.size = CGSize(width: 163, height: 69)
                   imageView.tag = TAG_BG_IMG
                   imageView.center = bgView.center
                   bgView.addSubview(imageView)
                   
                   window?.rootViewController?.view.window?.addSubview(bgView)
               }
           } else {
               if let backgroundView = backgroundView {
                   backgroundView.removeFromSuperview()
               }
           }
       }
}

