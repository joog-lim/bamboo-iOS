//
//  GoogleOauthModalVC.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/11/04.
//

import UIKit
import GoogleSignIn

class GoogleOauthModalVC : BaseModal {
    
    //MARK: - Properties
    weak var delegate : GoogleOauthModalDelegate?
    
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
        $0.text = "관리자님 환영합니다!"
        $0.textColor = .rgb(red: 87, green: 204, blue: 77)
    }
    private let googleSignBtn = CustomGoogleOauthBtn(image: UIImage(named: "BAMBOO_Google_icon") ?? UIImage() , btnText: "SIGN IN WITH GOOGLE").then{
        $0.addTarget(self, action: #selector(GoogleOAuthLogin), for: .touchUpInside)
    }
    
    //MARK: - Selector
    
    //모달 위치 조정
    static func instance() -> GoogleOauthModalVC{
        return GoogleOauthModalVC(nibName: nil, bundle: nil).then{
            $0.modalPresentationStyle = .overFullScreen
        }
    }
    
    //MARK: - Selectors
    @objc private func UserLoginBtn(){
        dismiss(animated: true) {
            self.delegate?.GoogleOauthModalBtnClick()
        }
    }
    @objc private func GoogleOAuthLogin(){
        print("GOOGLE Sign In Start")
        if GIDSignIn.sharedInstance.hasPreviousSignIn(){
            baseDelegate?.onTapClick()
            dismiss(animated: true) {
                self.delegate?.GoogleOauthModalBtnClick()
            }
        }else{
            GoogleLogin.shared.SignInOauth(vc: self)
        }
    }
    
    //MARK: - Helper

    override func modalSetting() {
        super.modalSetting()
        view.backgroundColor = .clear
        addView()
        location()
    }
    //MARK: - AddView
    private func addView(){
        [transparentView,bgView].forEach{ view.addSubview($0)}
        [titleLabel,humanAffairsLabel,googleSignBtn].forEach{ bgView.addSubview($0)}
    }

    //MARK: - Location
    private func location(){
        if UIDevice.current.isiPhone{
            bgView.layer.cornerRadius = 10
            bgView.snp.makeConstraints{
                $0.center.equalToSuperview()
                $0.height.equalTo(bounds.height/3.5771)
                $0.width.equalTo(bounds.width/1.1718)
            }
            googleSignBtn.snp.makeConstraints{
                $0.center.equalToSuperview()
                $0.height.equalTo(bounds.height/23.2)
                $0.width.equalToSuperview().inset(30)
            }
        }else if UIDevice.current.isiPad{
            bgView.layer.cornerRadius = 15
            bgView.snp.makeConstraints{
                $0.center.equalToSuperview()
                $0.height.equalTo(220)
                $0.width.equalTo(292)
            }
            googleSignBtn.snp.makeConstraints{
                $0.center.equalToSuperview()
                $0.height.equalTo(35)
                $0.left.right.equalToSuperview().inset(30)
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
}
