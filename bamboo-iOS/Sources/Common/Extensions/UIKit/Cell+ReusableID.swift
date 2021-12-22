//
//  Cell+ReusableID.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/12/20.
//

import UIKit

protocol ReuseIdentifiable{
    static var reusableID: String { get }
}
extension ReuseIdentifiable{
    static var reusableID : String{
        return String(describing: self)
    }
}

extension UITableViewCell : ReuseIdentifiable {}
