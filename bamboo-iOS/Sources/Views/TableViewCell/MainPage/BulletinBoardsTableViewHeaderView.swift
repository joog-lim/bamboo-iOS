//
//  BulletinBoardsTableViewHeaderView.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2022/01/10.
//

import UIKit
import RxSwift
import Reusable

class BulletinBoardsTableViewHeaderView : BaseTableViewHeaderFooterView<Void>{
    var disposeBag = DisposeBag()
    
    private lazy var containerView = UIView().then{$0.backgroundColor = .white}
    
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
        backgroundColor = .white
    }
    private func addView(){
        addSubview(containerView)
        containerView.addSubviews(titleLabel)
    }
    
    private func makeConstraints(){
        containerView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        titleLabel.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().offset(20)
        }
    }
}
