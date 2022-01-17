//
//  PokemonColor.swift
//  RavnChallenge
//
//  Created by Samuel Henriquez on 1/17/22.
//

import SwiftUI

struct PokemonColor: Codable {
    let name: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case name, url
    }
}

extension PokemonColor {
    var getColor: Color {
        switch name {
        case "black":
            return .cBlack
        case "blue":
            return .cBlue
        case "brown":
            return .cBrown
        case "gray":
            return .cGray
        case "green":
            return .cGreen
        case "pink":
            return .cPink
        case "purple":
            return .cPurple
        case "red":
            return .cRed
        case "white":
            return .cWhite
        case "yellow":
            return .cYellow
        default:
            return .white
        }
    }
}
