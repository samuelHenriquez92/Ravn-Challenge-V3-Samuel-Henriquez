//
//  PokemonListViewModel.swift
//  RavnChallenge
//
//  Created by Samuel Henriquez on 1/10/21.
//

import Combine
import CombineExt
import SwiftUI

typealias PokemonGeneration = (name: String, pokemons: [Pokemon])

class PokemonListViewModel: ObservableObject {
    // MARK: - Variables Declaration
    // Input
    let fetchPokemonsInput = PassthroughSubject<Void, Never>()

    // Output
    @Published var isLoading = false
    @Published var showAlert = false
    @Published var errorMessage = ""
    @Published var searchText = ""
    @Published var generationsSource = [PokemonGeneration]()

    private let service: PokemonServiceType
    private var cancellables = Set<AnyCancellable>()
    private var generations = [PokemonGeneration]()

    // MARK: - Initilizers
    init(
        service: PokemonServiceType = PokemonService()
    ) {
        self.service = service
        setupBindings()

        fetchPokemonsInput.send()
    }

    // MARK: - Public Methods
    private func setupBindings() {
        /// Input
        let fetchPokemons = fetchPokemonsInput.share()

        /// Output
        fetchPokemons
            .compactMap { _ in true }
            .assign(to: &$isLoading)

        let fetchPokemonsResult =
            fetchPokemons
            .flatMap { [service] in
                service.fetchPokemons().materialize()
            }
            .share()

        fetchPokemonsResult
            .compactMap { _ in false }
            .assign(to: &$isLoading)

        $searchText
            .compactMap { [weak self] text -> [PokemonGeneration] in
                guard !text.isEmpty else { return self?.generations ?? .init() }

                return self?.generations.reduce(
                    [PokemonGeneration](),
                    { result, generation in
                        let pokemons = generation.pokemons.filter {
                            $0.name?.lowercased().contains(text.lowercased()) ?? false
                        }
                        guard !pokemons.isEmpty else { return result }

                        var partialResult = result
                        partialResult.append(
                            PokemonGeneration(
                                name: generation.name,
                                pokemons: pokemons
                            )
                        )

                        return partialResult
                    }
                ) ?? .init()
            }
            .assign(to: &$generationsSource)

        /// Success
        let fetchPokemonsSuccess =
            fetchPokemonsResult
            .values()
            .share()

        fetchPokemonsSuccess
            .compactMap { [weak self] pokemonList -> [PokemonGeneration] in
                let generationsArray = pokemonList.compactMap { $0.generation }.removeDuplicates()
                self?.generations =
                    generationsArray
                    .map { generation in
                        PokemonGeneration(
                            name: generation,
                            pokemons: pokemonList.filter { $0.generation ?? "" == generation }
                        )
                    }

                return self?.generations ?? .init()
            }
            .assign(to: &$generationsSource)

        /// Failure
        let fetchPokemonsFailure =
            fetchPokemonsResult
            .failures()
            .share()

        fetchPokemonsFailure
            .compactMap { _ in true }
            .assign(to: &$showAlert)

        fetchPokemonsFailure
            .compactMap { $0.localizedDescription }
            .assign(to: &$errorMessage)
    }
}
