//
//  ApolloService.swift
//  RavnChallenge
//
//  Created by Samuel Henriquez on 1/10/21.
//

import Apollo
import Combine

protocol ApolloServiceType {
    func executeQuery<T: GraphQLQuery>(query: T) -> AnyPublisher<T.Data, Error>
}

final class ApolloService: ApolloServiceType {
    // MARK: - Variables Declaration
    private let apollo: ApolloClient

    struct ApolloError: Error {
        let description: String
    }

    // MARK: - Initializers
    init(
        apollo: ApolloClient
    ) {
        self.apollo = apollo
    }

    // MARK: - ApolloClientType Implementation
    func executeQuery<T>(query: T) -> AnyPublisher<T.Data, Error> where T: GraphQLQuery {
        Future<T.Data, Error> { [weak apollo] promise in
            apollo?.fetch(query: query) { result in
                switch result {
                case let .success(queryResult):
                    if let data = queryResult.data {
                        promise(.success(data))
                    } else if let errors = queryResult.errors {
                        let error = errors.map { $0.localizedDescription }.joined(separator: "\n")
                        promise(.failure(ApolloError(description: error)))
                    }
                case let .failure(error):
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
