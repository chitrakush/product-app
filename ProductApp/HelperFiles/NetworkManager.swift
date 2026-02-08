//
//  NetworkManager.swift
//  ProductApp
//
//  Created by Chitra on 07/02/26.
//

import Network

final class NetworkMonitor {
    static let shared = NetworkMonitor()
    private let monitor = NWPathMonitor()
    private(set) var isConnected = true
        
    private init() {
        monitor.pathUpdateHandler = { [weak self] path in
            // it does not update the status on simulator sometimes and returns path.status == .unsatisfied after reconnecting to network, but works on real device.
            // ref link: https://stackoverflow.com/questions/57223756/nwpathmonitor-not-calling-satisfied-in-swift
            self?.isConnected = path.status == .satisfied
        }
        monitor.start(queue: DispatchQueue.global())
    }
}
