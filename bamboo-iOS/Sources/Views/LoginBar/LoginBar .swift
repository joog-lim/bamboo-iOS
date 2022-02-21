//
//  LoginBar .swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2022/02/22.
//

import UIKit
import Then

class LoginBar : UIView{
    let backBtn = UIButton(type: .system).then{
        $0.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        $0.tintColor = .gray
    }
    private let logo = UIImageView().then{
        $0.image = UIImage(named: "BAMBOO_Logo")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews(backBtn,logo)
        
        backBtn.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().inset(20)
            $0.top.bottom.equalToSuperview()
        }
        logo.snp.makeConstraints{
            $0.center.equalToSuperview()
            $0.height.equalTo(20)
            $0.width.equalTo(40)
        }
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
