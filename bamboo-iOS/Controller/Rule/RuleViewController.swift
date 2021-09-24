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
        let string : NSMutableAttributedString = NSMutableAttributedString(string: "안녕하세요!이곳은")
        string.setColorForText(textToFind: "이곳은", withColor: .black)
        $0.attributedText = string
        $0.dynamicFont(fontSize: 20, currentFontName: "NanumSquareRoundB")
    }
    private let secondLineTitleLabel = UILabel().then{
        $0.textColor = .bamBoo_57CC4D
        let string : NSMutableAttributedString = NSMutableAttributedString(string: "광대숲입니다!")
        string.setColorForText(textToFind: "입니다!", withColor: .black)
        $0.attributedText = string
        $0.dynamicFont(fontSize: 20, currentFontName: "NanumSquareRoundB")
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
        backGroundScrollView.addSubview(titleLabel)
        backGroundScrollView.addSubview(secondLineTitleLabel)
    }
    func location(){
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(bounds.height/40.6)
            $0.left.equalToSuperview().offset(bounds.width/26.786)
        }
        secondLineTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.left.equalTo(titleLabel)
        }
        backGroundScrollView.snp.makeConstraints {
            $0.top.left.right.bottom.equalToSuperview()
        }
        
        backGroundScrollView.contentSize = CGSize(width: view.frame.width, height: bounds.height/0.938728)
    }
}
