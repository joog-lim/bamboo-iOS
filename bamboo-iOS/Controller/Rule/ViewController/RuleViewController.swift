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
    
    private  let greetingsLabel = UILabel().then{
        $0.textColor = .black
        $0.numberOfLines = 0
        $0.dynamicFont(fontSize: 15, currentFontName: "NanumSquareRoundR")
        let string : NSMutableAttributedString = NSMutableAttributedString(string: ruleString.greetings.rawValue)
        string.setFontForText(textToFind: "안녕하세요,광대숲 개발자입니다.", withFont: .boldSystemFont(ofSize: 15))
        $0.attributedText = string
    }
    private let somethingIAskOften = UILabel().then{
        $0.numberOfLines = 0
        $0.dynamicFont(fontSize: 15, currentFontName: "NanumSquareRoundR")
        let string : NSMutableAttributedString = NSMutableAttributedString(string: """
        자주 묻는 말
        
        Q. 광대숲이란 무엇인가요?
        
        A. 광대숲은 “광주소프트웨어마이스터고등학교"의
        대나무 숲으로써 익명으로 사람들과 소통할 수 있는
        익명 커뮤니티입니다.
        
        Q. 댓글을 달 순 없나요?
        
        A. 댓글 기능이 없는 이유는, 댓글의 여론이 좋지 않아
        게시글로 자신만의 이야기를 쉬이 나눌 수 없는 환경을 예방하기 위함입니다.
        Q. 글에 반응을 달고 싶어요.
        A. 각 알고리즘들에 반응을 표시하기 위해 이모지를 다는 방안을 검토 중에 있습니다.
        Q. 내 의견을 찾을 수 없어요.
        A. 광대숲은 모든 글이 관리자의 허가를 맡아서 올라가기에 올라갈 때 시간이 걸릴 수 있습니다.
        또한 부적절한 내용으로 검토 및 삭제가 되었을 수 있습니다.
        자세한 내용은 규칙을 참고해주세요.
        """)
        string.setFontForText(textToFind: "", withFont: .boldSystemFont(ofSize: 15))
        $0.attributedText = string
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
