//
//  CustomDropDownBtn.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/10/16.
//

import UIKit

class CustomDropDownBtn : UIButton{
    
    let btnTitle = UILabel().then{
        $0.dynamicFont(fontSize: 9, currentFontName: "NanumSquareRoundB")
        $0.textColor = .black
    }
    let iv = UIImageView(image: UIImage(named: "BAMBOO_Check")?.withRenderingMode(.alwaysTemplate)).then{
        $0.tintColor = .bamBoo_57CC4D
        $0.contentMode = .scaleAspectFit
    }
    
    init(placeholder : String){
        super.init(frame: .zero)
        backgroundColor = .white
        [btnTitle,iv].forEach { addSubview($0)}
        btnTitle.text = placeholder
        location()
    }
    
    private func location(){
        btnTitle.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().offset(5)
        }
        iv.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().inset(5)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
