//
//  LikeOrDisLikeView.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/10/19.
//

import UIKit

class LikeOrDisLikeView : UIButton{
    
    let iv = UIImageView().then{
        $0.contentMode = .scaleAspectFit
    }
    let label = UILabel().then{
        $0.font = UIFont(name: "NanumSquareRoundR", size: 10)
        $0.textColor = .lightGray
        $0.text = "1"
    }
    init(imageLikeOrDisLike : UIImage?){
        super.init(frame: .zero)
        iv.image = imageLikeOrDisLike!
        iv.tintColor = .blue
        addView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        location()
    }
    
    private func addView(){
        [iv,label].forEach{ addSubview($0)}
    }
    private func location(){
        iv.snp.makeConstraints {
            $0.top.left.height.equalToSuperview()
            $0.width.equalTo(iv.snp.height)
        }
        label.snp.makeConstraints{
            $0.left.equalTo(iv.snp.right).offset(5)
            $0.bottom.equalToSuperview()
        }
    }
    
}
