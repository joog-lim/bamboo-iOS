//
//  ManagerViewController.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/10/05.
//

import UIKit

class ManagerViewController: BaseViewController{
    //MARK: - Properties
    private lazy var tableViewHeader = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: bounds.height/10.15)).then{
        $0.backgroundColor = .clear
    }
    private let titleLabel = UILabel().then{
        let string : NSMutableAttributedString = NSMutableAttributedString(string: "안녕하세요,\n관리자님!")
        $0.dynamicFont(fontSize: 20, currentFontName: "NanumSquareRoundB")
        $0.textColor = .rgb(red: 87, green: 204, blue: 77)
        $0.numberOfLines = 2
        string.setColorForText(textToFind: "무엇인가요?", withColor: .black)
        $0.attributedText = string
    }
    private let mainTableView : UITableView = {
        let tv = UITableView()
        tv.register(BulletinBoardsTableViewCell.self, forCellReuseIdentifier: BulletinBoardsTableViewCell.identifier)
        tv.register(TableViewLoadingCell.self, forCellReuseIdentifier: TableViewLoadingCell.identifier)
        tv.showsVerticalScrollIndicator = false
        tv.allowsSelection = false
        tv.estimatedRowHeight = 300
        tv.rowHeight = UITableView.automaticDimension
        return tv
    }()
    //MARK: - Selectors
    
    //MARK: - Helpers
    override func configure() {
        super.configure()
        mainTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: bounds.height/22, right: 0)
        addView()
        location()
        tableViewHeaderSetting()
    }
    private func addView(){
        view.addSubview(mainTableView)
    }
    private func location(){
        mainTableView.snp.makeConstraints {
            $0.top.bottom.left.right.equalToSuperview()
        }
    }
    private func tableViewHeaderSetting(){
        mainTableView.tableHeaderView = tableViewHeader
        mainTableView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(bounds.height/40.6)
            $0.left.equalToSuperview().offset(bounds.width/18.75)
        }
    }

}
