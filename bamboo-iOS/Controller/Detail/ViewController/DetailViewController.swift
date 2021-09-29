//
//  DetailViewController.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/09/22.
//

import UIKit

class DetailViewController : UIViewController {
    //MARK: - Properties
    let bounds = UIScreen.main.bounds
    
    
    private let titleLabel = UILabel().then{
        $0.text = "규칙"
        $0.textColor = .bamBoo_57CC4D
        $0.dynamicFont(fontSize: 20, currentFontName: "NanumSquareRoundB")
    }
    
    private let ruleLabel = ExplanationLabel(fontSize: 13, fontStyle: "NanumSquareRoundR", labelColor: .black).then{
        let string = NSMutableAttributedString(string: detailString.rule.rawValue)
        string.setFontForText(textToFind: "제 1조 목적", withFont: .boldSystemFont(ofSize: 18))
        string.setFontForText(textToFind: "제 2조 게시글 게시에 관한 규칙", withFont: .boldSystemFont(ofSize: 18))
        string.setFontForText(textToFind: "제 1항)  다음과 같은 게시물의 경우 반려 처리가 되거나, 삭제가 될 수 있다.", withFont: .boldSystemFont(ofSize: 15))
        string.setFontForText(textToFind: "제 2항) 제 2조 1항 2호에 해당하는 게시글이 공익을 목적으로 하는 고발성 제보일 경우, 관리자들의 회의 아래 게시될 수 있다. 단 다음 기준들이 엄격히 적용된다.", withFont: .boldSystemFont(ofSize: 15))
        string.setFontForText(textToFind: "제 3항) 이 외에 제 2조 1항의 기준에 해당되는 제보더라도, 논란의 소지가 없다고 판단되는 범위 내에서 대나무숲 활성화를 위해 관리자의 재량으로 게시글이 게시될 수 있다. 단, 다음 기준들이 적용된다.", withFont: .boldSystemFont(ofSize: 15))
        string.setFontForText(textToFind: "제 3조 특정 이슈로 인한 과열에 관한 규칙", withFont: .boldSystemFont(ofSize: 18))
        string.setFontForText(textToFind: "제 1항) 특정 이슈로 대나무숲이 과열이 되는 조짐을 보일 경우, 관리자들의 자체적인 판단에 따라, 해당 주제에 관한 제보 업로드를 보류하는 시스템으로, 관리자의 판단 하에 공지 없이 시행될 수 있다.", withFont: .boldSystemFont(ofSize: 15))
        $0.attributedText = string
    }

    private let backGroundScrollView = UIScrollView().then{
        $0.backgroundColor = .clear
        $0.showsVerticalScrollIndicator = false
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: - Selectors
    
    //MARK: - Helper
    private func configureUI(){
        addView()
        location()
    }

    private func addView(){
        view.addSubview(backGroundScrollView)
        backGroundScrollView.addSubview(titleLabel)
        backGroundScrollView.addSubview(ruleLabel)
    }
    private func location(){
        backGroundScrollView.snp.makeConstraints {
            $0.top.left.right.bottom.equalToSuperview()
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(bounds.height/28)
            $0.left.equalToSuperview().offset(bounds.width/26.8)
        }
        ruleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(bounds.height/38.67)
            $0.left.equalTo(titleLabel)
            $0.right.equalTo(view).inset(bounds.width/5.4347)
        }
        backGroundScrollView.contentSize = CGSize(width: view.frame.width, height: bounds.height/0.58)
    }
}
