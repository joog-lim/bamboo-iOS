//
//  CustomGoogleOauthBtn.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/11/14.
//
    
import UIKit

class CustomGoogleOauthBtn : UIButton{
    //MARK: - 커스텀 버튼 설정
    init(image : UIImage ,btnText : String){
        super.init(frame: .zero)
        backgroundColor = .white
        
        setImage(image, for: .normal)
        setTitle(btnText, for: .normal)
        setTitleColor(.lightGray, for: .normal)
        titleLabel?.font = UIFont(name: "NanumSquareRoundR", size: 10)
        
        CornerAndBorderWidth()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView?.snp.makeConstraints{
            $0.height.width.equalTo(10)
            $0.centerY.equalToSuperview()
        }
        titleLabel?.snp.makeConstraints{
            $0.centerY.equalToSuperview()
        }
    }
    
    //MARK: - Helper
    //MARK: - Corner And Border Setting
    private func CornerAndBorderWidth(){
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
    }

}
