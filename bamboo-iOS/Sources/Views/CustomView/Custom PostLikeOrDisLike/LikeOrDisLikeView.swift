//
//  LikeOrDisLikeView.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/10/19.
//

import UIKit

class LikeOrDisLikeView : UIView{
    let goodBtn = UIButton().then{
        $0.setImage(UIImage(named: "BAMBOO_Good")?.withRenderingMode(.alwaysTemplate), for: .normal)
        $0.tintColor = .lightGray
    }
    let hateBtn =  UIButton().then{
        $0.setImage(UIImage(named: "BAMBOO_Hate")?.withRenderingMode(.alwaysTemplate), for: .normal)
        $0.tintColor = .lightGray
    }
    private func addView(){
        [goodBtn,hateBtn].forEach{ addSubview($0)}
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
