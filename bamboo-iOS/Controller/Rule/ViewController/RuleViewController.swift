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
    
    let rule : String = ""
    
    private let backGroundScrollView = UIScrollView().then{
        $0.backgroundColor = .clear
        $0.showsVerticalScrollIndicator = true
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private let titleLabel = UILabel().then{
        let string : NSMutableAttributedString = NSMutableAttributedString(string: "안녕하세요!이곳은\n광대숲입니다!")
        $0.numberOfLines = 0
        $0.textColor = .bamBoo_57CC4D
        $0.dynamicFont(fontSize: 20, currentFontName: "NanumSquareRoundB")
        string.setColorForText(textToFind: "이곳은", withColor: .black)
        string.setColorForText(textToFind: "입니다!", withColor: .black)
        $0.attributedText = string
    }
    
    private let explanationLabel = UILabel().then{
        $0.text = "누구한테도 말하기 어려웠던 이야기부터\n사소하고 조그만 이야기까지."
        $0.dynamicFont(fontSize: 10, currentFontName: "NanumSquareRoundR")
        $0.textColor = .bamBoo_57CC4D
        $0.numberOfLines = 0
    }
    let divider = UIView().then{
        $0.backgroundColor = .bamBoo_57CC4D
    }
    

    private let greetingsLabel = ExplanationLabel(textLabel: ruleString.greetings.rawValue, fontSize: 15, fontStyle: "NanumSquareRoundR")
    
    private let somethingIAskOften = ExplanationLabel(textLabel: ruleString.somethingIAskOften.rawValue, fontSize: 13, fontStyle: "NanumSquareRoundR")

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
        backGroundScrollView.addSubview(explanationLabel)
        backGroundScrollView.addSubview(divider)
        backGroundScrollView.addSubview(greetingsLabel)
        backGroundScrollView.addSubview(somethingIAskOften)
    }
    func location(){
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(bounds.height/40.6)
            $0.left.equalToSuperview().offset(bounds.width/26.786)
        }
        explanationLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(bounds.height/40.6)
            $0.left.equalTo(titleLabel)
        }
        divider.snp.makeConstraints {
            $0.top.equalTo(explanationLabel.snp.bottom).offset(bounds.height/25.375)
            $0.left.equalTo(explanationLabel)
            $0.width.equalTo(307)
            $0.height.equalTo(0.3)
        }
        greetingsLabel.snp.makeConstraints {
            $0.top.equalTo(divider.snp.bottom).offset(bounds.height/23.88)
            $0.left.equalTo(titleLabel)
            $0.right.equalTo(view).inset(bounds.width/26.786)
            
        }
        somethingIAskOften.snp.makeConstraints {
            $0.top.equalTo(greetingsLabel.snp.bottom).offset(bounds.height/27.06666)
            $0.left.equalTo(titleLabel)
            $0.right.equalTo(view).inset(bounds.width/26.786)
        }
        backGroundScrollView.snp.makeConstraints {
            $0.top.left.right.bottom.equalToSuperview()
        }
        
        backGroundScrollView.contentSize = CGSize(width: view.frame.width, height: bounds.height/0.938728)
    }
}
