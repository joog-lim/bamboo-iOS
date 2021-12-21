//
//  RefusalModal.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/10/26.
//

import UIKit
import RxSwift
import PanModal

class RefusalModal : baseVC<RefusalModalReactor>{
    //MARK: - Delegate
    private var i = 10
    
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
    
    //MARK: - Helper
    override func configureUI() {
        super.configureUI()
        contentTv.delegate = self
    }
    
    override func addView() {
        super.addView()
        [editContentTitle,refusaleditTitle,contentTv,refusalBtn].forEach{ view.addSubview($0)}
    }
    
    override func setLayout() {
        super.setLayout()
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

extension RefusalModal : PanModalPresentable{
    var panScrollable: UIScrollView? {return nil}
    var panModalBackgroundColor: UIColor{return .black.withAlphaComponent(0.1)}
    var cornerRadius: CGFloat{return 20}
    var longFormHeight: PanModalHeight {return .contentHeight(bounds.height/3)}
    var shortFormHeight: PanModalHeight{return .contentHeight(bounds.height/2)}
    var anchorModalToLongForm: Bool {return false}
    var shouldRoundTopCorners: Bool {return true}
    var showDragIndicator: Bool { return false}
}
