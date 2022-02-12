//
//  BulletinBoardsTableViewHeaderView.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2022/01/10.
//

import UIKit
import RxSwift
import Reusable

final class BulletinBoardsTableViewHeaderView : BaseTableViewHeaderFooterView<Void>{
    private let titleLabel = UILabel().then{
        let string : NSMutableAttributedString = NSMutableAttributedString(string: "하고 싶던 말,\n무엇인가요?")
        $0.font = UIFont(name: "NanumSquareRoundB", size: 20)
        $0.textColor = .bamBoo_57CC4D
        $0.numberOfLines = 2
        string.setColorForText(textToFind: "무엇인가요?", withColor: .black)
        $0.attributedText = string
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
