//
//  ReportModalVc.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/10/28.
//

import UIKit

protocol ReportModalDelegate : AnyObject {
    func updateReport()
}

class ReportModal : BaseModal{
    
    weak var delegate : ReportModalDelegate?
        
    private let bgView = UIView().then{
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 20
    }
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
    
    //모달 위치 조정
    static func instance() -> ReportModal{
        return ReportModal(nibName: nil, bundle: nil).then{
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
    
    //MARK: - location
    private func location(){
        if UIDevice.current.isiPhone{
            bgView.snp.makeConstraints {
                $0.left.equalToSuperview()
                $0.right.equalToSuperview()
                $0.bottom.equalToSuperview().offset(30)
                $0.height.equalTo(bounds.height/2.5)
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
            reportBtn.snp.makeConstraints {
                $0.left.right.equalToSuperview().inset(bounds.width/15.625)
                $0.height.equalTo(bounds.height/23.2)
                $0.top.equalTo(contentTv.snp.bottom).offset(bounds.height/40.6)
            }
        }else if UIDevice.current.isiPad{
            bgView.snp.makeConstraints {
                $0.left.equalToSuperview()
                $0.right.equalToSuperview()
                $0.bottom.equalToSuperview().offset(30)
                $0.height.equalTo(380)
            }
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
    //MARK: - addsubView
    private func addView(){
        view.addSubview(bgView)
        [editContentTitle,titleTf,contentTv,reportBtn].forEach{bgView.addSubview($0)}
    }

    //MARK: - KeyboardDown
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
}

extension ReportModal : UITextViewDelegate{
    // TextView Place Holder
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "사유를 입력해주세요.\nex) 욕설이 들어가있어요."
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
