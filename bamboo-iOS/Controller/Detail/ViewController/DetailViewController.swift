//
//  DetailViewController.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/09/22.
//

import UIKit


class DetailViewController : UIViewController{
    //MARK: - Properties
    let bounds = UIScreen.main.bounds
        
    private let backGroundScrollView = UIScrollView().then{
        $0.backgroundColor = .clear
        $0.showsVerticalScrollIndicator = false
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    

    private let titleLabel = ExplanationLabel(fontSize: 20, fontStyle: "NanumSquareRoundB", labelColor: .bamBoo_57CC4D).then{
        let string = NSMutableAttributedString(string: detailString.titleString.rawValue)
        string.setColorForText(textToFind: "이곳은", withColor: .black)
        string.setColorForText(textToFind: "입니다!", withColor: .black)
        $0.attributedText = string
    }
    private let explanationLabel = ExplanationLabel(fontSize: 10, fontStyle: "NanumSquareRoundR", labelColor: .bamBoo_57CC4D).then{
        $0.text = "누구한테도 말하기 어려웠던 이야기부터\n사소하고 조그만 이야기까지."
    }
    
    private let divider = UIView().then{
        $0.backgroundColor = .bamBoo_57CC4D
    }
    

    private let greetingsLabel = ExplanationLabel( fontSize: 15, fontStyle: "NanumSquareRoundR", labelColor: .black).then{
        let string = NSMutableAttributedString(string: detailString.greetings.rawValue)
        string.setFontForText(textToFind: "안녕하세요, 광대숲 개발자입니다.", withFont: .boldSystemFont(ofSize: 18))
        $0.attributedText = string
    }
    
    private let somethingIAskOften = ExplanationLabel( fontSize: 13, fontStyle: "NanumSquareRoundR", labelColor: .black).then{
        let string = NSMutableAttributedString(string: detailString.somethingIAskOften.rawValue)
        string.setFontForText(textToFind: "자주 묻는 말", withFont: .boldSystemFont(ofSize: 18))
        string.setFontForText(textToFind: "Q. 광대숲이란 무엇인가요?", withFont: .boldSystemFont(ofSize: 15))
        string.setFontForText(textToFind: "Q. 댓글을 달 순 없나요?", withFont: .boldSystemFont(ofSize: 15))
        string.setFontForText(textToFind: "Q. 글에 반응을 달고 싶어요.", withFont: .boldSystemFont(ofSize: 15))
        string.setFontForText(textToFind: "Q. 내 의견을 찾을 수 없어요.", withFont: .boldSystemFont(ofSize: 15))
        $0.attributedText = string
    }
    private let clickLabel = ExplanationLabel(fontSize: 13, fontStyle: "NanumSquareRoundR", labelColor: .black).then{
        let string = NSMutableAttributedString(string: detailString.bottomsomethingIAskOften.rawValue)
        string.setColorForText(textToFind: "규칙", withColor: .bamBoo_57CC4D)
        $0.attributedText = string
    }
    private let bottomLabel = ExplanationLabel(fontSize: 13, fontStyle: "NanumSquareRoundB", labelColor: .black).then{
        let string = NSMutableAttributedString(string: detailString.inquiry.rawValue)
        string.setFontForText(textToFind: "문의", withFont: .boldSystemFont(ofSize: 18))
        $0.attributedText = string
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()

    }
    
    //MARK: - Selectors
    @objc func gesture(sender:UITapGestureRecognizer){
        print("집")
    }
    
    //MARK: - Helper
    private func configureUI(){
        addView()
        location()
        gestureLabel()
    }
    //MARK: - Gesture
    private func gestureLabel(){
        clickLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(gesture)))
    }
    //MARK: - addView
    private func addView(){
        view.addSubview(backGroundScrollView)
        backGroundScrollView.addSubview(titleLabel)
        backGroundScrollView.addSubview(explanationLabel)
        backGroundScrollView.addSubview(divider)
        backGroundScrollView.addSubview(greetingsLabel)
        backGroundScrollView.addSubview(somethingIAskOften)
        backGroundScrollView.addSubview(clickLabel)
        backGroundScrollView.addSubview(bottomLabel)
    }


    
    //MARK: - Location
    private func location(){
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(bounds.height/40.6)
            $0.left.equalToSuperview().offset(bounds.width/26.786)
        }
        explanationLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(bounds.height/40.6)
            $0.left.equalTo(titleLabel)
        }
        divider.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(bounds.width/26.7857)
            make.top.equalTo(explanationLabel.snp.bottom).offset(bounds.height/25.375)
            make.height.equalTo(0.3)
            make.width.equalTo(bounds.width/1.23)
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
        clickLabel.snp.makeConstraints {
            $0.top.equalTo(somethingIAskOften.snp.bottom)
            $0.left.equalTo(somethingIAskOften)
        }
        bottomLabel.snp.makeConstraints {
            $0.top.equalTo(clickLabel.snp.bottom).offset(bounds.height/27.067)
            $0.left.equalTo(clickLabel)
        }
        
        //MARK: - ScrollView
        backGroundScrollView.snp.makeConstraints {
            $0.top.left.right.bottom.equalToSuperview()
        }
        backGroundScrollView.contentSize = CGSize(width: view.frame.width, height: bounds.height/0.938728)
    }
}
