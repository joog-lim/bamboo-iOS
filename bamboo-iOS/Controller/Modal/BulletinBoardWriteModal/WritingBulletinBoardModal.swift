//
//  WritingBulletinBoardModal.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/09/28.
//

import UIKit
import SnapKit

protocol WriteModalDelegate : class{
    func onTapClose()
}
class WritingBulletinBoardModal: UIViewController{
    
    //MARK: - Properties
    let bounds = UIScreen.main.bounds
    
    weak var delegate : WriteModalDelegate?
    
    private let bgView = UIView().then{
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 40
    }
    
    let transparentView = UIView()
    
    private let titleLabel = UILabel().then{
        $0.text = "글 입력하기"
        $0.dynamicFont(fontSize: 16, currentFontName: "NanumSquareRoundB")
        $0.textColor = .bamBoo_57CC4D
    }
    private let questionTitle = UILabel().then{
        $0.textColor = .black
        $0.text = "올리고 싶은 글을 입력해주세요!"
        $0.dynamicFont(fontSize: 12, currentFontName: "NanumSquareRoundR")
    }
    private let titleTf = AlertTextField(placeholder: "제목을 입력하세요.", fontSize: 10)
    private let tagChooseBtn = LoginButton(placeholder: "태그선택", cornerRadius: 5).then{
        $0.label.dynamicFont(fontSize: 12, currentFontName: "NanumSquareRoundB")
    }
    private let contentTv = AlertTextView(placeholder: "내용을 입력하세요.")
    
    private let passwordTitle = UILabel().then{
        $0.text = "Q. 학교 와이파이 비번은 무엇일까요?"
        $0.textColor = .black
        $0.dynamicFont(fontSize: 12, currentFontName: "NanumSquareRoundR")
    }
    private let passwordTf = AlertTextField(placeholder: "답변을 입력하세요.", fontSize: 10)
    
    private let sendBtn = LoginButton(placeholder: "전송", cornerRadius: 10).then{
        $0.addTarget(self, action: #selector(sendTapClose), for: .touchUpInside)
    }
    
    
    //MARK: - StackView
    private lazy var titleStackView = UIStackView(arrangedSubviews: [titleTf,tagChooseBtn]).then{
        $0.axis = .horizontal
        $0.distribution = .fill
        $0.spacing = 5
    }
    private lazy var writeContentStackView = UIStackView(arrangedSubviews: [titleStackView,contentTv]).then{
        $0.spacing = 5
        $0.axis = .vertical
        $0.distribution = .fill
    }
    private lazy var passwordStackView = UIStackView(arrangedSubviews: [passwordTitle,passwordTf]).then{
        $0.axis = .vertical
        $0.spacing = 5
        $0.distribution = .fillProportionally
    }

    
    
    //모달 위치 조정
    static func instance() -> WritingBulletinBoardModal{
        return WritingBulletinBoardModal(nibName: nil, bundle: nil).then{
            $0.modalPresentationStyle = .overFullScreen
        }
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    //MARK: - Selectors
    @objc func onTapClose() {
        delegate?.onTapClose()
        dismiss(animated: true, completion: nil)
    }
    @objc func sendTapClose(){
        delegate?.onTapClose()
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: - HELPERS
    private func configureUI(){
        contentTv.delegate = self
        addView()
        location()
        StackViewSizing()
        addTransparentsview(frame: transparentView.frame)
    }
    private func addView(){
        view.addSubview(transparentView)
        view.addSubview(bgView)
        bgView.addSubview(titleLabel)
        bgView.addSubview(questionTitle)
        bgView.addSubview(writeContentStackView)
        bgView.addSubview(passwordStackView)
        bgView.addSubview(sendBtn)
    }
    private func location(){
        bgView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(30)
            make.height.equalToSuperview().dividedBy(1.75)
        }
        titleLabel.snp.makeConstraints {
            $0.left.top.equalToSuperview().offset(bounds.height/33.83)
        }
        questionTitle.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(bounds.height/58)
            make.left.right.equalToSuperview().inset(bounds.width/15.625)
        }
        writeContentStackView.snp.makeConstraints { make in
            make.top.equalTo(questionTitle.snp.bottom).offset(bounds.height/162.4)
            make.left.right.equalToSuperview().inset(bounds.width/15.625)
            make.height.equalTo(bounds.height/5)
        }
        passwordStackView.snp.makeConstraints { make in
            make.top.equalTo(writeContentStackView.snp.bottom).offset(bounds.height/50.75)
            make.left.right.equalToSuperview().inset(bounds.width/15.625)
            make.height.equalTo(bounds.height/16.9166)
        }
        sendBtn.snp.makeConstraints { make in
            make.top.equalTo(passwordStackView.snp.bottom).offset(bounds.height/30.074)
            make.left.right.equalToSuperview().inset(bounds.width/15.625)
            make.height.equalTo(bounds.height/20.3)        }
        
    }
    //MARK: - StackView 사이즈
    private func StackViewSizing(){
        tagChooseBtn.snp.makeConstraints { make in
            make.width.equalTo(bounds.width/5.77)
            make.height.equalTo(bounds.height/27.0666)
        }
        passwordTf.snp.makeConstraints { make in
            make.height.equalTo(bounds.height/27.0666)
        }
    }
    
    
    private func addTransparentsview(frame : CGRect){
        let window = UIApplication.shared.keyWindow
        transparentView.frame = window?.frame ?? self.view.frame
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(onTapClose))
        transparentView.addGestureRecognizer(tapgesture)
    }
    
}

//MARK: - TextView extension
extension WritingBulletinBoardModal : UITextViewDelegate{
        
        // TextView Place Holder
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.rgb(red: 196, green: 196, blue: 196) {
            textView.text = ""
            textView.textColor = UIColor.black
        }
            
    }
        // TextView Place Holder
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "내용을 입력하세요."
            textView.textColor = UIColor.rgb(red: 196, green: 196, blue: 196)
        }
    }
}
