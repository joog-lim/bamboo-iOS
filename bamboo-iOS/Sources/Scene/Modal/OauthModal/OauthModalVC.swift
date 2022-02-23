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

final class OauthModalVC : baseVC<OauthModalReactor> {
    
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
        if UIDevice.current.isiPhone{
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
        }else if UIDevice.current.isiPad{
            googleSignBtn.snp.makeConstraints{
                $0.bottom.equalTo(appleSignBtn.snp.top).offset(-20)
                $0.centerX.equalToSuperview()
                $0.height.equalTo(40)
                $0.width.equalTo(375)
            }
            appleSignBtn.snp.makeConstraints{
                $0.bottom.equalToSuperview().inset(200)
                $0.centerX.equalToSuperview()
                $0.width.equalTo(375)
                $0.height.equalTo(40)
            }
        }
    }

    private func googleOauth(){
        GoogleLogin.shared.SignInOauth(vc: self)
    }

    
    override func bindView(reactor: OauthModalReactor) {
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
            .subscribe(onNext: { result in
                guard let auth = result.credential as? ASAuthorizationAppleIDCredential else {return }
                reactor.action.onNext(.appleLoginBERequest(result: auth))
            })
            .disposed(by: disposeBag)
    }
}