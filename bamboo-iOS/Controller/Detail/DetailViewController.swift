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
    
    private let backGroundScrollView = UIScrollView().then{
        $0.backgroundColor = .clear
        $0.showsVerticalScrollIndicator = true
        $0.translatesAutoresizingMaskIntoConstraints = false
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
    }
    func location(){
        backGroundScrollView.snp.makeConstraints {
            $0.top.left.right.bottom.equalToSuperview()
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(bounds.height/28)
            $0.left.equalToSuperview().offset(bounds.width/18.75)
        }
        
        backGroundScrollView.contentSize = CGSize(width: view.frame.width, height: bounds.height/0.61796)
    }
}
