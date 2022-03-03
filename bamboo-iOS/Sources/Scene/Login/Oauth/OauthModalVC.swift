//
//  GoogleOauthModalVC.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/11/04.
//

import UIKit
import GoogleSignIn
import RxSwift
import RxCocoa
import RxGesture
import ReactorKit
import RxKeyboard
import AuthenticationServices
import KeychainSwift

final class OauthVC : baseVC<OauthReactor> {
    
    //MARK: - Properties
    private let backBar = LoginBar()
    private let titleLabel = UILabel().then{
        $0.text = "로그인"
        $0.font = UIFont(name: "NanumSquareRoundR", size: 20)
        $0.textColor = .bamBoo_57CC4D
    }

    private let googleSignBtn = CustomGoogleOauthBtn(image: UIImage(named: "BAMBOO_Google_icon") ?? UIImage() , btnText: "SIGN IN WITH GOOGLE")
    private let appleSignBtn = ASAuthorizationAppleIDButton(type: .signIn, style: .whiteOutline)

    //MARK: - Helper
    override func addView() {
        super.addView()
        view.addSubviews(backBar,titleLabel,googleSignBtn,appleSignBtn)
    }
    
    override func setLayout() {
        super.setLayout()
        backBar.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(bounds.height/40)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(50)
        }
        titleLabel.snp.makeConstraints{
            $0.top.equalTo(backBar.snp.bottom).offset(bounds.height/40)
            $0.left.equalToSuperview().offset(20)
        }
        googleSignBtn.snp.makeConstraints{
            $0.height.equalTo(bounds.height/20)
            $0.left.right.equalToSuperview().inset(40)
            $0.top.equalTo(titleLabel.snp.bottom).offset(bounds.height/2.3)
        }
        appleSignBtn.snp.makeConstraints{
            $0.height.equalTo(bounds.height/20)
            $0.top.equalTo(googleSignBtn.snp.bottom).offset(20)
            $0.width.equalTo(googleSignBtn)
            $0.centerX.equalToSuperview()
        }
    }

    private func googleOauth(){
        GoogleLogin.shared.SignInOauth(vc: self)
    }
    //MARK: - Bind
    override func bindView(reactor: OauthReactor) {
        backBar.backBtn.rx.tap
            .map(Reactor.Action.backBtnRequired)
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        googleSignBtn.rx.tap
            .subscribe(onNext:{
                GoogleLogin.shared.SignInOauth(vc: self)
            }).disposed(by: disposeBag)
        
        appleSignBtn.rx
            .loginOnTap(scope: [.fullName, .email])
            .do(onNext: {[weak self] _ in self?.showLoading()})
            .subscribe(onNext: { result in
                guard let auth = result.credential as? ASAuthorizationAppleIDCredential else {return }
                UserDefaults().set(("\(auth.fullName?.familyName ?? "")\(auth.fullName?.givenName ?? "")"), forKey: "name")
                KeychainSwift().set(auth.user, forKey: "appleID")
                print(auth.user)
                reactor.action.onNext(.appleLoginBERequest(result: auth))
            })
            .disposed(by: disposeBag)
    }
    override func bindState(reactor: OauthReactor) {
        reactor.state.observe(on: MainScheduler.instance)
            .subscribe(onNext:{ [weak self] _ in
                self?.hideLoading()
            }).disposed(by: disposeBag)
    }
}
