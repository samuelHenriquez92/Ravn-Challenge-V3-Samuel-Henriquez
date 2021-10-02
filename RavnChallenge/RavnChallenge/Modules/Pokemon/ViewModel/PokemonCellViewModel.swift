//
//  PokemonCellViewModel.swift
//  RavnChallenge
//
//  Created by Samuel Henriquez on 2/10/21.
//

import Foundation

struct PokemonCellViewModel {
    
    // MARK: - Variables Declaration
    private let pokemon: Pokemon
    
    var name: String {
        pokemon.name?.capitalized ?? ""
    }
    
    var id: String {
        "#" + (pokemon.id?.numberFormattedWithZeros ?? "")
    }
    
    var imageUrl: URL? {
        URL(string: pokemon.sprites?.frontDefault ?? "")
    }
    
    var types: [PokemonType] {
        pokemon.types ?? .init()
    }
    
    // MARK: - Initializers
    init(pokemon: Pokemon) {
        self.pokemon = pokemon
    }
}
