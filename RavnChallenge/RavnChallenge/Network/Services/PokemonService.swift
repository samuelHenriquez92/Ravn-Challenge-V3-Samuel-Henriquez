//
//  PokemonService.swift
//  RavnChallenge
//
//  Created by Samuel Henriquez on 1/10/21.
//

import Apollo
import Combine

typealias Pokemons = FetchPokemonsQuery.Data.AllPokemon

protocol PokemonServiceType {
    func fetchPokemons() -> AnyPublisher<[Pokemons], Error>
}

struct PokemonService: PokemonServiceType {
    
    // MARK: - Variables Declaration
    private let client: ApolloServiceType
    
    // MARK: - Initilizers
    init(client: ApolloServiceType = ApolloService.shared) {
        self.client = client
    }
    
    // MARK: - CountriesServiceType Implementation
    func fetchPokemons() -> AnyPublisher<[Pokemons], Error> {
        client.executeQuery(query: FetchPokemonsQuery())
            .map { data in
                let pokemons = data.allPokemon?.compactMap { $0 }
                return pokemons ?? .init()
            }
            .eraseToAnyPublisher()
    }
}
