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
    
    //MARK: - 모달 background 설정
    let bgView = UIView().then {
        $0.backgroundColor = .black
        $0.alpha = 0
    }
    private let logo = UIImageView().then{
        $0.image = UIImage(named: "BAMBOO_Logo")
        $0.contentMode = .scaleAspectFit
    }
    private let userBtn = LoginButton(placeholder: "사용자",cornerRadius: 15).then{
        $0.layer.applySketchShadow(color: .rgb(red: 87, green: 204, blue: 77), alpha: 0.25, x: 1, y: 5, blur: 5, spread: 0)
        $0.titleLabel?.font = UIFont(name: "NanumSquareRoundR", size: 15)
        $0.addTarget(self, action: #selector(ClickUserBtn), for: .touchUpInside)
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
    //MARK: - Manager Modal 띄워주기
    @objc private func ClickManagerBtn(){
        let ManagerLoginModalModalsVC = ManagerLoginModal.instance()
        ManagerLoginModalModalsVC.delegate = self
        addDim()
        present(ManagerLoginModalModalsVC, animated: true, completion: nil)
    }
    @objc private func ClickUserBtn(){
        let googleOAuthModalVC = GoogleOauthModalVC.instance()
        googleOAuthModalVC.delegate = self
        addDim()
        present(googleOAuthModalVC, animated: true, completion: nil)
    }
    
    //MARK: - Helper
    override func configure() {
        super.configure()
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
        [logo,btnStackView,divider,guestBtn].forEach { view.addSubview($0)}
    }
    private func location(){
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
    
    //MARK: - KeyboardSetting
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    private func keyboardSetting(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}
//MARK: - Modal 관련
extension LoginViewController{
    //MARK: - 모달 실행시 Action
    private func addDim() {
        view.addSubview(bgView)
        bgView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalToSuperview()
        }
        DispatchQueue.main.async { [weak self] in
            self?.bgView.alpha = 0.1
            self?.navigationController?.navigationBar.backgroundColor = self?.bgView.backgroundColor?.withAlphaComponent(0.1)
        }
    }
    //모달 취소시 Action
    private func removeDim() {
        DispatchQueue.main.async { [weak self] in
            self?.bgView.removeFromSuperview()
            self?.navigationController?.navigationBar.backgroundColor = .clear
        }
    }
    //MARK: - ManagerModal Action
    private func ManagerModalBtnClick(){
        navigationController?.pushViewController(ManagerViewController(), animated: true)
        navigationController?.isNavigationBarHidden = false
    }
    //MARK: - GoogleOAuthModal Action
    private func GoogleOAuthModalBtnClickAction(){
        navigationController?.pushViewController(MainTabbarController(), animated: true)
        navigationController?.isNavigationBarHidden = false
    }
}

extension LoginViewController : ManagerModalDelegate{
    func updateManagerModal() {
        self.removeDim()
        self.ManagerModalBtnClick()
    }
    
    func onTapManagerModalClose() {
        self.removeDim()
    }
}

extension LoginViewController : GoogleOauthModalDelegate{
    func GoogleOauthModalBtnClick() {
        self.removeDim()
        self.GoogleOAuthModalBtnClickAction()
    }
    
    func onTapClose() {
        self.removeDim()
    }
}
