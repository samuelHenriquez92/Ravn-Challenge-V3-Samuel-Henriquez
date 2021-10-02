//
//  PokemonListViewModel.swift
//  RavnChallenge
//
//  Created by Samuel Henriquez on 1/10/21.
//

import Combine
import SwiftUI

typealias PokemonGeneration = (name: String, pokemons: [Pokemon])

class PokemonListViewModel: ObservableObject {
    
    // MARK: - Variables Declaration
    @Published var generations: [PokemonGeneration] = .init()
    @Published var isLoading = false
    @Published var showAlert = false
    @Published var errorMessage = ""
    
    private let service: PokemonServiceType
    internal var cancellables = Set<AnyCancellable>()
    
    // MARK: - Initilizers
    init(service: PokemonServiceType = PokemonService()) {
        self.service = service
    }
    
    // MARK: - Public Methods
    func fetchPokemons() {
        isLoading = true
        
        service.fetchPokemons()
            .sink { [unowned self] completion in
                isLoading = false
                
                switch completion {
                case let .failure(error):
                    showAlert.toggle()
                    errorMessage = error.localizedDescription
                case .finished:
                    return
                }
            } receiveValue: { [unowned self] pokemonList in
                let generationsArray = pokemonList.compactMap { $0.generation }.removeDuplicates()
                generations = generationsArray.map { generation in
                    PokemonGeneration(
                        name: generation,
                        pokemons: pokemonList.filter { $0.generation ?? "" == generation }
                    )
                }
            }
            .store(in: &cancellables)
    }
}
