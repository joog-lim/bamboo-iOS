//
//  LoginViewController.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/09/08.
//

import UIKit
import SnapKit
import Then
import RxSwift
import GoogleSignIn
import ReactorKit
import RxFlow
import RxViewController

final class LoginViewController : baseVC<LoginReactor> {
    //MARK: - Properties
    private let logo = UIImageView().then{
        $0.image = UIImage(named: "BAMBOO_Logo")
        $0.contentMode = .scaleAspectFit
    }
    private let userBtn = LoginButton(placeholder: "사용자",cornerRadius: 15).then{
        $0.layer.applySketchShadow(color: .rgb(red: 87, green: 204, blue: 77), alpha: 0.25, x: 1, y: 5, blur: 5, spread: 0)
        $0.titleLabel?.font = UIFont(name: "NanumSquareRoundR", size: 15)
    }
    private let ManagerBtn = LoginButton(placeholder: "관리자",cornerRadius: 15).then{
        $0.titleLabel?.font = UIFont(name: "NanumSquareRoundR", size: 15)
    }
    private let divider = UIView().then{
        $0.backgroundColor = .lightGray
        $0.frame.size = CGSize(width: 300, height: 0.5)
    }
    private let guestBtn = UIButton().then{
        $0.titleLabel?.font = UIFont(name: "NanumSquareRoundR", size: 13)
        $0.backgroundColor = .clear
        $0.setTitle("게스트로 사용하기", for: .normal)
        $0.setTitleColor(.lightGray, for: .normal)
    }
    private lazy var btnStackView = UIStackView(arrangedSubviews: [userBtn,ManagerBtn]).then{
        $0.axis = .vertical
        $0.backgroundColor = .clear
        $0.distribution = .fillEqually
        $0.spacing = bounds.height/54.13333
        $0.alignment = .fill
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    //MARK: - Helper
    override func configureUI() {
        super.configureUI()
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func addView() {
        super.addView()
        view.addSubviews(logo,btnStackView,divider,guestBtn)
    }
    override func setLayout() {
        super.setLayout()
        logo.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.height.equalTo(69)
            $0.width.equalTo(bounds.width/2.30)
            $0.top.equalToSuperview().offset(bounds.height/3.776744)
        }
        if UIDevice.current.isiPad{
            btnStackView.snp.makeConstraints {
                $0.height.equalTo(95)
                $0.bottom.equalTo(divider.snp.top).inset(bounds.height/25.375 * -1)
                $0.left.right.equalToSuperview().inset(bounds.width/18.75)
            }
        }else if UIDevice.current.isiPhone{
            btnStackView.snp.makeConstraints {
                $0.height.equalTo(bounds.height/8.55)
                $0.bottom.equalTo(divider.snp.top).inset(bounds.height/25.375 * -1)
                $0.left.right.equalToSuperview().inset(bounds.width/18.75)
            }
        }
        divider.snp.makeConstraints{
            $0.height.equalTo(0.5)
            $0.left.right.equalToSuperview().inset(bounds.width/9.8)
            $0.bottom.equalTo(guestBtn.snp.top).inset(bounds.height/54.133 * -1)
        }
        guestBtn.snp.makeConstraints {
            $0.height.equalTo(15)
            $0.width.equalTo(98)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(bounds.height/7.185)
        }
    }
    
    override func bindView(reactor: LoginReactor) {
        userBtn.rx.tap
            .map{Reactor.Action.userLoginButtonDidTap}
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        ManagerBtn.rx.tap
            .map{Reactor.Action.managerLoginButtonDidTap}
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        guestBtn.rx.tap
            .map{Reactor.Action.guestLoginButtonDidTap}
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
}
