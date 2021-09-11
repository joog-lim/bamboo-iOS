//
//  ManagerPopUp.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/09/08.
//

import UIKit

class ManagerPopUp : UIView {
    
    
    let view = UIView().then{
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 5
    }
    fileprivate let icon = UIImageView().then{
        $0.image = UIImage(named: "BAMBOO_splash")
        $0.contentMode = .scaleAspectFill
    }
    fileprivate let titleLabel = UILabel().then{
        $0.text = "로그인하기"
        $0.dynamicFont(fontSize: 10, currentFontName: "NanumSquareRoundR")
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
        self.backgroundColor = .gray.withAlphaComponent(0.5)
        self.frame = UIScreen.main.bounds
        configure()
    }
    func configure(){
        addView()
    }
    func addView(){
        addSubview(view)
        view.addSubview(icon)
        view.addSubview(titleLabel)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        view.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.height.equalTo(frame.height/3.5771)
            make.width.equalTo(frame.width/1.28425)
        }
        icon.snp.makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.top.equalTo(view).offset(frame.height/40.6)
            make.height.equalTo(frame.height/45.111)
            make.width.equalTo(frame.width/9.1463)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(icon.snp.bottom).offset(frame.height/68.81)
            make.centerX.equalToSuperview()
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
