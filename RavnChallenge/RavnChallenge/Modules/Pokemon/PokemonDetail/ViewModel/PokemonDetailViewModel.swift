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
    @Published private var sprites: PokemonSprite?

    // Input
    private let fetchPokemonDetailInput = PassthroughSubject<String, Never>()
    @Published var changePokemonSpriteInput = 0

    // Output
    @Published var isLoading: Bool = false
    @Published var showErrorAlert: Bool = false
    @Published var errorMessage: String = ""
    @Published var detail: PokemonDetail?
    @Published var sprite = ""

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

        let fetchPokemonSpriteResponse =
            fetchPokemonDetail
            .flatMap { [service] pokemonId in
                service.fetchSprites(with: pokemonId).materialize()
            }
            .share()

        $changePokemonSpriteInput
            .compactMap { [weak self] index in
                index == 0 ? self?.sprites?.frontDefault : self?.sprites?.frontShiny
            }
            .assign(to: &$sprite)

        // Output
        /// States
        fetchPokemonDetail
            .map { _ in true }
            .assign(to: &$isLoading)

        Publishers.Merge(
            fetchPokemonDetailResponse.map { _ in },
            fetchPokemonSpriteResponse.map { _ in }
        )
        .map { _ in false }
        .assign(to: &$isLoading)

        /// Success
        let fetchPokemonDetailSuccess =
            fetchPokemonDetailResponse
            .values()
            .share()

        let fetchPokemonSpritesSuccess =
            fetchPokemonSpriteResponse
            .values()
            .share()

        fetchPokemonDetailSuccess
            .compactMap { $0 }
            .assign(to: &$detail)

        fetchPokemonSpritesSuccess
            .compactMap { $0 }
            .assign(to: &$sprites)

        fetchPokemonSpritesSuccess
            .compactMap { $0.frontDefault }
            .assign(to: &$sprite)

        /// Failure
        let fetchPokemonDetailFailure =
            fetchPokemonDetailResponse
            .failures()
            .share()

        let fetchPokemonSpritesFailure =
            fetchPokemonSpriteResponse
            .failures()
            .share()

        Publishers.Merge(
            fetchPokemonDetailFailure,
            fetchPokemonSpritesFailure
        )
        .compactMap { $0.localizedDescription }
        .assign(to: &$errorMessage)
    }
}
