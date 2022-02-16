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

final class GoogleOauthModalVC : baseVC<GoogleOauthModalReactor> {
    
    //MARK: - Properties
    private let transparentView = UIView().then{
        $0.backgroundColor = .black
        $0.alpha = 0.1
    }
    private let bgView = UIView().then{
        $0.backgroundColor = .white
    }
    private let titleLabel = UILabel().then{
        $0.text = "로그인하기"
        $0.font = UIFont(name: "NanumSquareRoundR", size: 10)
        $0.textColor = .rgb(red: 196, green: 196, blue: 196)
    }
    private let humanAffairsLabel = UILabel().then{
        $0.font = UIFont(name: "NanumSquareRoundR", size: 10)
        $0.text = "로그인 하시겠습니까?"
        $0.textColor = .rgb(red: 87, green: 204, blue: 77)
    }
    private let googleSignBtn = CustomGoogleOauthBtn(image: UIImage(named: "BAMBOO_Google_icon") ?? UIImage() , btnText: "SIGN IN WITH GOOGLE")
    private let appleSignBtn = ASAuthorizationAppleIDButton(type: .signIn, style: .whiteOutline)
    
    //MARK: - Helper
    override func configureUI() {
        super.configureUI()
        view.backgroundColor = .clear
    }
    override func addView() {
        super.addView()
        view.addSubviews(transparentView,bgView)
        bgView.addSubviews(titleLabel,humanAffairsLabel,googleSignBtn,appleSignBtn)
    }
    
    override func setLayout() {
        super.setLayout()
        transparentView.snp.makeConstraints{
            $0.top.right.left.bottom.equalToSuperview()
        }
        if UIDevice.current.isiPhone{
            bgView.layer.cornerRadius = 10
            bgView.snp.makeConstraints{
                $0.center.equalToSuperview()
                $0.height.equalTo(bounds.height/3.5771)
                $0.width.equalTo(bounds.width/1.1718)
            }
            googleSignBtn.snp.makeConstraints{
                $0.top.equalTo(bgView.snp.top).offset(bounds.height/10)
                $0.centerX.equalToSuperview()
                $0.height.equalTo(bounds.height/23.2)
                $0.width.equalToSuperview().inset(30)
            }
            appleSignBtn.snp.makeConstraints{
                $0.top.equalTo(googleSignBtn.snp.bottom).offset(15)
                $0.height.equalTo(bounds.height/23.2)
                $0.left.right.equalTo(googleSignBtn)
            }
        }else if UIDevice.current.isiPad{
            bgView.layer.cornerRadius = 15
            bgView.snp.makeConstraints{
                $0.center.equalToSuperview()
                $0.height.equalTo(220)
                $0.width.equalTo(292)
            }
            googleSignBtn.snp.makeConstraints{
                $0.top.equalTo(bgView.snp.top).offset(85)
                $0.centerX.equalToSuperview()
                $0.height.equalTo(35)
                $0.left.right.equalToSuperview().inset(30)
            }
            appleSignBtn.snp.makeConstraints{
                $0.top.equalTo(googleSignBtn.snp.bottom).offset(15)
                $0.height.equalTo(35)
                $0.left.right.equalTo(googleSignBtn)
            }
        }
        titleLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(bounds.height/40)
            $0.centerX.equalToSuperview()
        }
        humanAffairsLabel.snp.makeConstraints {
            $0.bottom.equalTo(googleSignBtn.snp.top).offset(-10)
            $0.left.equalTo(googleSignBtn)
        }
    }

    private func googleOauth(){
        GoogleLogin.shared.SignInOauth(vc: self)
    }
    private func appleOauth(){
//        AppleLogin.shared.SignInOauth(vc: self)
    }
    
    override func bindView(reactor: GoogleOauthModalReactor) {
        transparentView.rx.tapGesture()
            .when(.recognized)
            .map{_ in Reactor.Action.googleModalDismiss}
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        googleSignBtn.rx.tap
            .subscribe(onNext:{
                GoogleLogin.shared.SignInOauth(vc: self)
            }).disposed(by: disposeBag)
        
        
    }
}
