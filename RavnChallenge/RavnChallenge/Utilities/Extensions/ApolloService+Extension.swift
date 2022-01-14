//
//  ApolloService+Extension.swift
//  RavnChallenge
//
//  Created by Samuel Henriquez on 1/14/22.
//

import Apollo
import ApolloSQLite
import Foundation

extension ApolloClient {
    // MARK: - Variables Declaration
    static let retrierClient: ApolloClient = {
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

    static private var baseUrl: URL {
        URL(string: K.Network.graphqlAPIBaseUrl)!
    }

    // MARK: - Private Methods
    static private func setupStore() -> ApolloStore {
        // 1. You'll have to figure out where to store your SQLite file.
        // A reasonable place is the user's Documents directory in your sandbox.
        // In any case, create a file URL for your file:
        let documentsPath = NSSearchPathForDirectoriesInDomains(
            .documentDirectory,
            .userDomainMask,
            true
        ).first!
        let documentsURL = URL(fileURLWithPath: documentsPath)
        let sqliteFileURL = documentsURL.appendingPathComponent(K.Persistence.graphqlDatabaseId)

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
