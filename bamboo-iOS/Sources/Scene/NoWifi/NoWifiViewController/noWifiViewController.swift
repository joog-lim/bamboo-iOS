//
//  noWifi.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/09/29.
//

import UIKit
import SnapKit
import RxSwift
import ReactorKit

class noWifiViewController : BaseVC{
    //MARK: - Properties
    private lazy var icon = UIImageView.init(image: UIImage(named: "BAMBOO_NoWifi")).then{ $0.contentMode = .scaleAspectFit}
    private lazy var NoWifiLabel = UILabel().then{
        $0.font = UIFont(name: "NanumSquareRoundB", size: 20)
        $0.text = "인터넷 연결"
        $0.textColor = .black
    }
    private lazy var subNoWifiLabel = UILabel().then{
        $0.font = UIFont(name: "NanumSquareRoundR", size: 13)
        $0.text = "오프라인 상태입니다. 인터넷 연결을 확인해주세요."
        $0.textColor = .black
    }
    private lazy var tryAgainBtn = LoginButton(placeholder: "다시 시도",cornerRadius: 10).then{
        $0.layer.cornerRadius = 10
        $0.addTarget(self, action: #selector(wifiTryAgain), for: .touchUpInside)
    }
    
    //MARK: - Selectors
    @objc private func wifiTryAgain(){
        NetworkStatus()
        LodingAction()
    }
    
    //MARK: - Helper
    override func configure() {
        super.configure()
        addView()
        location()
        navigationSetting()
    }
    
    private func addView(){
        [icon,NoWifiLabel,subNoWifiLabel,tryAgainBtn].forEach{view.addSubview($0)}
    }
    
    private func location(){
        icon.snp.makeConstraints {
            $0.top.equalToSuperview().offset(bounds.height/4.7485)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(bounds.height/5.14)
            $0.width.equalTo(bounds.width/1.913)
        }
        NoWifiLabel.snp.makeConstraints {
            $0.top.equalTo(icon.snp.bottom).offset(bounds.height/47.76)
            $0.centerX.equalToSuperview()
        }
        subNoWifiLabel.snp.makeConstraints {
            $0.top.equalTo(NoWifiLabel.snp.bottom).offset(bounds.height/42.74)
            $0.centerX.equalToSuperview()
        }
        tryAgainBtn.snp.makeConstraints {
            $0.top.equalTo(subNoWifiLabel.snp.bottom).offset(bounds.height/11.3)
            $0.left.right.equalToSuperview().inset(bounds.width/7.895)
            $0.height.equalTo(bounds.height/17.65)
        }
    }
    //MARK: - Navigation Setting
    func navigationSetting(){
        navigationItem.hidesBackButton = true
        navigationItem.applyImageNavigation()
    }
    //MARK: - NetWork Status
    private func NetworkStatus(){
        if NetWorkStatus.shared.isConnect{
            DispatchQueue.main.async { [weak self] in
                self?.navigationController?.popViewController(animated: false)
            }
            print("wifi connect")
        }else{
 
            print("wifi not connect")
        }
    }
    //MARK: - Loding Action
    private func LodingAction(){
        LoadingIndicator.showLoading()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3){
            LoadingIndicator.hideLoading()
        }
    }
}
