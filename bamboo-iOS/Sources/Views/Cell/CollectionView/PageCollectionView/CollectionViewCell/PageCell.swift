//
//  PageCell.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/10/18.
//

import UIKit

class PageCell : UICollectionViewCell{
    //MARK: - id
    static let identifier = "PageCell"
    
    let mainTableView = UITableView().then{
        $0.register(BulletinBoardsTableViewCell.self, forCellReuseIdentifier: BulletinBoardsTableViewCell.identifier)
        $0.register(TableViewLoadingCell.self, forCellReuseIdentifier: TableViewLoadingCell.identifier)
        $0.showsVerticalScrollIndicator = false
        $0.separatorColor = .clear
        $0.allowsSelection = false
        $0.estimatedRowHeight = 300
        $0.rowHeight = UITableView.automaticDimension
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
