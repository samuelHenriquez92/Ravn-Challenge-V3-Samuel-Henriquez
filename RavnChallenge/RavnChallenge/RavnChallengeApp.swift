//
//  RavnChallengeApp.swift
//  RavnChallenge
//
//  Created by Samuel Henriquez on 1/10/21.
//

import SwiftUI

@main
struct RavnChallengeApp: App {
    
    // MARK: - Variables Declaration
    @StateObject var networkReachability = NetworkReachability()
    
    // MARK: - App Implementation
    var body: some Scene {
        WindowGroup {
            NavigationView {
                PokemonListView()
                    .environmentObject(networkReachability)
            }
        }
    }
}
