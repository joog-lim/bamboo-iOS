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
    }
    func location(){
        backGroundScrollView.snp.makeConstraints {
            $0.top.left.right.bottom.equalToSuperview()
        }
        backGroundScrollView.contentSize = CGSize(width: view.frame.width, height: bounds.height/0.938728)
    }
}
