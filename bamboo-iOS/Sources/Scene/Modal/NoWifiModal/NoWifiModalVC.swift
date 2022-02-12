//
//  NoWifiModalVC.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2022/01/05.
//

import UIKit
import PanModal
import RxSwift

final class NoWifiModalVC : baseVC<NoWifiModalReactor>{
    //MARK: - Properties
    private let countdown: Int = 3
    
    private let alertView = NoWifiAlertView().then{
        $0.layer.cornerRadius = 10
    }
    
    //MARK: - Helper
    override func addView() {
        super.addView()
        view.addSubview(alertView)
    }
    
    override func setLayout() {
        super.setLayout()
        alertView.snp.makeConstraints{
            $0.height.equalTo(60)
            $0.left.right.equalToSuperview().inset(20)
        }
    }
    
    override func bindAction(reactor: NoWifiModalReactor) {
        self.rx.viewDidAppear
            .map{ _ in Reactor.Action.timerStart}
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
}
extension NoWifiModalVC : PanModalPresentable{
    var panScrollable: UIScrollView? {return nil}
    var shortFormHeight: PanModalHeight{return .contentHeight(68)}
    var longFormHeight: PanModalHeight {return shortFormHeight}
    var panModalBackgroundColor: UIColor {return .clear}
    var shouldRoundTopCorners: Bool {return false}
    var showDragIndicator: Bool {return false}
    var anchorModalToLongForm: Bool {return false}
    var isUserInteractionEnabled: Bool {return false}
}
