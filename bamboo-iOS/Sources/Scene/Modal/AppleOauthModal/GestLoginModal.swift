//
//  GestLoginModal.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2022/02/17.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture
import ReactorKit
import RxKeyboard
import AuthenticationServices

final class AppleLoginModal : baseVC<AppleLoginReactor> {
    
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
        $0.text = "게스트 로그인"
        $0.textColor = .rgb(red: 87, green: 204, blue: 77)
    }
    private let appleSignBtn = ASAuthorizationAppleIDButton(type: .signIn, style: .whiteOutline)
    
    //MARK: - Helper
    override func configureUI() {
        super.configureUI()
        view.backgroundColor = .clear
    }
    override func addView() {
        super.addView()
        view.addSubviews(transparentView,bgView)
        bgView.addSubviews(titleLabel,humanAffairsLabel,appleSignBtn)
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
            appleSignBtn.snp.makeConstraints{
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
            appleSignBtn.snp.makeConstraints{
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
            $0.bottom.equalTo(appleSignBtn.snp.top).offset(-10)
            $0.left.equalTo(appleSignBtn)
        }
    }
    
    override func bindView(reactor: AppleLoginReactor) {
        transparentView.rx.tapGesture()
            .when(.recognized)
            .map{_ in Reactor.Action.dismiss}
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        appleSignBtn.rx
            .loginOnTap(scope: [.fullName, .email])
            .subscribe(onNext: { _ in
                reactor.action.onNext(.appleLogin)
            })
            .disposed(by: disposeBag)
    }
}
