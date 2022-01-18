//
//  PokemonSprite.swift
//  RavnChallenge
//
//  Created by Samuel Henriquez on 1/17/22.
//

import Foundation

struct PokemonSprite: Codable {
    let frontDefault: String
    let frontShiny: String

    enum CodingKeys: String, CodingKey {
        case sprites
    }

    enum SpritesCodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case frontShiny = "front_shiny"
    }

    init(
        from decoder: Decoder
    ) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let sprites = try container.nestedContainer(keyedBy: SpritesCodingKeys.self, forKey: .sprites)
        frontDefault = try sprites.decode(String.self, forKey: .frontDefault)
        frontShiny = try sprites.decode(String.self, forKey: .frontShiny)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        var sprites = container.nestedContainer(keyedBy: SpritesCodingKeys.self, forKey: .sprites)
        try sprites.encode(frontDefault, forKey: .frontDefault)
        try sprites.encode(frontShiny, forKey: .frontShiny)
    }
}
