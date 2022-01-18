//
//  PokemonDetailService.swift
//  RavnChallenge
//
//  Created by Samuel Henriquez on 1/17/22.
//

import Combine
import Foundation
import Moya

protocol PokemonDetailServiceType {
    func fecthPokemonDetail(with id: String) -> AnyPublisher<PokemonDetail, Error>
    func fetchSprites(with id: String) -> AnyPublisher<PokemonSprite, Error>
}

final class PokemonDetailService: PokemonDetailServiceType {
    // MARK: - Variables Declaration
    private let provider: RestfulServiceType

    // MARK: - Initilizers
    init(
        provider: RestfulServiceType = RestfulService(
            provider: MoyaProvider<MultiTarget>(plugins: [NetworkLoggerPlugin()])
        )
    ) {
        self.provider = provider
    }

    // MARK: - PokemonDetailServiceType Implementation
    func fecthPokemonDetail(with id: String) -> AnyPublisher<PokemonDetail, Error> {
        provider.execute(target: MultiTarget(PokemonDetailTarget.detail(id: id)))
            .eraseToAnyPublisher()
    }

    func fetchSprites(with id: String) -> AnyPublisher<PokemonSprite, Error> {
        provider.execute(target: MultiTarget(PokemonDetailTarget.sprites(id: id)))
            .eraseToAnyPublisher()
    }
}
