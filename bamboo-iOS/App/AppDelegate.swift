//
//  AppDelegate.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/09/06.
//

import UIKit
import GoogleSignIn
import AuthenticationServices
import RxAppState
import KeychainSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate{
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        NetWorkStatus.shared.StartMonitoring()
        return true
    }
}

