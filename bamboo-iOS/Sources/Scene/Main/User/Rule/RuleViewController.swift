//
//  RuleViewController.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/09/22.
//

import UIKit
import Then
import SnapKit
import RxCocoa
import RxSwift
import ReactorKit
import RxViewController

final class RuleViewController : baseVC<RuleReactor> {
    //MARK: - Properties
    
    private let titleLabel = UILabel().then{
        $0.text = "규칙"
        $0.textColor = .bamBoo_57CC4D
        $0.font = UIFont(name: "NanumSquareRoundB", size: 20)
    }
    
    private let  ruleLabel = ExplanationLabel(fontSize: 13, fontStyle: "NanumSquareRoundR", labelColor: .black)
    
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
        backGroundScrollView.addSubviews(titleLabel,ruleLabel)
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
    override func bindAction(reactor: RuleReactor) {
        self.rx.viewDidLoad
            .map{ _ in Reactor.Action.loadData}
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    override func bindState(reactor: RuleReactor) {
        reactor.state.observe(on: MainScheduler.instance)
            .subscribe(onNext:{
                let string = NSMutableAttributedString(string: $0.rule ?? "")
                $0.fifteen?.forEach{string.setFontForText(textToFind: $0, withFont: UIFont(name: "NanumSquareRoundB", size: 15) ?? UIFont())}
                $0.thirteen?.forEach{string.setFontForText(textToFind: $0, withFont: UIFont(name: "NanumSquareRoundB", size: 13) ?? UIFont())}
                self.ruleLabel.attributedText = string
            }).disposed(by: disposeBag)
    }
}
