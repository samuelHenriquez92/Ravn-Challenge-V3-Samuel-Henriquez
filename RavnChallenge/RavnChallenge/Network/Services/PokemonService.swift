//
//  PokemonService.swift
//  RavnChallenge
//
//  Created by Samuel Henriquez on 1/10/21.
//

import Apollo
import Combine

typealias Pokemon = FetchPokemonsQuery.Data.AllPokemon
typealias PokemonType = FetchPokemonsQuery.Data.AllPokemon.`Type`?

protocol PokemonServiceType {
    func fetchPokemons() -> AnyPublisher<[Pokemon], Error>
}

struct PokemonService: PokemonServiceType {

    // MARK: - Variables Declaration
    private let client: ApolloServiceType

    // MARK: - Initilizers
    init(
        client: ApolloServiceType = ApolloService.shared
    ) {
        self.client = client
    }

    // MARK: - CountriesServiceType Implementation
    func fetchPokemons() -> AnyPublisher<[Pokemon], Error> {
        client.executeQuery(query: FetchPokemonsQuery())
            .compactMap { $0.allPokemon?.compactMap { $0 } }
            .eraseToAnyPublisher()
    }
}
