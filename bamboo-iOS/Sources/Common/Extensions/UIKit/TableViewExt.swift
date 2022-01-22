//
//  tableViewExt.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2022/01/23.
//

import UIKit

extension UITableView{
    func sameSetting(){
        separatorColor = .clear
        allowsSelection = false
        showsVerticalScrollIndicator = false
        rowHeight = UITableView.automaticDimension
        estimatedRowHeight = 300
        sectionHeaderHeight = 152
        sectionFooterHeight = 50
    }
}
