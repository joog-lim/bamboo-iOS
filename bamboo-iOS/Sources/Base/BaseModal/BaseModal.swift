//
//  BaseModal.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/11/05.
//

import UIKit
protocol BaseModalDelegate : AnyObject{
    func onTapClick()
}

class BaseModal : BaseVC{
    
    let transparentView = UIView()
    weak var baseDelegate : BaseModalDelegate?
    @available(*,unavailable)
    
    //MARK: - LifeCycle
    override func configure() {
        super.configure()
        modalSetting()
    }
    //MARK: - ModalSetting
    func modalSetting(){
        view.backgroundColor = .clear
        view.addSubview(transparentView)
        addTransparentsview()}
    //MARK: - Action
    @objc private func onTapClose(){
        dismiss(animated: true, completion: nil)
        baseDelegate?.onTapClick()
    }

    //MARK: - Modal BackGround
    private func addTransparentsview(){
        let window = UIApplication.shared.keyWindow
        transparentView.frame = window?.frame ?? self.view.frame
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(onTapClose))
        transparentView.addGestureRecognizer(tapgesture)
    }
}
