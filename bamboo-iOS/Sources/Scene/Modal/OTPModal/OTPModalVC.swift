//
//  OTPModalVC.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2022/02/22.
//

import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa
import RxGesture
import ReactorKit
import RxKeyboard

final class OTPModalVC : baseVC<OTPModalReactor>{
    
    //MARK: - Properties
    private let titleLabel = UILabel().then{
        $0.text = "인증번호 인증"
        $0.font = UIFont(name: "NanumSquareRoundR", size: 10)
        $0.textColor = .rgb(red: 196, green: 196, blue: 196)
    }
    //MARK: - LifeCycle
    override func addView() {
        super.addView()
        view.addSubviews(titleLabel)
    }
    override func setLayout() {
        super.setLayout()

        titleLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(20)
            $0.centerX.equalToSuperview()
        }
    }
    
    //MARK: - Bind
    override func bindView(reactor: OTPModalReactor) {

    }
}
