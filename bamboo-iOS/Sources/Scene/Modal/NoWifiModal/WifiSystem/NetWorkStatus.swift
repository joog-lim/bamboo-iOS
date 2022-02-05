//
//  NetWorkStatus.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/09/30.
//

import Network
import UIKit

import RxFlow
import RxCocoa

final class NetWorkStatus{
    //MARK: - 싱글턴 패턴
    static let shared = NetWorkStatus()
    private let queue = DispatchQueue.global()
    private let monitor : NWPathMonitor
    public private(set) var isConnect : Bool = false
    public private(set) var connectionType : ConnectionType = .unknown
    
    //MARK: - Stepper
    var steps: PublishRelay<Step> = .init()
    
    private init(){
        monitor = NWPathMonitor()
    }
    enum ConnectionType {
        case wifi
        case cellular
        case ethernet
        case unknown
    }
    
    public func StartMonitoring(){
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnect = path.status == .satisfied
            self?.getConnectionType(path)
            if self?.isConnect == true{
                print("Connect")
            }else {
                print("disConnect")
            }
        }
    }
    
    public func StopMonitoring(){
        monitor.cancel()
    }
    
    private func getConnectionType(_ path : NWPath){
        if path.usesInterfaceType(.wifi){
            connectionType = .wifi
        }else if path.usesInterfaceType(.cellular){
            connectionType = .cellular
        }else if path.usesInterfaceType(.wiredEthernet){
            connectionType = .ethernet
        }else{
            connectionType = .unknown
        }
    }
}
