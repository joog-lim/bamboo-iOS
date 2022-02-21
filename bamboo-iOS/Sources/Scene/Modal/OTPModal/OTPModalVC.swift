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
    private let backBar = LoginBar()

    private let titleLabel = UILabel().then{
        $0.text = "OTP"
        $0.font = UIFont(name: "NanumSquareRoundR", size: 20)
        $0.textColor = .bamBoo_57CC4D
    }
    private let contentLabel = UILabel().then{
        $0.numberOfLines = 0
        $0.text = "이메일로 발송된 번호를 \n입력해주세요!"
        $0.font = UIFont(name: "NanumSquareRoundR", size: 12)
        $0.textColor = .gray
    }
    //MARK: - LifeCycle
    override func addView() {
        super.addView()
        view.addSubviews(backBar,titleLabel,contentLabel)
    }
    override func setLayout() {
        super.setLayout()
        backBar.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(bounds.height/40)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(50)
        }
        titleLabel.snp.makeConstraints{
            $0.top.equalTo(backBar.snp.bottom).offset(bounds.height/40)
            $0.left.equalToSuperview().offset(20)
        }
        contentLabel.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(bounds.height/43)
            $0.left.equalTo(titleLabel.snp.left)
        }
    }
    
    //MARK: - Bind
    override func bindView(reactor: OTPModalReactor) {

    }
}
