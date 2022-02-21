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
    private let titleLabel = UILabel().then{
        $0.text = "로그인"
        $0.font = UIFont(name: "NanumSquareRoundR", size: 20)
        $0.textColor = .bamBoo_57CC4D
    }
    private let humanAffairsLabel = UILabel().then{
        $0.font = UIFont(name: "NanumSquareRoundR", size: 10)
        $0.text = "로그인 하시겠습니까?"
        $0.textColor = .rgb(red: 87, green: 204, blue: 77)
    }
    private let googleSignBtn = CustomGoogleOauthBtn(image: UIImage(named: "BAMBOO_Google_icon") ?? UIImage() , btnText: "SIGN IN WITH GOOGLE")
    private let appleSignBtn = ASAuthorizationAppleIDButton(type: .signIn, style: .whiteOutline)

    //MARK: - Helper
    override func addView() {
        super.addView()
        view.addSubviews(titleLabel,humanAffairsLabel,googleSignBtn,appleSignBtn)
    }
    
    override func setLayout() {
        super.setLayout()
        
        titleLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(bounds.height/40)
            $0.centerX.equalToSuperview()
        }
        
        googleSignBtn.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(200)
        }
        appleSignBtn.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(googleSignBtn.snp.bottom).offset(10)
            $0.width.height.equalTo(googleSignBtn)
        }

        humanAffairsLabel.snp.makeConstraints {
            $0.bottom.equalTo(googleSignBtn.snp.top).offset(-10)
            $0.left.equalTo(googleSignBtn)
        }
    }

    private func googleOauth(){
        GoogleLogin.shared.SignInOauth(vc: self)
    }

    
    override func bindView(reactor: OauthModalReactor) {
        
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
