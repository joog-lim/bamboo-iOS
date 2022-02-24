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
        $0.text = "Email 인증"
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
        $0.shouldAllowIntermediateEditing = false
    }
    private let countLabel = UILabel().then{
        $0.font = UIFont(name: "NanumSquareRoundR", size: 13)
        $0.textColor = .bamBoo_57CC4D
    }
    private let refreshOTPBtn = UIButton(type: .system).then{
        $0.setTitle("인증번호 재전송", for: .normal)
        $0.setTitleColor(.gray, for: .normal)
        $0.titleLabel?.font  = UIFont(name: "NanumSquareRoundR", size: 13)
    }
    //MARK: - LifeCycle
    override func configureUI() {
        super.configureUI()
        otpInputView.delegate = self
        otpInputView.fieldSize = bounds.width/6.7
        otpInputView.separatorSpace = bounds.width/13.89
        otpInputView.initializeUI()
    }
    
    override func addView() {
        super.addView()
        view.addSubviews(titleLabel,contentLabel,otpInputView,backBar,countLabel,refreshOTPBtn)
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
            $0.edges.equalToSuperview()
        }
        countLabel.snp.makeConstraints{
            $0.bottom.equalToSuperview().inset(bounds.height/2.5)
            $0.left.equalTo(contentLabel)
        }
        refreshOTPBtn.snp.makeConstraints{
            $0.top.equalTo(countLabel.snp.top)
            $0.right.equalToSuperview().inset(20)
        }
    }
    
    //MARK: - Bind
    override func bindView(reactor: OTPModalReactor) {
        self.backBar.backBtn.rx.tap
            .map{ Reactor.Action.backBtnRequired}
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        self.refreshOTPBtn.rx.tap
            .map{Reactor.Action.refreshOTPBtnRequired}
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    override func bindAction(reactor: OTPModalReactor) {
        self.rx.viewWillAppear
            .map{ Reactor.Action.viewWillAppear}
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    override func bindState(reactor: OTPModalReactor) {
        reactor.state.observe(on: MainScheduler.instance)
            .subscribe(onNext:{ [weak self]  in
                if $0.time ?? 0 == 0{
                    self?.countLabel.text = "메일 인증이 만료되었습니다."
                }else{
                    self?.countLabel.text = "\($0.minute ?? 0)분 \($0.second ?? 0)초"
                }
            }).disposed(by: disposeBag)
    }
}
extension OTPModalVC: OTPFieldViewDelegate {

    func hasEnteredAllOTP(hasEnteredAll hasEntered: Bool) -> Bool {
        print("Has entered all OTP? \(hasEntered)")
        return false
    }
    
    func shouldBecomeFirstResponderForOTP(otpTextFieldIndex index: Int) -> Bool {
        return true
    }
    
    func enteredOTP(otp otpString: String) {
        reactor?.action.onNext(.sendOTPBtnRequired(otpString))
    }
}
