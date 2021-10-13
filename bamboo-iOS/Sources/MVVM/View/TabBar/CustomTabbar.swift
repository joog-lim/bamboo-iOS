//
//  CustomTabbar.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/09/13.
//

import UIKit

class CustomTabbar : UIView {
    //MARK: - property
    lazy var stackView = UIStackView(arrangedSubviews: [homeBtn,ruleBtn,detailsBtn]).then{
        $0.axis = .horizontal
        $0.spacing = frame.width/37.5
        $0.distribution = .fillEqually
    }

    let homeBtn = UIButton().then{
        $0.setImage(UIImage(named: "BAMBOO_Home")?.withRenderingMode(.alwaysTemplate), for: .normal)
        $0.tintColor = .bamBoo_57CC4D
    }
    let ruleBtn = UIButton().then{
        $0.setImage(UIImage(named: "BAMBOO_Rule")?.withRenderingMode(.alwaysTemplate), for: .normal)
        $0.tintColor = .lightGray
    }
    let detailsBtn = UIButton().then{
        $0.setImage(UIImage(named: "BAMBOO_Detail")?.withRenderingMode(.alwaysTemplate), for: .normal)
        $0.tintColor = .lightGray
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addView()
        backgroundColor = .white
        layer.applySketchShadow(color: .bamBoo_57CC4D, alpha: 0.25, x: 1, y: 0, blur: 10, spread: 0)
    }
    func addView(){
        addSubview(stackView)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        stackView.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(frame.height/4.1)
            $0.top.equalToSuperview().offset(frame.height/4.1)
            
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
