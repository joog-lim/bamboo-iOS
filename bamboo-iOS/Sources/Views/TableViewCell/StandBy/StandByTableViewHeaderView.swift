//
//  StandByTableViewHeaderView.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2022/01/24.
//
import UIKit

final class StandByTableViewHeaderView : BaseTableViewHeaderFooterView<Void>{
    private let titleLabel = UILabel().then{
        $0.font = UIFont(name: "NanumSquareRoundB", size: 20)
        $0.text = "대기"
        $0.textColor = .systemYellow
    }
    override func configure() {
        super.configure()
        addView()
        makeConstraints()
    }
    private func addView(){
        contentView.addSubviews(titleLabel)
    }
    
    private func makeConstraints(){
        titleLabel.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().offset(20)
        }
    }
}
