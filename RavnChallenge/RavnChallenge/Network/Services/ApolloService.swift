//
//  ApolloService.swift
//  RavnChallenge
//
//  Created by Samuel Henriquez on 1/10/21.
//

import Apollo
import ApolloSQLite
import ApolloUtils
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
    
    private(set) lazy var apollo: ApolloClient = {
        // The cache is necessary to set up the store, which we're going to hand to the provider
        let store = setupStore()
        
        let client = URLSessionClient()
        let provider = NetworkInterceptorProvider(store: store, client: client)
        let url = baseUrl
        
        let requestChainTransport = RequestChainNetworkTransport(
            interceptorProvider: provider,
            endpointURL: url
        )
        
        return ApolloClient(networkTransport: requestChainTransport, store: store)
    }()
    
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
    
    // MARK: - Private Methods
    private func setupStore() -> ApolloStore {
        // 1. You'll have to figure out where to store your SQLite file.
        // A reasonable place is the user's Documents directory in your sandbox.
        // In any case, create a file URL for your file:
        let documentsPath = NSSearchPathForDirectoriesInDomains(
            .documentDirectory,
            .userDomainMask,
            true).first!
        let documentsURL = URL(fileURLWithPath: documentsPath)
        let sqliteFileURL = documentsURL.appendingPathComponent("ravn_challenge_db.sqlite")

        // 2. Use that file URL to instantiate the SQLite cache:
        if let sqliteCache = try? SQLiteNormalizedCache(fileURL: sqliteFileURL) {
            // 3. And then instantiate an instance of `ApolloStore` with the cache you've just created:
            return ApolloStore(cache: sqliteCache)
        } else {
            let cache = InMemoryNormalizedCache()
            return ApolloStore(cache: cache)
        }
    }
}
