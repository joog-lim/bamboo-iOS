//
//  OnBoardingViewController.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2022/05/18.
//

import UIKit
import ReactorKit
import RxSwift
import Base
import UIUtil
import Then
import SnapKit
import RxUtil

final class OnBoardingViewController: BaseVC<OnBoardingReactor>{
    //MARK: - Properties
    private let logo = UIImageView(image: UIImage(named: "BAMBOO_Logo"),contentMode: .scaleAspectFit)
    private let userLoginButton = LoginButton(placeholder: "사용자", cornerRadius: 15,font: UIFont.systemFont(ofSize: 10))
    private let managerBtn = LoginButton(placeholder: "관리자", cornerRadius: 15,font:  UIFont.systemFont(ofSize: 10))
    private let divider = UIView(frame: CGSize(width: 300, height: 0.5), backgroundColor: .lightGray)
    private let guestBtn = UIButton(title: "게스트로 사용하기", font: UIFont.systemFont(ofSize: 14), titleColor: .lightGray)
    
    //MARK: - Method
    override func addView() {
        view.addSubViews(logo,userLoginButton,managerBtn,divider,guestBtn)
    }
    
    override func setLayout() {
        logo.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.height.equalTo(69)
            $0.width.equalTo(bound.width/2.30)
            $0.top.equalToSuperview().offset(bound.height/3.776744)
        }
        userLoginButton.snp.makeConstraints {
            $0.height.equalTo(bound.height/20)
            $0.left.right.equalToSuperview().inset(bound.width/18.75)
            $0.bottom.equalTo(managerBtn.snp.top).inset(-15)
        }
        managerBtn.snp.makeConstraints {
            $0.height.equalTo(bound.height/20)
            $0.left.right.equalToSuperview().inset(bound.width/18.75)
            $0.bottom.equalTo(divider.snp.top).inset(bound.height/25.375 * -1)
        }
        divider.snp.makeConstraints{
            $0.height.equalTo(0.5)
            $0.left.right.equalToSuperview().inset(bound.width/9.8)
            $0.bottom.equalTo(guestBtn.snp.top).inset(bound.height/54.133 * -1)
        }
        guestBtn.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(bound.height/7.185)
        }
    }
    
    //MARK: - Bind
    override func bindView(reactor: OnBoardingReactor) {
        userLoginButton.rx.tap
            .map{ Reactor.Action.userLoginButtonDidTap}
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        managerBtn.rx.tap
            .map{Reactor.Action.managerLoginButtonDidTap}
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        guestBtn.rx.tap
            .map{Reactor.Action.guestLoginButtonDidTap}
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
}
