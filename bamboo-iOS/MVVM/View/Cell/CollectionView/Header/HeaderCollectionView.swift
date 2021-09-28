//
//  HeaderCollectionView.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/09/28.
//

import UIKit
class HeaderCollectionView: UICollectionReusableView{
    static let identifier = "HeaderCollectionView"
    
    private let titleLabel = UILabel().then{
        let string : NSMutableAttributedString = NSMutableAttributedString(string: "하고 싶던 말,\n무엇인가요?")
        $0.dynamicFont(fontSize: 20, currentFontName: "NanumSquareRoundB")
        $0.textColor = .rgb(red: 87, green: 204, blue: 77)
        $0.numberOfLines = 2
        string.setColorForText(textToFind: "무엇인가요?", withColor: .black)
        $0.attributedText = string
        
    }
    func configure(){
        addSubview(titleLabel)
        backgroundColor = .red
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(bounds.height/40.6)
            $0.left.equalToSuperview().offset(bounds.width/18.75)
             
        }
    }
}
