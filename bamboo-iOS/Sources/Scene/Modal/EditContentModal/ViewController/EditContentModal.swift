//
//  EditContentModal.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/10/24.
//

import UIKit

class EditContentModal : BaseVC{
    
    weak var delegate : EditContentModalProtocol?
    
    private let transparentView = UIView()
    
    private let bgView = UIView().then{
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 40
    }
    private let editContentTitle = UILabel().then{
        $0.font = UIFont(name: "NanumSquareRoundB", size: 16)
        $0.text = "수정하기"
        $0.textColor = .bamBoo_57CC4D
    }
    private let titleTf = AlertTextField(placeholder: "제목을 입력하세요", fontSize: 10)
    private let contentTv = AlertTextView(placeholder: "내용을 입력하세요",fontSize: 10)
    
    override func configure() {
        super.configure()
        addView()
        location()
    }
    //MARK: - location
    private func location(){
        
    }
    //MARK: - addsubView
    private func addView(){
        [editContentTitle,titleTf,contentTv].forEach{view.addSubview($0)}
    }
}

