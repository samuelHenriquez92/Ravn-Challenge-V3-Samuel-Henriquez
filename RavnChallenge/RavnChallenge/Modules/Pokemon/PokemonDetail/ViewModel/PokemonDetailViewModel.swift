//
//  PokemonDetailViewModel.swift
//  RavnChallenge
//
//  Created by Samuel Henriquez on 1/17/22.
//

import Combine
import CombineExt
import Foundation

final class PokemonDetailViewModel: ObservableObject {
    // MARK: - Variables Declaration
    private let service: PokemonDetailServiceType
    private let pokemonName: String
    // Input
    private let fetchPokemonDetailInput = PassthroughSubject<String, Never>()

    // Output
    @Published var isLoading: Bool = false
    @Published var showErrorAlert: Bool = false
    @Published var errorMessage: String = ""
    @Published var detail: PokemonDetail?

    // MARK: - Initializers
    init(
        pokemonName: String,
        service: PokemonDetailServiceType = PokemonDetailService()
    ) {
        self.pokemonName = pokemonName
        self.service = service

        setupBindings()
        fetchPokemonDetailInput.send(pokemonName)
    }

    // MARK: - Private Methods
    private func setupBindings() {
        // Input
        let fetchPokemonDetail = fetchPokemonDetailInput.share()

        // Process
        let fetchPokemonDetailResponse =
            fetchPokemonDetail
            .flatMap { [service] pokemonId in
                service.fecthPokemonDetail(with: pokemonId).materialize()
            }
            .share()

        // Output
        /// States
        fetchPokemonDetail
            .map { _ in true }
            .assign(to: &$isLoading)

        fetchPokemonDetailResponse
            .map { _ in false }
            .assign(to: &$isLoading)

        /// Success
        let fetchPokemonDetailSuccess =
            fetchPokemonDetailResponse
            .values()
            .share()

        fetchPokemonDetailSuccess
            .compactMap { $0 }
            .assign(to: &$detail)

        /// Failure
        let fetchPokemonDetailFailure =
            fetchPokemonDetailResponse
            .failures()
            .share()

        fetchPokemonDetailFailure
            .compactMap { $0.localizedDescription }
            .assign(to: &$errorMessage)
    }
}
