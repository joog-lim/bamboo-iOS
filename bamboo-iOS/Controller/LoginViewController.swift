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
        $0.image = UIImage(named: "BAMBOO_splash")
        $0.contentMode = .scaleAspectFill
    }
    private let userBtn = LoginButton(placeholder: "사용자")
    private var popup = ManagerPopUp()
    
    private let ManagerBtn = LoginButton(placeholder: "관리자")
    
    
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
        configureUI()
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
            make.width.equalTo(view.frame.width/1.875)
            make.height.equalTo(view.frame.height/10.61854)
            make.top.equalToSuperview().offset(bounds.height/3.776744)
        }
        btnStackView.snp.makeConstraints { (make) in
            make.height.equalTo(bounds.height/8.55)
            make.bottom.equalToSuperview().inset(bounds.height/5.5616)
            make.left.right.equalToSuperview().inset(bounds.width/18.75)
        }
    }
}

//MARK: - Preview
#if DEBUG
import SwiftUI
struct LoginViewControllerRepresentable: UIViewControllerRepresentable {
    
func updateUIViewController(_ uiView: UIViewController,context: Context) {
        // leave this empty
}
    @available(iOS 13.0.0, *)
    func makeUIViewController(context: Context) -> UIViewController{
        LoginViewController()

    }

}
@available(iOS 13.0, *)
struct LoginViewControllerRepresentable_PreviewProvider: PreviewProvider {
    static var previews: some View {
        Group {
            LoginViewControllerRepresentable()
                .ignoresSafeArea()
                .previewDisplayName(/*@START_MENU_TOKEN@*/"Preview"/*@END_MENU_TOKEN@*/)
                .previewDevice(PreviewDevice(rawValue: "iPhone 11"))
        }
        
    }
} #endif



