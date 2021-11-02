//
//  ManagerLoginModal.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/11/02.
//

import UIKit

class ManagerLoginModal: BaseVC{
    //MARK: - Properties
    weak var delegate : ManagerModalDelegate?
    
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
    
    private let WritePassWorld = AlertTextField(placeholder: "비밀번호를 입력하세요!", fontSize: 10)
    
    private lazy var titleStackView = UIStackView(arrangedSubviews: [humanAffairsLabel,WritePassWorld]).then{
        $0.axis = .vertical
        $0.spacing = 15
    }
    
    private let loginBtn = LoginButton(placeholder: "로그인", cornerRadius: 5).then{
        $0.titleLabel?.font = UIFont(name: "NanumSquareRoundR", size: 13)
        $0.layer.applySketchShadow(color: .rgb(red: 87, green: 204, blue: 77), alpha: 0.25, x: 1, y: 5, blur: 5, spread: 0)
    }
    
    //MARK: - Selector
    //모달 위치 조정
    static func instance() -> ManagerLoginModal{
        return ManagerLoginModal(nibName: nil, bundle: nil).then{
            $0.modalPresentationStyle = .overFullScreen
        }
    }
    //MARK: - Selectors
    @objc func onTapClose() {
        delegate?.onTapManagerModalClose()
        dismiss(animated: true, completion: nil)
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
        [titleLabel,titleStackView,loginBtn].forEach{ bgView.addSubview($0)}
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
        }else if UIDevice.current.isiPad{
            bgView.layer.cornerRadius = 15
            bgView.snp.makeConstraints{
                $0.center.equalToSuperview()
                $0.height.equalTo(220)
                $0.width.equalTo(292)
            }
        }
        titleLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(bounds.height/40)
            $0.centerX.equalToSuperview()
        }
        titleStackView.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.left.right.equalToSuperview().inset(30)
        }
        WritePassWorld.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.height.equalTo(bounds.height/29)
        }
        loginBtn.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().inset(bounds.height/47.7)
            make.height.equalTo(bounds.height/27.1)
            make.left.right.equalToSuperview().inset(30)
        }
    }
    //MARK: - Gesture
    private func addTransparentsview(frame : CGRect){
        transparentView.frame = bounds
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(onTapClose))
        transparentView.addGestureRecognizer(tapgesture)
    }
    //MARK: - keyboard down
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
}
