//
//  LoginViewController.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/09/08.
//

import UIKit
import SnapKit
import Then

class LoginViewController : UIViewController {
    //MARK: - Bound Setting
    let bounds = UIScreen.main.bounds
    
    //MARK: - Properties
    private let logo = UIImageView().then{
        $0.image = UIImage(named: "BAMBOO_Logo")
        $0.contentMode = .scaleAspectFill
    }
    private let userBtn = LoginButton(placeholder: "사용자").then{
        $0.layer.applySketchShadow(color: .rgb(red: 87, green: 204, blue: 77), alpha: 0.25, x: 1, y: 5, blur: 5, spread: 0)
        $0.addTarget(self, action: #selector(ClickUserBtn), for: .touchUpInside)
    }
    private var popup = ManagerPopUp().then{
        $0.alpha = 0
    }
    
    private let ManagerBtn = LoginButton(placeholder: "관리자").then{
        $0.layer.applySketchShadow(color: .rgb(red: 87, green: 204, blue: 77), alpha: 0.25, x: 1, y: 5, blur: 5, spread: 0)
        $0.addTarget(self, action: #selector(ClickManagerBtn), for: .touchDown)
    }
    
    
    private lazy var btnStackView : UIStackView = {
        let stack = UIStackView(arrangedSubviews: [userBtn,ManagerBtn])
        stack.axis = .vertical
        stack.backgroundColor = .clear
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        ManagerPopUp().WritePassWorld.delegate = self
        keyboardSetting()
        configureUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
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
        popup.isHidden = false
    }
    @objc func ClickUserBtn(){
        navigationController?.pushViewController(MainTabbar(), animated: true)
        navigationController?.isNavigationBarHidden = false
    }
    @objc func popupClose(){
        UIView.animate(withDuration: 0.3) {
            self.popup.alpha = 0
        }
        popup.isHidden = true
    }
    
    //MARK: - Helper

    func configureUI(){
        stackViewSetting()
        addView()
        location()
    }
    func stackViewSetting(){
        btnStackView.spacing = view.frame.height/54.13333
    }
    func addView(){
        view.addSubview(logo)
        view.addSubview(btnStackView)
        view.addSubview(popup)
    }
    func location(){
        logo.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.height.equalTo(bounds.height/11.768)
            make.width.equalTo(bounds.width/2.30)
            make.top.equalToSuperview().offset(bounds.height/3.776744)
        }
        btnStackView.snp.makeConstraints { (make) in
            make.height.equalTo(bounds.height/8.55)
            make.bottom.equalToSuperview().inset(bounds.height/5.5616)
            make.left.right.equalToSuperview().inset(bounds.width/18.75)
        }
        popup.snp.makeConstraints { (make) in
            make.height.equalTo(view.frame.height)
            make.top.right.bottom.left.equalToSuperview()
        }
    }
    //MARK: - KeyboardSetting
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    func keyboardSetting(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}
extension LoginViewController : UITextFieldDelegate{
    
}
