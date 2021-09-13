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
    fileprivate let humanAffairsLabel = UILabel().then{
        $0.dynamicFont(fontSize: 10, currentFontName: "NanumSquareRoundR")
        $0.text = "관리자님 환영합니다!"
        $0.textColor = .rgb(red: 87, green: 204, blue: 77)
    }
    
    fileprivate let WritePassWorld : AlertTextField = {
        let tf = AlertTextField(placeholder: "비밀번호를 입력하세요!")
        return tf
    }()
    
    fileprivate let loginBtn : LoginButton = {
        
        let btn = LoginButton(placeholder: "로그인")
        btn.label.dynamicFont(fontSize: 10, currentFontName: "NanumSquareRoundR")
        btn.layer.applySketchShadow(color: .rgb(red: 87, green: 204, blue: 77), alpha: 0.25, x: 1, y: 5, blur: 5, spread: 0)
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
        view.addSubview(humanAffairsLabel)
        view.addSubview(WritePassWorld)
        view.addSubview(loginBtn)
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
        humanAffairsLabel.snp.makeConstraints { (make) in
            make.left.equalTo(view.snp.left).offset(frame.width/15.625)
            make.top.equalTo(titleLabel.snp.bottom).offset(frame.height/54.133)
        }
        WritePassWorld.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(frame.width/15.625)
            make.centerX.equalToSuperview()
            make.top.equalTo(humanAffairsLabel.snp.bottom).offset(frame.height/54.133)
            make.height.equalTo(frame.height/30.074)
        }
        loginBtn.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().inset(frame.height/47.7)
            make.height.equalTo(frame.height/32.48)
            make.left.right.equalToSuperview().inset(frame.width/15.625)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
