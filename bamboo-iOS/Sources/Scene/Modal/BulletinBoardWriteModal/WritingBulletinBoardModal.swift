//
//  WritingBulletinBoardModal.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/09/28.
//

import UIKit
import SnapKit
import PanModal
import DropDown

import RxSwift
import RxCocoa
import RxFlow
import RxKeyboard

final class WritingBulletinBoardModal: baseVC<WritingBulletinBoardReactor>{
    
    //MARK: - Properties
    private let dropDown = DropDown().then{
        $0.dataSource = ["유머","공부","일상","학교","취업","관계","기타"]
        $0.backgroundColor = .white
        $0.selectionBackgroundColor = .clear
        $0.layer.borderColor = UIColor.clear.cgColor
        $0.textFont = UIFont(name: "NanumSquareRoundB", size: 12) ?? UIFont()
        $0.cellHeight = 29
        $0.shadowOpacity = 0.25
        $0.cornerRadius = 10
    }
    private let titleLabel = UILabel().then{
        $0.text = "글 입력하기"
        $0.font = UIFont(name: "NanumSquareRoundB", size: 16)
        $0.textColor = .bamBoo_57CC4D
    }
    private let questionTitle = UILabel().then{
        $0.textColor = .black
        $0.text = "올리고 싶은 글을 입력해주세요!"
        $0.font = UIFont(name: "NanumSquareRoundR", size: 12)
    }
    private let titleTf = AlertTextField(placeholder: "제목을 입력하세요.", fontSize: 10)
    private let tagChooseBtn = LoginButton(placeholder: "태그선택", cornerRadius: 5).then{
        $0.titleLabel?.font = UIFont(name: "NanumSquareRoundB", size: 12)
    }
    private let contentTv = AlertTextView(placeholder: "내용을 입력하세요.", fontSize: 10)
    private let passwordTitle = UILabel().then{
        $0.text = "Q. 학교 와이파이 비번은 무엇일까요?"
        $0.textColor = .black
        $0.font = UIFont(name: "NanumSquareRoundR", size: 12)
    }
    private let passwordTf = AlertTextField(placeholder: "답변을 입력하세요.", fontSize: 10)
    private let sendBtn = LoginButton(placeholder: "전송", cornerRadius: 10).then{
        $0.titleLabel?.font = UIFont(name: "NanumSquareRoundR", size: 13)
    }
    //MARK: - StackView
    private lazy var passwordStackView = UIStackView(arrangedSubviews: [passwordTitle,passwordTf]).then{
        $0.axis = .vertical
        $0.spacing = 5
        $0.distribution = .fillEqually
    }
    
    //MARK: - HELPERS
    override func configureUI() {
        super.configureUI()
        //MARK: - TextView Delegate
        dropDown.selectionAction = { [unowned self] (index : Int, item : String) in
            tagChooseBtn.setTitle(item, for: .normal)
        }
    }

    
    //MARK: - AddView
    override func addView() {
        super.addView()
        view.addSubviews(titleLabel,questionTitle,titleTf,tagChooseBtn,contentTv,passwordStackView,sendBtn)
    }
    
    //MARK: - Location
    override func setLayout() {
        super.setLayout()
        iphoneLocation()
        iPadLocation()
        dropDown.anchorView = tagChooseBtn

        questionTitle.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(bounds.height/58)
            $0.left.right.equalToSuperview().inset(bounds.width/15.625)
        }
    }
    
    //MARK: - KeyboardSetting
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    override func bindView(reactor: WritingBulletinBoardReactor) {
        super.bindView(reactor: reactor)
        tagChooseBtn.rx.tap
            .subscribe(onNext:{ [weak self] in
                self?.dropDown.show()
            }).disposed(by: disposeBag)
    }
}

//MARK: - Location
extension WritingBulletinBoardModal{
    //MARK: - iPAD
    private func iPadLocation(){
        if UIDevice.current.isiPad{
            dropDown.bottomOffset = CGPoint(x: 0, y: 40)
            titleLabel.snp.makeConstraints {
                $0.left.equalToSuperview().offset(bounds.width/15.625)
                $0.top.equalToSuperview().offset(24)
            }
            titleTf.snp.makeConstraints{
                $0.top.equalTo(questionTitle.snp.bottom).offset(bounds.height/162.4)
                $0.left.equalToSuperview().offset(bounds.width/15.625)
                $0.right.equalTo(tagChooseBtn.snp.left).inset(bounds.width/75 * -1)
                $0.height.equalTo(30)
            }
            tagChooseBtn.snp.makeConstraints {
                $0.top.equalTo(titleTf)
                $0.right.equalToSuperview().inset(bounds.width/15.625)
                $0.width.equalTo(60)
                $0.height.equalTo(titleTf)
            }
            contentTv.snp.makeConstraints {
                $0.top.equalTo(titleTf.snp.bottom).offset(bounds.height/162.4)
                $0.left.right.equalToSuperview().inset(bounds.width/15.625)
                $0.height.equalTo(154)
            }
            passwordStackView.snp.makeConstraints {
                $0.top.equalTo(contentTv.snp.bottom).offset(bounds.height/50.75)
                $0.left.right.equalToSuperview().inset(bounds.width/15.625)
                $0.height.equalTo(60)
            }
            sendBtn.snp.makeConstraints {
                $0.top.equalTo(passwordStackView.snp.bottom).offset(27)
                $0.left.right.equalToSuperview().inset(bounds.width/15.625)
                $0.height.equalTo(30)
            }
        }
    }
    //MARK: - iPhone
    private func iphoneLocation(){
        if UIDevice.current.isiPhone{
            dropDown.bottomOffset = CGPoint(x: 0, y:bounds.height/27.0666 + 5)
            titleLabel.snp.makeConstraints {
                $0.left.equalToSuperview().offset(bounds.width/15.625)
                $0.top.equalToSuperview().offset(bounds.height/33.8333)
            }
            titleTf.snp.makeConstraints{
                $0.top.equalTo(questionTitle.snp.bottom).offset(bounds.height/162.4)
                $0.left.equalToSuperview().offset(bounds.width/15.625)
                $0.right.equalTo(tagChooseBtn.snp.left).inset(bounds.width/75 * -1)
                $0.height.equalTo(bounds.height/27.0666)
            }
            tagChooseBtn.snp.makeConstraints {
                $0.top.equalTo(titleTf)
                $0.right.equalToSuperview().inset(bounds.width/15.625)
                $0.width.equalTo(bounds.width/5.77)
                $0.height.equalTo(titleTf)
            }
            contentTv.snp.makeConstraints {
                $0.top.equalTo(titleTf.snp.bottom).offset(bounds.height/162.4)
                $0.left.right.equalToSuperview().inset(bounds.width/15.625)
                $0.height.equalTo(bounds.height/7.51851)
            }
            passwordStackView.snp.makeConstraints {
                $0.top.equalTo(contentTv.snp.bottom).offset(bounds.height/50.75)
                $0.left.right.equalToSuperview().inset(bounds.width/15.625)
                $0.height.equalTo(bounds.height/12)
            }
            sendBtn.snp.makeConstraints {
                $0.top.equalTo(passwordStackView.snp.bottom).offset(bounds.height/30.074)
                $0.left.right.equalToSuperview().inset(bounds.width/15.625)
                $0.height.equalTo(bounds.height/20.3)
            }
        }
    }
}

//MARK: - PanModal Setting
extension WritingBulletinBoardModal : PanModalPresentable{
    override var preferredStatusBarStyle: UIStatusBarStyle{return .lightContent}
    var panScrollable: UIScrollView?{return nil}
    var panModalBackgroundColor: UIColor{return .black.withAlphaComponent(0.1)}

    var cornerRadius: CGFloat{return 40}
    
    var longFormHeight: PanModalHeight{
        return .maxHeightWithTopInset(280)
    }
    var anchorModalToLongForm: Bool {return false}
    var showDragIndicator: Bool { return false}
}
