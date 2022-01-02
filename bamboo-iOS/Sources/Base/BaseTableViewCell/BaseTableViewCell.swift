//
//  BaseTableViewCe.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/09/28.
//

import UIKit
import Reusable
import RxSwift
import ReactorKit

class BaseTableViewCell<T> : UITableViewCell,Reusable{
    
    var disposeBag = DisposeBag()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        reuse()
    }
    func reuse(){ }
    
    func configure() {
        selectionStyle = .none
    }
    var model: T? {
        didSet { if let model = model { bind(model) } }
    }
    func bind(_ model: T){}
}

//new Reactor
class baseTableViewCell<T : Reactor> : UITableViewCell,Reusable{
    
    var disposeBag = DisposeBag()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        selectionStyle = .none
    }
    
    func bindView(reactor: T){}
    func bindAction(reactor: T){}
    func bindState(reactor: T){}
}

extension baseTableViewCell : View{
    func bind(reactor: T) {
        bindView(reactor: reactor)
        bindAction(reactor: reactor)
        bindState(reactor: reactor)
    }
}
