//
//  DetailViewController.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/09/22.
//

import UIKit


class DetailViewController : baseVC<DetailReactor>{
    //MARK: - Properties
    let fifthFont : [String] = ["자주 묻는 말",
                                "문의"]
    
    let thirdFont : [String] = ["안녕하세요, 광대숲 개발자입니다.",
                                "Q. 광대숲이란 무엇인가요?",
                                "Q. 댓글을 달 순 없나요?",
                                "Q. 글에 반응을 달고 싶어요.",
                                "Q. 내 의견을 찾을 수 없어요.",
                                "Q. 댓글을 달 순 없나요?",
                                "Q. 글에 반응을 달고 싶어요.",
                                "Q. 내 의견을 찾을 수 없어요."]
    
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
    private lazy var  greetingsLabel = ExplanationLabel( fontSize: 13, fontStyle: "NanumSquareRoundR", labelColor: .black).then{
        let string = NSMutableAttributedString(string: detailString.greetings.rawValue)
        fifthFont.forEach{string.setFontForText(textToFind: $0, withFont: UIFont(name: "NanumSquareRoundB", size: 15) ?? UIFont())}
        thirdFont.forEach{string.setFontForText(textToFind: $0, withFont: UIFont(name: "NanumSquareRoundB", size: 13) ?? UIFont())}
        string.setColorForText(textToFind: "규칙", withColor: .bamBoo_57CC4D)
        $0.attributedText = string
    }

    
    //MARK: - Selectors
    override func configureUI() {
        super.configureUI()
        navigationSetting()
    }
    
    //MARK: - Helper
    override func addView() {
        view.addSubview(backGroundScrollView)
        [titleLabel,explanationLabel,divider,greetingsLabel].forEach{backGroundScrollView.addSubview($0); $0.sizeToFit()}
    }
    override func setLayout() {
        super.setLayout()
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(bounds.height/40.6)
            $0.left.equalToSuperview().offset(bounds.width/26.786)
        }
        explanationLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(bounds.height/40.6)
            $0.left.equalTo(titleLabel)
            $0.right.equalTo(view)
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
            $0.bottom.equalToSuperview().inset(50)
        }
        //MARK: - ScrollView
        backGroundScrollView.snp.makeConstraints {
            $0.top.left.right.bottom.equalToSuperview()
        }
    }
    //MARK: - Navigation Setting
    private func navigationSetting(){
        navigationController?.navigationCustomBar()
        navigationItem.applyImageNavigation()
    }
}
