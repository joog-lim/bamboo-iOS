//
//  EmailWriteVC.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2022/02/24.
//

import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa
import ReactorKit
import RxKeyboard

final class EmailWriteVC : baseVC<EmailWriteReactor>{
    //MARK: - Properties
    private let backBar = LoginBar()
    
    private let titleLabel = UILabel().then{
        $0.text = "Email 작성"
        $0.font = UIFont(name: "NanumSquareRoundR", size: 20)
        $0.textColor = .bamBoo_57CC4D
    }
    private let contentLabel = UILabel().then{
        $0.numberOfLines = 0
        $0.text = "학교 이메일을 적어주세요!"
        $0.font = UIFont(name: "NanumSquareRoundR", size: 12)
        $0.textColor = .gray
    }
    private let tfTitleLabel = UILabel().then{
        $0.text = "Email"
        $0.font = UIFont(name: "NanumSquareRoundR", size: 10)
        $0.textColor = .bamBoo_57CC4D
    }
    private let titleTf = AlertTextField(placeholder: "제목을 입력하세요.", fontSize: 10)
    
    private let sendBtn = LoginButton(placeholder: "Next", cornerRadius: 15)
    //MARK: - LifeCycle
    override func addView() {
        super.addView()
        view.addSubviews(backBar, titleLabel,contentLabel,tfTitleLabel,titleTf,sendBtn)
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
        tfTitleLabel.snp.makeConstraints{
            $0.bottom.equalTo(titleTf.snp.top).inset(-10)
            $0.left.equalTo(titleTf)
        }
        titleTf.snp.makeConstraints{
            $0.center.equalToSuperview()
            $0.height.equalTo(bounds.height/27)
            $0.left.right.equalToSuperview().inset(20)
        }
        sendBtn.snp.makeConstraints{
            $0.bottom.equalToSuperview().inset(bounds.height/5)
            $0.height.equalTo(bounds.height/16.24)
            $0.left.right.equalTo(titleTf)
        }
    }
    //MARK: - Keyboard Setting
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    //MARK: - Bind
    override func bindView(reactor: EmailWriteReactor) {
        sendBtn.rx.tap
            .map{ Reactor.Action.sendEmail(self.titleTf.text ?? "")}
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
}
