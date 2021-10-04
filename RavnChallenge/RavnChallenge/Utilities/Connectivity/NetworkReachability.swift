//
//  NetworkReachability.swift
//  RavnChallenge
//
//  Created by Samuel Henriquez on 3/10/21.
//

import Combine
import Foundation
import Network
import SystemConfiguration

final class NetworkReachability: ObservableObject {
    
    // MARK: - Variables Declaration
    @Published var reachable = false
    
    // MARK: - Initializers
    init() {
        NWPathMonitor()
            .publisher()
            .delay(for: .seconds(0.5), scheduler: RunLoop.main, options: .none)
            .map { $0.status == .satisfied }
            .assign(to: &$reachable)
    }
    
    // MARK: - Public Methods
    func checkConnection() {
        let reachability = SCNetworkReachabilityCreateWithName(nil, "www.apple.com")
        var flags = SCNetworkReachabilityFlags()
        SCNetworkReachabilityGetFlags(reachability!, &flags)
        
        reachable = isNetworkReachable(with: flags)
    }
    
    // MARK: - Private Methods
    private func isNetworkReachable(with flags: SCNetworkReachabilityFlags) -> Bool {
        let isReachable = flags.contains(.reachable)
        let connectionRequired = flags.contains(.connectionRequired)
        let canConnectAutomatically = flags.contains(.connectionOnDemand) || flags.contains(.connectionOnTraffic)
        let canConnectWithoutIntervention = canConnectAutomatically && !flags.contains(.interventionRequired)
        return isReachable && (!connectionRequired || canConnectWithoutIntervention)
    }
}
