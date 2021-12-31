//
//  RuleViewController.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/09/22.
//

import UIKit
import RxViewController

final class RuleViewController : baseVC<RuleReactor> {
    //MARK: - Properties
    
    let fifteenFont : [String] = ["제 1조 목적",
                                  "제 2조 게시글 게시에 관한 규칙",
                                  "제 3조 특정 이슈로 인한 과열에 관한 규칙"]
    let thirdTeenFont : [String] = ["제 1항)  다음과 같은 게시물의 경우 반려 처리가 되거나, 삭제가 될 수 있다.",
                                    "제 2항) 제 2조 1항 2호에 해당하는 게시글이 공익을 목적으로 하는 고발성 제보일 경우, 관리자들의 회의 아래 게시될 수 있다. 단 다음 기준들이 엄격히 적용된다.",
                                    "제 3항) 이 외에 제 2조 1항의 기준에 해당되는 제보더라도, 논란의 소지가 없다고 판단되는 범위 내에서 대나무숲 활성화를 위해 관리자의 재량으로 게시글이 게시될 수 있다. 단, 다음 기준들이 적용된다.",
                                    "제 1항) 특정 이슈로 대나무숲이 과열이 되는 조짐을 보일 경우, 관리자들의 자체적인 판단에 따라, 해당 주제에 관한 제보 업로드를 보류하는 시스템으로, 관리자의 판단 하에 공지 없이 시행될 수 있다."]
    
    private let titleLabel = UILabel().then{
        $0.text = "규칙"
        $0.textColor = .bamBoo_57CC4D
        $0.font = UIFont(name: "NanumSquareRoundB", size: 20)
    }
    
    private lazy var  ruleLabel = ExplanationLabel(fontSize: 13, fontStyle: "NanumSquareRoundR", labelColor: .black).then{
        let string = NSMutableAttributedString(string: ruleString.rule.rawValue)
        fifteenFont.forEach{string.setFontForText(textToFind: $0, withFont:  UIFont(name: "NanumSquareRoundR", size: 15) ?? UIFont())}
        thirdTeenFont.forEach{string.setFontForText(textToFind: $0, withFont: UIFont(name: "NanumSquareRoundR", size: 13) ?? UIFont())}
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.attributedText = string
    }
    
    private let backGroundScrollView = UIScrollView().then{
        $0.showsVerticalScrollIndicator = false
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    
    //MARK: - Helper

    override func configureUI() {
        super.configureUI()
        navigationItem.applyImageNavigation()
    }
    override func addView() {
        super.addView()
            view.addSubview(backGroundScrollView)
            [titleLabel,ruleLabel].forEach{backGroundScrollView.addSubview($0)}
    }
    
    override func setLayout() {
        super.setLayout()
        backGroundScrollView.snp.makeConstraints {
            $0.edges.equalTo(view.safeArea.edges)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(29)
            $0.left.equalToSuperview().offset(bounds.width/26.8)
        }
        ruleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(21)
            $0.left.equalTo(titleLabel)
            $0.right.equalTo(view).inset(bounds.width/26.786)
            $0.bottom.equalToSuperview().inset(60)
        }
    }
}
