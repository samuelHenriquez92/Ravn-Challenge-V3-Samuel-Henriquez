//
//  PokemonDetail.swift
//  RavnChallenge
//
//  Created by Samuel Henriquez on 1/17/22.
//

import Foundation

struct PokemonDetail: Codable {
    let name: String
    let color: PokemonColor

    enum CodingKeys: String, CodingKey {
        case name, color
    }
}
