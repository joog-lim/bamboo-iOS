//
//  tableViewExt.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2022/01/23.
//

import UIKit

extension UITableView{
    func sameSetting(){
        backgroundColor = .white
        separatorColor = .clear
        allowsSelection = false
        showsVerticalScrollIndicator = false
        rowHeight = UITableView.automaticDimension
        estimatedRowHeight = 300
        sectionHeaderHeight = 110
        sectionFooterHeight = 50
    }
}
