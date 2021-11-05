//
//  GoogleOauthModalVC.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/11/04.
//

import UIKit

class GoogleOauthModalVC : BaseVC {

    //MARK: - Properties
    weak var delegate : GoogleOauthModalDelegate?
    
    private let transparentView = UIView()

    private let bgView = UIView().then{
        $0.backgroundColor = .white
    }
    private let titleLabel = UILabel().then{
        $0.text = "로그인하기"
        $0.font = UIFont(name: "NanumSquareRoundR", size: 10)
        $0.textColor = .rgb(red: 196, green: 196, blue: 196)
    }
    private let humanAffairsLabel = UILabel().then{
        $0.font = UIFont(name: "NanumSquareRoundR", size: 10)
        $0.text = "관리자님 환영합니다!"
        $0.textColor = .rgb(red: 87, green: 204, blue: 77)
    }
    
    
    private let loginBtn = LoginButton(placeholder: "로그인", cornerRadius: 5).then{
        $0.titleLabel?.font = UIFont(name: "NanumSquareRoundR", size: 13)
        $0.layer.applySketchShadow(color: .rgb(red: 87, green: 204, blue: 77), alpha: 0.25, x: 1, y: 5, blur: 5, spread: 0)
        $0.addTarget(self, action: #selector(UserLoginBtn), for: .touchUpInside)
    }
    
    //MARK: - Selector
    
    //모달 위치 조정
    static func instance() -> GoogleOauthModalVC{
        return GoogleOauthModalVC(nibName: nil, bundle: nil).then{
            $0.modalPresentationStyle = .overFullScreen
        }
    }
    //MARK: - Selectors
    @objc private func onTapClose() {
        delegate?.onTapClose()
        dismiss(animated: true, completion: nil)
    }
    @objc private func UserLoginBtn(){
        dismiss(animated: true) {
            self.delegate?.GoogleOauthModalBtnClick()
        }
    }
    
    //MARK: - Helper
    override func configure() {
        super.configure()
        view.backgroundColor = .clear
        addView()
        location()
        addTransparentsview(frame: transparentView.frame)
    }
    //MARK: - AddView
    private func addView(){
        [transparentView,bgView].forEach{ view.addSubview($0)}
        [titleLabel,humanAffairsLabel,loginBtn].forEach{ bgView.addSubview($0)}
    }
    //MARK: - Location
    private func location(){
        if UIDevice.current.isiPhone{
            bgView.layer.cornerRadius = 10
            bgView.snp.makeConstraints{
                $0.center.equalToSuperview()
                $0.height.equalTo(bounds.height/3.5771)
                $0.width.equalTo(bounds.width/1.1718)
            }
            loginBtn.snp.makeConstraints { (make) in
                make.bottom.equalToSuperview().inset(bounds.height/47.7)
                make.height.equalTo(bounds.height/27.1)
                make.left.right.equalToSuperview().inset(30)
            }
        }else if UIDevice.current.isiPad{
            bgView.layer.cornerRadius = 15
            bgView.snp.makeConstraints{
                $0.center.equalToSuperview()
                $0.height.equalTo(220)
                $0.width.equalTo(292)
            }
            loginBtn.snp.makeConstraints { (make) in
                make.bottom.equalToSuperview().inset(bounds.height/47.7)
                make.height.equalTo(25)
                make.left.right.equalToSuperview().inset(30)
            }
        }
        titleLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(bounds.height/40)
            $0.centerX.equalToSuperview()
        }
    }
    //MARK: - Gesture
    private func addTransparentsview(frame : CGRect){
        transparentView.frame = bounds
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(onTapClose))
        transparentView.addGestureRecognizer(tapgesture)
    }
    
}
