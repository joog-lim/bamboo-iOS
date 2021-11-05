//
//  RefusalModal.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/10/26.
//

import UIKit
import RxSwift

class RefusalModal : BaseModal{
    //MARK: - Delegate
    var i = 10
    
    private let bgView = UIView().then{
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 20
    }
    private let editContentTitle = UILabel().then{
        let string : NSMutableAttributedString = NSMutableAttributedString(string: "알고리즘 거절")
        $0.font = UIFont(name: "NanumSquareRoundB", size: 16)
        $0.textColor = .black
        string.setColorForText(textToFind: "거절", withColor: .systemRed)
        $0.attributedText = string
    }
    private lazy var refusaleditTitle = UILabel().then{
        let string : NSMutableAttributedString = NSMutableAttributedString(string: "#\(i)번째 알고리즘을 거절합니다.")
        $0.font = UIFont(name: "NanumSquareRoundR", size: 13)
        $0.textColor = .black
        string.setColorForText(textToFind: "#\(i)번째 알고리즘", withColor: .systemRed)
        $0.attributedText = string
    }
    private let contentTv = AlertTextView(placeholder: "사유를 입력해주세요",fontSize: 11)
    
    private let refusalBtn = UIButton().then{
        $0.backgroundColor = .systemRed
        $0.setTitle("거절하기", for: .normal)
        $0.layer.cornerRadius = 5
        $0.layer.applySketchShadow(color: .systemRed, alpha: 0.25, x: 1, y: 5, blur: 5, spread: 0)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont(name: "NanumSquareRoundB", size: 15)
    }
    //모달 위치 조정
    static func instance() -> RefusalModal{
        return RefusalModal(nibName: nil, bundle: nil).then{
            $0.modalPresentationStyle = .overFullScreen
        }
    }
    
    //MARK: - Helper
    
    override func modalSetting() {
        super.modalSetting()
        view.backgroundColor = .clear
        contentTv.delegate = self
        addView()
        location()
    }
    
    //MARK: - AddSubView
    private func addView(){
        [bgView].forEach{view.addSubview($0)}
        [editContentTitle,refusaleditTitle,contentTv,refusalBtn].forEach{ bgView.addSubview($0)}
    }
    //MARK: - Location
    private func location(){
        bgView.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.bottom.equalToSuperview().offset(30)
            $0.height.equalToSuperview().dividedBy(2.5)
        }
        editContentTitle.snp.makeConstraints{
            $0.top.equalToSuperview().offset(bounds.height/28)
            $0.left.equalToSuperview().offset(bounds.width/15.625)
        }
        refusaleditTitle.snp.makeConstraints{
            $0.top.equalTo(editContentTitle.snp.bottom).offset(bounds.height/81.2)
            $0.left.equalTo(editContentTitle)
        }
        contentTv.snp.makeConstraints{
            $0.top.equalTo(refusaleditTitle.snp.bottom).offset(bounds.height/40.6)
            $0.left.right.equalToSuperview().inset(bounds.width/15.625)
            $0.height.equalTo(bounds.height/6.7)
        }
        refusalBtn.snp.makeConstraints{
            $0.top.equalTo(contentTv.snp.bottom).offset(bounds.height/40.6)
            $0.height.equalTo(bounds.height/23.2)
            $0.left.right.equalToSuperview().inset(bounds.width/15.625)
        }
    }

    //MARK: - keyboard down
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }

}

extension RefusalModal : UITextViewDelegate{
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
