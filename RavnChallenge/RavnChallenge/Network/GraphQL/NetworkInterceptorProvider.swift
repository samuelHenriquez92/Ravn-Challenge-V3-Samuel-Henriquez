//
//  NetworkInterceptorProvider.swift
//  RavnChallenge
//
//  Created by Samuel Henriquez on 2/10/21.
//

import Apollo

struct NetworkInterceptorProvider: InterceptorProvider {
    
    // MARK: - Variables Declaration
    private let store: ApolloStore
    private let client: URLSessionClient
    
    // MARK: - Initializers
    init(
        store: ApolloStore,
        client: URLSessionClient
    ) {
        self.store = store
        self.client = client
    }
    
    // MARK: - InterceptorProvider Implementation
    func interceptors<Operation: GraphQLOperation>(for operation: Operation) -> [ApolloInterceptor] {
        [
            MaxRetryInterceptor(),
            CacheReadInterceptor(store: self.store),
            NetworkFetchInterceptor(client: self.client),
            ResponseCodeInterceptor(),
            JSONResponseParsingInterceptor(cacheKeyForObject: self.store.cacheKeyForObject),
            AutomaticPersistedQueryInterceptor(),
            CacheWriteInterceptor(store: self.store)
        ]
    }
}
