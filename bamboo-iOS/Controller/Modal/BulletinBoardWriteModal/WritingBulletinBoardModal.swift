//
//  WritingBulletinBoardModal.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/09/28.
//

import UIKit
import SnapKit

protocol WriteModalDelegate : class{
    func onTapClose()
}
class WritingBulletinBoardModal: UIViewController{
    
    //MARK: - Properties
    weak var delegate : WriteModalDelegate?
    
    private let bgView = UIView().then{
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 40
    }
    
}
