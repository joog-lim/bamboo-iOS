//
//  RuleViewController.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/09/22.
//

import UIKit

class RuleViewController: UIViewController{
    //MARK: - Properties
    let bounds = UIScreen.main.bounds
    
    private let backGroundScrollView = UIScrollView().then{
        $0.backgroundColor = .clear
        $0.showsVerticalScrollIndicator = true
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private let titleLabel = UILabel().then{
        $0.textColor = .bamBoo_57CC4D
        let text = "안녕하세요!"
        let attributedStr = NSMutableAttributedString(string: text)
        $0.dynamicFont(fontSize: 20, currentFontName: "NanumSquareRoundB")
        attributedStr.addAttribute(.foregroundColor, value: UIColor.black, range: (text as NSString).range(of: "집"))
        $0.attributedText = attributedStr
    }
    



    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: - Selectors
    
    //MARK: - Helper
    func configureUI(){
        addView()
        location()
    }
    func addView(){
        view.addSubview(backGroundScrollView)
        view.addSubview(titleLabel)
    }
    func location(){
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalToSuperview()
            
        }
        backGroundScrollView.snp.makeConstraints {
            $0.top.left.right.bottom.equalToSuperview()
        }
        
        backGroundScrollView.contentSize = CGSize(width: view.frame.width, height: bounds.height/0.938728)
    }
}
