//
//  Constants.swift
//  RavnChallenge
//
//  Created by Samuel Henriquez on 1/14/22.
//

import Foundation

typealias TriggerAction = () -> Void

struct K {
    // MARK: - Network
    struct Network {
        static let graphqlAPIBaseUrl = "https://dex-server.herokuapp.com"
        static let restfulAPIBaseUrl = "https://pokeapi.co/api/v2"
    }

    // MARK: - Persistance
    struct Persistence {
        static let graphqlDatabaseId = "ravn_challenge_db.sqlite"
    }
}
