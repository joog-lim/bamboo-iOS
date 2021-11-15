//
//  LikeOrDisLikeView.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/10/19.
//

import UIKit

class LikeOrDisLikeView : UIButton{
    
    //MARK: - Properties
    let iv = UIImageView().then{
        $0.contentMode = .scaleAspectFit
    }
    let label = UILabel().then{
        $0.font = UIFont(name: "NanumSquareRoundR", size: 10)
        $0.textColor = .lightGray
    }
    
    //MARK: - Button is Select
    override var isSelected: Bool{
        didSet{
            if isSelected{
                iv.image = UIImage(named: "BAMBOO_Good_Leaf_Select")
                label.textColor = .bamBoo_57CC4D
            }else{
                iv.image = UIImage(named: "BAMBOO_Good_Leaf")
                label.textColor = .gray
            }
        }
    }
    //MARK: - Initalizer
    override init(frame: CGRect) {
        super.init(frame: frame)
        addView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - layoutSubView
    override func layoutSubviews() {
        super.layoutSubviews()
        location()
    }
//MARK: - Helper
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
