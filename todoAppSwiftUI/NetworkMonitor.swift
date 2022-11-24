//
//  NetworkMonitor.swift
//  todoAppSwiftUI
//
//  Created by Daniel Gabzdyl on 15.11.2022.
//

import Foundation
import Network

/// Monitor network connectivity.
final class NetworkMonitor: ObservableObject {

    @Published private(set) var isConnected = false

    private let nwMonitor = NWPathMonitor()

    public func start() {
        nwMonitor.start(queue: DispatchQueue.global())
        nwMonitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnected = path.status == .satisfied
            }
        }
    }

    public func stop() {
        nwMonitor.cancel()
    }
}
