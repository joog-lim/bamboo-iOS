//
//  NoWifiAlertView.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2022/01/05.
//

import UIKit

class NoWifiAlertView: UIView{
    //MARK: - Views
    private let titleLabel = UILabel().then{
        $0.text = "인터넷 연결이 끊겼습니다."
        $0.textColor = .black
        $0.font = UIFont(name: "", size: 12)
    }
    //MARK: - initalizer
    init(){
        super.init(frame: .zero)
        setupView()
    }
    @available(* , unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Helper
    private func setupView(){
        backgroundColor = .white
        layer.applySketchShadow(color: .black, alpha: 0.2, x: 0, y: 4, blur: 10, spread: 0)
        layoutlabel()
    }
    private func layoutlabel(){
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints{
            $0.center.equalToSuperview()
        }
    }
}
