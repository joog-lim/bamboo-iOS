//
//  SceneDelegate.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/09/06.
//

import UIKit

import RxFlow
import RxSwift

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private let coordinator : FlowCoordinator = .init()
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let mainViewController = LoginViewController()
        let navigationController = UINavigationController(rootViewController: mainViewController)
        NetWorkStatus.shared.StartMonitoring()
        
        navigationController.navigationCustomBar()
        window?.backgroundColor = .white
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
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
                   imageView.frame.size = CGSize(width: bgView.frame.width/2.300, height: bgView.frame.height/11.768)
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
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
        callBackgroundImage(false)
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
        callBackgroundImage(true)
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
        callBackgroundImage(false)
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
        callBackgroundImage(true)
    }


}

