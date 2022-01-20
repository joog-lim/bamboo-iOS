//
//  ReportModalVc.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/10/28.
//
import UIKit
import PanModal
import RxSwift
import RxCocoa
import RxFlow

final class ReportModal : baseVC<ReportReactor>{
    
    private let editContentTitle = UILabel().then{
        $0.font = UIFont(name: "NanumSquareRoundB", size: 14)
        $0.text = "신고하기"
        $0.textColor = .systemRed
    }
    private let titleTf = AlertTextField(placeholder: nil, fontSize: 11).then{
        $0.text = "알고리즘을 신고합니다"
        $0.isEnabled = false
    }
    private let contentTv = AlertTextView(placeholder: "사유를 입력해주세요.\nex) 욕설이 들어가있어요.",fontSize: 11)
    
    private let reportBtn = UIButton().then{
        $0.titleLabel?.font = UIFont(name: "NanumSquareRoundR", size: 13)
        $0.setTitle("신고하기", for: .normal)
        $0.setTitleColor( .white, for: .normal)
        $0.backgroundColor = .systemRed
        $0.layer.cornerRadius = 5
        $0.layer.applySketchShadow(color: .systemRed, alpha: 0.25, x: 1, y: 5, blur: 5, spread: 0)
    }

    //MARK: - Helper
    override func setLayout() {
        super.setLayout()
        if UIDevice.current.isiPhone{
            editContentTitle.snp.makeConstraints{
                $0.top.equalToSuperview().offset(30)
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
            reportBtn.snp.makeConstraints {
                $0.left.right.equalToSuperview().inset(bounds.width/15.625)
                $0.height.equalTo(bounds.height/23.2)
                $0.top.equalTo(contentTv.snp.bottom).offset(bounds.height/40.6)
            }
        }else if UIDevice.current.isiPad{
            editContentTitle.snp.makeConstraints{
                $0.top.equalToSuperview().offset(30)
                $0.left.equalToSuperview().offset(bounds.width/15.625)
            }
            titleTf.snp.makeConstraints {
                $0.top.equalTo(editContentTitle.snp.bottom).offset(20)
                $0.left.right.equalToSuperview().inset(bounds.width/15.625)
                $0.height.equalTo(bounds.height/27.0666)
            }
            contentTv.snp.makeConstraints {
                $0.top.equalTo(titleTf.snp.bottom).offset(15)
                $0.left.right.equalToSuperview().inset(bounds.width/15.625)
                $0.height.equalTo(120)
            }
            reportBtn.snp.makeConstraints {
                $0.left.right.equalToSuperview().inset(bounds.width/15.625)
                $0.height.equalTo(40)
                $0.top.equalTo(contentTv.snp.bottom).offset(bounds.height/40.6)
            }
        }
    }
    
    override func addView() {
        super.addView()
        view.addSubviews(editContentTitle,titleTf,contentTv,reportBtn)
    }

    //MARK: - KeyboardDown
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    override func bindView(reactor: ReportReactor) {
        reportBtn.rx.tap
            .map{ Reactor.Action.reportBtnTap(reason: self.contentTv.tvContent ?? "")}
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
}
//MARK: - panModal Setting
extension ReportModal : PanModalPresentable{
    override var preferredStatusBarStyle: UIStatusBarStyle{return .lightContent}
    var panScrollable: UIScrollView?{return nil}
    var panModalBackgroundColor: UIColor{return .black.withAlphaComponent(0.1)}

    var cornerRadius: CGFloat{return 20}
    
    var longFormHeight: PanModalHeight{
        return .maxHeightWithTopInset(bounds.height/2.8)
    }
    var anchorModalToLongForm: Bool {return false}
    var showDragIndicator: Bool { return false}
}
