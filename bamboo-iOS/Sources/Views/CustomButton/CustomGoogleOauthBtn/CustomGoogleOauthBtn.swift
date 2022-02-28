//
//  CustomGoogleOauthBtn.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/11/14.
//
    
import UIKit

class CustomGoogleOauthBtn : UIButton{
    //MARK: - 커스텀 버튼 설정
    private let iv = UIImageView().then{
        $0.contentMode = .scaleAspectFit
    }
    
    init(image : UIImage ,btnText : String){
        super.init(frame: .zero)
        backgroundColor = .white
        
        iv.image = image
        setTitle(btnText, for: .normal)
        setTitleColor(.lightGray, for: .normal)
        titleLabel?.font = UIFont(name: "NanumSquareRoundR", size: 12)
        addView()
        CornerAndBorderWidth()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        iv.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.right.equalTo(titleLabel!.snp.left).offset(-10)
            $0.height.width.equalTo(15)
        }
    }
    
    //MARK: - Helper
    private func addView(){
        addSubview(iv)
    }
    //MARK: - Corner And Border Setting
    private func CornerAndBorderWidth(){
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
    }

}
