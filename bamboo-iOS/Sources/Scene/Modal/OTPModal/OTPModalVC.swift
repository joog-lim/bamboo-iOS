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
import OTPFieldView

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
    private let otpInputView = OTPFieldView().then{
        $0.fieldsCount = 4
        $0.fieldBorderWidth = 2
        $0.defaultBorderColor = .black
        $0.filledBorderColor = .bamBoo_57CC4D
        $0.cursorColor = .bamBoo_57CC4D
        $0.displayType = .underlinedBottom
        $0.fieldSize = 40
        $0.separatorSpace = 8
        $0.shouldAllowIntermediateEditing = false

    }
    
    //MARK: - LifeCycle
    override func configureUI() {
        super.configureUI()
        otpInputView.delegate = self
        otpInputView.initializeUI()
    }
    
    override func addView() {
        super.addView()
        view.addSubviews(backBar,titleLabel,contentLabel,otpInputView)
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
        otpInputView.snp.makeConstraints{
            $0.top.equalTo(contentLabel.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
            $0.left.right.equalToSuperview()
            $0.height.equalTo(200)
        }
    }
    
    //MARK: - Bind
    override func bindView(reactor: OTPModalReactor) {

    }
}
extension OTPModalVC: OTPFieldViewDelegate {
    func deletedOTP() {
        print("no")
    }
    
    func hasEnteredAllOTP(hasEnteredAll hasEntered: Bool) -> Bool {
        print("Has entered all OTP? \(hasEntered)")
        return false
    }
    
    func shouldBecomeFirstResponderForOTP(otpTextFieldIndex index: Int) -> Bool {
        return true
    }
    
    func enteredOTP(otp otpString: String) {
        print("OTPString: \(otpString)")
    }
}
