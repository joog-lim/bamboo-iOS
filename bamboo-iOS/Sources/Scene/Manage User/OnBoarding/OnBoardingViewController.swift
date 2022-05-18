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
import PinLayout
import FlexLayout

final class OnBoardingViewController: BaseVC<OnBoardingReactor>{
    //MARK: - Properties
    private let flexContainer = UIView()
    private let logo = UIImageView(image: UIImage(named: "BAMBOO_Logo"),contentMode: .scaleAspectFit)
    private let userLoginButton = LoginButton(placeholder: "사용자", cornerRadius: 15,font: UIFont.systemFont(ofSize: 10))
    private let managerBtn = LoginButton(placeholder: "관리자", cornerRadius: 15,font:  UIFont.systemFont(ofSize: 10))
    private let divider = UIView(frame: CGSize(width: 300, height: 0.5), backgroundColor: .lightGray)
    private let guestBtn = UIButton(title: "게스트로 사용하기", font: UIFont.systemFont(ofSize: 14), titleColor: .lightGray)
    
    //MARK: - Method
    override func configureUI() {
        
        
    }
    
    override func addView() {
        view.addSubview(flexContainer)
    }
    
    override func setLayout() {
//        flexContainer.pin.all(self.pin.safeArea)
        
    }
    
    //MARK: - Bind
}
