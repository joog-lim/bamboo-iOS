//
//  EditContentModal.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/10/24.
//

import UIKit

protocol EditContentModalProtocol : AnyObject{
    func onTapClose()
}

class EditContentModal : BaseModal{
    
    weak var delegate : EditContentModalProtocol?
        
    private let bgView = UIView().then{
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 20
    }
    private let editContentTitle = UILabel().then{
        $0.font = UIFont(name: "NanumSquareRoundB", size: 14)
        $0.text = "수정하기"
        $0.textColor = .bamBoo_57CC4D
    }
    private let titleTf = AlertTextField(placeholder: "제목을 입력하세요", fontSize: 11)
    private let contentTv = AlertTextView(placeholder: "내용을 입력하세요",fontSize: 11)
    private let editBtn = UIButton().then{
        $0.titleLabel?.font = UIFont(name: "NanumSquareRoundR", size: 13)
        $0.setTitle("수정", for: .normal)
        $0.setTitleColor( .white, for: .normal)
        $0.backgroundColor = .bamBoo_57CC4D
        $0.layer.cornerRadius = 5
    }
    private let cancelBtn = UIButton().then{
        $0.titleLabel?.font = UIFont(name: "NanumSquareRoundR", size: 13)
        $0.backgroundColor = .lightGray
        $0.setTitle("취소", for: .normal)
        $0.setTitleColor( .white, for: .normal)
        $0.layer.cornerRadius = 5
    }
    private lazy var btnStackView = UIStackView(arrangedSubviews: [editBtn,cancelBtn]).then{
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = bounds.width/75
    }
    
    //모달 위치 조정
    static func instance() -> EditContentModal{
        return EditContentModal(nibName: nil, bundle: nil).then{
            $0.modalPresentationStyle = .overFullScreen
        }
    }
    //MARK: - Helper
    override func modalSetting() {
        super.modalSetting()
        contentTv.delegate = self
        addView()
        location()
    }
    
    //MARK: - location
    private func location(){
        bgView.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.bottom.equalToSuperview().offset(30)
            $0.height.equalToSuperview().dividedBy(2.5)
        }
        editContentTitle.snp.makeConstraints{
            $0.top.equalToSuperview().offset(bounds.height/27.0666)
            $0.left.equalToSuperview().offset(bounds.width/15.625)
        }
        titleTf.snp.makeConstraints {
            $0.top.equalTo(editContentTitle.snp.bottom).offset(bounds.height/81.2)
            $0.left.right.equalToSuperview().inset(bounds.width/15.625)
            $0.height.equalTo(bounds.height/27.0666)
        }
        contentTv.snp.makeConstraints {
            $0.top.equalTo(titleTf.snp.bottom).offset(bounds.height/81.2)
            $0.left.right.equalToSuperview().inset(bounds.width/15.625)
            $0.height.equalTo(bounds.height/8.12)
        }
        btnStackView.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(bounds.width/15.625)
            $0.height.equalTo(bounds.height/23.2)
            $0.top.equalTo(contentTv.snp.bottom).offset(bounds.height/40.6)
        }
    }
    //MARK: - addsubView
    private func addView(){
        [bgView].forEach { view.addSubview($0)}
        [editContentTitle,titleTf,contentTv,btnStackView].forEach{bgView.addSubview($0)}
    }
    //MARK: - KeyboardDown
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
}

extension EditContentModal : UITextViewDelegate{
    // TextView Place Holder
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "내용을 입력하세요."
            textView.textColor = UIColor.rgb(red: 196, green: 196, blue: 196)
        }
    }
    // TextView Place Holder
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.rgb(red: 196, green: 196, blue: 196) {
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
}
