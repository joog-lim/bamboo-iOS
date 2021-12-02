//
//  ModalAction.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/12/02.
//

import Foundation
import UIKit
import ReactorKit

class ModalAction : UIViewController{
    private let bgView = UIView().then {
        $0.backgroundColor = .black
        $0.alpha = 0
    }
    //MARK: - 모달 실행시 Action
    private func addDim() {
        view.addSubview(bgView)
        bgView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalToSuperview()
        }
        DispatchQueue.main.async { [weak self] in
            self?.bgView.alpha = 0.1
            self?.navigationController?.navigationBar.backgroundColor = self?.bgView.backgroundColor?.withAlphaComponent(0.1)
        }
    }
    //MARK: - 모달 닫기
    private func removeDim() {
        DispatchQueue.main.async { [weak self] in
            self?.bgView.removeFromSuperview()
            self?.navigationController?.navigationBar.backgroundColor = .clear
        }
    }
}
