//
//  ManagerPopUp.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/09/08.
//

import UIKit

class ManagerPopUp : UIView {
    
    fileprivate let icon = UIImageView().then{
        $0.image = UIImage(named: "")
        $0.contentMode = .scaleAspectFill
    }
    fileprivate let titleLabel = UILabel().then{
        $0.text = "로그인하기"
        $0.dynamicFont(fontSize: 10, currentFontName: "NanumSquareRoundR.ttf")
        $0.textColor = .rgb(red: 196, green: 196, blue: 196)
    }
    fileprivate let WritePassWorld = UITextField().then{
        $0.attributedPlaceholder = NSAttributedString(string: "비밀번호를 입력하세요", attributes: [NSAttributedString.Key.foregroundColor: UIColor.rgb(red: 196, green: 196, blue: 196)])
    }
    fileprivate let LoginBtn : LoginButton = {
        let btn = LoginButton(placeholder: "로그인")
        return btn
    }()
    
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
