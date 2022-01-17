//
//  PokemonDetail.swift
//  RavnChallenge
//
//  Created by Samuel Henriquez on 1/17/22.
//

import Foundation

// MARK: - PokemonDetail
struct PokemonDetail: Codable {
    let name: String

    enum CodingKeys: String, CodingKey {
        case name
    }
}
