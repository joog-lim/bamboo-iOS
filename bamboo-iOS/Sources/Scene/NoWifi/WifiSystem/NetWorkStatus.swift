//
//  NetWorkStatus.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/09/30.
//

import Network

final class NetWorkStatus {
    //MARK: - 싱글턴 패턴
    static let shared = NetWorkStatus()
    private let queue = DispatchQueue.global()
    private let monitor : NWPathMonitor
    
    public private(set) var isConnect : Bool = false
    public private(set) var connectionType : ConnectionType = .unknown
    
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
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnect = path.status == .unsatisfied
            self?.getConnectionType(path)
            print(self?.isConnect ?? "N/A")
        }
        monitor.start(queue: queue)
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
