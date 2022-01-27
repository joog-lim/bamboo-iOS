//
//  RefusalModal.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/10/26.
//

import UIKit
import RxSwift
import PanModal

final class RefusalModal : baseVC<RefusalModalReactor>{
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
        $0.textColor = .red
        string.setColorForText(textToFind: "을 거절합니다", withColor: .black)
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
    override func addView() {
        super.addView()
        view.addSubviews(editContentTitle,refusaleditTitle,contentTv,refusalBtn)
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
    override func bindView(reactor: RefusalModalReactor) {
        refusalBtn.rx.tap
            .map{ Reactor.Action.refusalBtnTap(reason: self.contentTv.tvContent ?? "")}
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
}

extension RefusalModal : PanModalPresentable{
    override var preferredStatusBarStyle: UIStatusBarStyle{return .lightContent}
    var panScrollable: UIScrollView?{return nil}
    var panModalBackgroundColor: UIColor{return .black.withAlphaComponent(0.1)}

    var cornerRadius: CGFloat{return 40}
    
    var longFormHeight: PanModalHeight{
        return .maxHeightWithTopInset(250)
    }
    var anchorModalToLongForm: Bool {return false}
    var showDragIndicator: Bool { return false}
}
