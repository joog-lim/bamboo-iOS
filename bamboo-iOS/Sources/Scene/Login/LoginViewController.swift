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

class LoginViewController : BaseVC {
    //MARK: - Properties
    
    private var vcChoose = UIViewController()
    
    private let logo = UIImageView().then{
        $0.image = UIImage(named: "BAMBOO_Logo")
        $0.contentMode = .scaleAspectFit
    }
    private let userBtn = LoginButton(placeholder: "사용자",cornerRadius: 15).then{
        $0.layer.applySketchShadow(color: .rgb(red: 87, green: 204, blue: 77), alpha: 0.25, x: 1, y: 5, blur: 5, spread: 0)
        $0.titleLabel?.font = UIFont(name: "NanumSquareRoundR", size: 15)
        $0.addTarget(self, action: #selector(ClickUserBtn), for: .touchUpInside)
    }

    private lazy var popup = ManagerPopUp().then{
        $0.alpha = 0
        $0.loginBtn.addTarget(self, action: #selector(clickLoginBtn), for: .touchUpInside)
    }
    
    private let ManagerBtn = LoginButton(placeholder: "관리자",cornerRadius: 15).then{
        $0.titleLabel?.font = UIFont(name: "NanumSquareRoundR", size: 15)
        $0.addTarget(self, action: #selector(ClickManagerBtn), for: .touchDown)
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
        $0.alignment = .fill
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    //MARK: - Selectors
    @objc func keyboardWillShow(_ sender: Notification) {
         self.view.frame.origin.y = -150 // Move view 150 points upward
    }
    @objc func keyboardWillHide(_ sender: Notification) {
        self.view.frame.origin.y = 0 // Move view to original position
    }
    @objc func ClickManagerBtn(){
        UIView.animate(withDuration: 0.42) {
            self.popup.alpha = 1
        }
        popup.WritePassWorld.text = ""
    }
    @objc func ClickUserBtn(){
        vcChoose = MainViewController()
        print(vcChoose)
        navigationController?.pushViewController(MainTabbarController(), animated: true)
        navigationController?.isNavigationBarHidden = false
    }
    @objc func popupClose(){
        UIView.animate(withDuration: 0.3) {
            self.popup.alpha = 0
        }
    }
    @objc func clickLoginBtn(){
        vcChoose = ManagerViewController()
        print(vcChoose)
        navigationController?.pushViewController(MainTabbarController(), animated: true)
        navigationController?.isNavigationBarHidden = false
    }
    
    //MARK: - Helper
    override func configure() {
        super.configure()
        ManagerPopUp().WritePassWorld.delegate = self
        MainTabbarController().delegateLoginVc = self
        keyboardSetting()
        stackViewSetting()
        addView()
        location()
        navigationControllerSetting()
    }
    private func navigationControllerSetting(){
        navigationController?.isNavigationBarHidden = true
    }
    private func stackViewSetting(){
        btnStackView.spacing = bounds.height/54.13333
    }
    
    private func addView(){
        [logo,btnStackView,divider,guestBtn,popup].forEach { view.addSubview($0)}
    }
    
    private func location(){
        logo.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.height.equalTo(69)
            $0.width.equalTo(bounds.width/2.30)
            $0.top.equalToSuperview().offset(bounds.height/3.776744)
        }
        btnStackView.snp.makeConstraints {
            $0.height.equalTo(bounds.height/8.55)
            $0.bottom.equalTo(divider.snp.top).inset(bounds.height/25.375 * -1)
            $0.left.right.equalToSuperview().inset(bounds.width/18.75)
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
        popup.snp.makeConstraints {
            $0.height.equalTo(bounds.height)
            $0.top.right.bottom.left.equalToSuperview()
        }
    }
    //MARK: - KeyboardSetting
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    private func keyboardSetting(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}
extension LoginViewController : UITextFieldDelegate{
    
}
extension LoginViewController : LoginStatue{
    var MoveControllerStatue: UIViewController {
        return vcChoose
    }
}
