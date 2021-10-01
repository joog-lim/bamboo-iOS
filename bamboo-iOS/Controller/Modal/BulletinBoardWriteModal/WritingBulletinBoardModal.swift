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
        $0.layer.applySketchShadow(color: .black, alpha: 0.25, x: 0, y: -4, blur: 16, spread: 0)
    }
    
    let transparentView = UIView()
    
    private let titleLabel = UILabel().then{
        $0.text = "글 입력하기"
        $0.dynamicFont(fontSize: 12, currentFontName: "NanumSquareRoundB")
        $0.textColor = .bamBoo_57CC4D
    }
    private let questionTitle = UILabel().then{
        $0.textColor = .black
        $0.text = "올리고 싶은 글을 입력해주세요!"
        $0.dynamicFont(fontSize: 10, currentFontName: "NanumSquareRoundR")
    }
    private let titleTf = AlertTextField(placeholder: "제목을 입력하세요.")
    
    static func instance() -> WritingBulletinBoardModal{
        return WritingBulletinBoardModal(nibName: nil, bundle: nil).then{
            $0.modalPresentationStyle = .overFullScreen
        }
    }
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    //MARK: - Selectors
    @objc func onTapClose() {
        delegate?.onTapClose()
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: - HELPERS
    private func configureUI(){
        addView()
        location()
        addTransparentsview(frame: transparentView.frame)
    }
    private func addView(){
        view.addSubview(transparentView)
        view.addSubview(bgView)
        
    }
    private func location(){
        bgView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(30)
            make.height.equalToSuperview().dividedBy(3.85)
        }
    }
    
    private func addTransparentsview(frame : CGRect){
        let window = UIApplication.shared.keyWindow
        transparentView.frame = window?.frame ?? self.view.frame
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(onTapClose))
        transparentView.addGestureRecognizer(tapgesture)
    }
    
}
