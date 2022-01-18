//
//  RestfulService.swift
//  RavnChallenge
//
//  Created by Samuel Henriquez on 1/14/22.
//

import Combine
import Foundation
import Moya

protocol RestfulServiceType {
    func execute<T: Decodable>(target: MultiTarget) -> AnyPublisher<T, Error>
}

final class RestfulService: RestfulServiceType {
    // MARK: - Variables Declaration
    private let provider: MoyaProvider<MultiTarget>

    // MARK: - Initializers
    init(
        provider: MoyaProvider<MultiTarget>
    ) {
        self.provider = provider
    }

    // MARK: - RestfulServiceType Implementation
    func execute<T>(target: MultiTarget) -> AnyPublisher<T, Error> where T: Decodable {
        Future<T, Error> { [weak provider] promise in
            provider?.request(target) { result in
                switch result {
                case let .success(response):
                    do {
                        let results = try JSONDecoder().decode(T.self, from: response.data)
                        promise(.success(results))
                    } catch let error {
                        promise(.failure(error))
                    }
                case let .failure(error):
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
