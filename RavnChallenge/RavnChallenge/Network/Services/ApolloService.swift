//
//  ApolloService.swift
//  RavnChallenge
//
//  Created by Samuel Henriquez on 1/10/21.
//

import Apollo
import Combine
import Foundation

protocol ApolloServiceType {
    
    // MARK: - Variables Declaration
    var baseUrl: URL { get }
    
    // MARK: - Protocol Methods
    func executeQuery<T: GraphQLQuery>(query: T) -> AnyPublisher<T.Data, Error>
}

final class ApolloService: ApolloServiceType {
    
    // MARK: - Variables Declaration
    static let shared = ApolloService()
    
    lazy var apollo = ApolloClient(url: baseUrl)
    
    struct ApolloError: Error {
        let description: String
    }
    
    // MARK: - Initializers
    private init() {}
    
    // MARK: - ApolloClientType Implementation
    var baseUrl: URL {
        URL(string: "https://dex-server.herokuapp.com")!
    }
    
    func executeQuery<T>(query: T) -> AnyPublisher<T.Data, Error> where T : GraphQLQuery {
        Future<T.Data, Error> { [unowned self] promise in
            apollo.fetch(query: query) { result in
                switch result {
                case let .success(queryResult):
                    if let data = queryResult.data {
                        promise(.success(data))
                    } else if let errors = queryResult.errors {
                        let error = errors.map{ $0.localizedDescription }.joined(separator: "\n")
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
