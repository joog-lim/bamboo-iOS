//
//  ManagerLoginModal.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/11/02.
//

import UIKit
import RxKeyboard

protocol ManagerModalDelegate : AnyObject {
    func updateManagerModal()
}

final class ManagerLoginModal: baseVC<ManagerLoginModalReactor>{
    //MARK: - Properties
    private let transparentView = UIView().then{
        $0.backgroundColor = .black
        $0.alpha = 0.1
    }
    
    weak var delegate : ManagerModalDelegate?
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
//        $0.addTarget(self, action: #selector(ManagerLoginBtn), for: .touchUpInside)
    }
    
    //MARK: - Selector
    override func configureUI() {
        super.configureUI()
        view.backgroundColor = .clear
    }
    override func addView() {
        super.addView()
        [transparentView,bgView].forEach{ view.addSubview($0)}
        [titleLabel,titleStackView,loginBtn].forEach{ bgView.addSubview($0)}
    }
        
    override func setLayout() {
        super.setLayout()
        transparentView.snp.makeConstraints{
            $0.top.right.left.bottom.equalToSuperview()
        }
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
        titleStackView.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.left.right.equalToSuperview().inset(30)
        }
        WritePassWorld.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.height.equalTo(bounds.height/29)
        }
    }
    
    override func bindView(reactor: ManagerLoginModalReactor) {
        super.bindView(reactor: reactor)
        transparentView.rx.anyGesture(.tap(), .swipe(direction: .down))
            .when(.recognized)
            .map{_ in Reactor.Action.managerDismiss}
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        loginBtn.rx.tap
            .map{Reactor.Action.managerBtnClick}
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
}




//MARK: - KeyBoard Setting PART
//extension ManagerLoginModal{
//    //MARK: - KeyBoardSetting
//    private func addNotificationCenter(){
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name:UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
//    }
//
//    //MARK: - keyboard down
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        super.touchesBegan(touches, with: event)
//        view.endEditing(true)
//    }
//    //MARK: - KeyboardWillShow -> continueButton Up
//    @objc
//    private func keyboardWillShow(_ sender: Notification) {
//        var keyboardHeight: CGFloat = CGFloat(0) //keyboardHeight
//        if let keyboardFrame: NSValue = sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
//            let keyboardRectangle = keyboardFrame.cgRectValue
//            keyboardHeight = keyboardRectangle.height
//        }
//        if UIDevice.current.isiPhone{
//            bgView.snp.remakeConstraints{
//                $0.height.equalTo(bounds.height/3.5771)
//                $0.width.equalTo(bounds.width/1.1718)
//                $0.centerX.equalToSuperview()
//                $0.bottom.equalToSuperview().offset(-keyboardHeight - 10)
//            }
//        }else{
//            keyboardHeightSetting(height: keyboardHeight)
//        }
//    }
//    private func keyboardHeightSetting(height : CGFloat){
//        if bgView.frame.origin.y < height{
//            bgView.snp.remakeConstraints{
//                $0.height.equalTo(220)
//                $0.width.equalTo(292)
//                $0.centerX.equalToSuperview()
//                $0.bottom.equalToSuperview().offset(-height - 10)
//            }
//        }
//    }
//
//    //MARK: - KeyboardWillHide -> continueButton Down
//    @objc
//    private func keyboardWillHide(_ sender: Notification) {
//        if UIDevice.current.isiPhone{
//            bgView.snp.remakeConstraints{
//                $0.height.equalTo(bounds.height/3.5771)
//                $0.width.equalTo(bounds.width/1.1718)
//                $0.center.equalToSuperview()
//            }
//        }else{
//            bgView.snp.remakeConstraints{
//                $0.height.equalTo(220)
//                $0.width.equalTo(292)
//                $0.center.equalToSuperview()
//            }
//        }
//    }
//}
