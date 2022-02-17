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
        appleForcedDisConnect()
//        appleAutomaticLogin()
        googleAutomaticLogin()
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        var handled : Bool
        handled = GIDSignIn.sharedInstance.handle(url)
        if handled{
            return true
        }
        return false
    }
    //애플 자동 로그인
    private func appleAutomaticLogin(){
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        appleIDProvider.getCredentialState(forUserID: KeychainSwift().get("appleID") ?? "") { (credentialState, error) in
            switch credentialState{
            case .revoked:
                // The Apple ID credential is valid.
                print("게스트 로그인 완료")
            case .authorized:
                // The Apple ID credential is either revoked or was not found, so show the sign-in UI.
                print("ID 가 연동되어있지 않습니다.")
            case .notFound:
                // The Apple ID credential is either was not found, so show the sign-in UI.
                print("ID 를 찾을수 없습니다.")
            default:
                break
            }
        }
    }
    //구글 자동 로그인
    private func googleAutomaticLogin(){
        let defaults = UserDefaults.standard
        GIDSignIn.sharedInstance.restorePreviousSignIn { user , error in
            if error != nil || user == nil{
                print("No user")
                defaults.removeObject(forKey: "LoginStatus")
                defaults.removeObject(forKey: "isAdmin")
                //Show the app's signed out state
            }else{
                print("google Login")
                defaults.set(true, forKey: "LoginStatus")
                //show the app's Signed- in state
            }
        }
    }
    //애플 강제 연결 취소
    private func appleForcedDisConnect(){
        let defaults = UserDefaults.standard
        NotificationCenter.default.addObserver(forName: ASAuthorizationAppleIDProvider.credentialRevokedNotification, object: nil, queue: nil) { (Notification) in
            print("No user")
            defaults.removeObject(forKey: "gest")
            //Show the app's signed out state
        }
    }
}

