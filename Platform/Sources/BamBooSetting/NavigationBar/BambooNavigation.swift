//
//  File.swift
//  
//
//  Created by Ji-hoon Ahn on 2022/05/18.
//

import UIKit
import Then
import SnapKit

final class BambooNavigationBar : UIView{
    private let logo = UIImageView(image: UIImage(named: "BAMBOO_Logo"), contentMode: .scaleAspectFill)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(logo)
        
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
