//
//  RulePageTitleLabel.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/09/23.
//

import UIKit

class RulePageTitleLabel: UILabel{
    
    let hello = UILabel().then{
        $0.text = "안녕하세요!"
        $0.dynamicFont(fontSize: 20, currentFontName: "NanumSquareRoundB")
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    

    override func layoutSubviews() {
        super.layoutSubviews()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
