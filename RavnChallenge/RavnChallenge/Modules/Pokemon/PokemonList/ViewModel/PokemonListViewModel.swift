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
    @Published var isLoading = false
    @Published var showAlert = false
    @Published var errorMessage = ""
    @Published var searchText = ""

    private let service: PokemonServiceType
    private var cancellables = Set<AnyCancellable>()
    private var generations: [PokemonGeneration] = .init()
    
    var generationsSource: [PokemonGeneration] {
        guard !searchText.isEmpty else { return generations }
        
        return generations.reduce([PokemonGeneration](), { result, generation in
            let pokemons = generation.pokemons.filter { $0.name?.lowercased().contains(searchText.lowercased()) ?? false }
            guard !pokemons.isEmpty else { return result }
            
            var partialResult = result
            partialResult.append(PokemonGeneration(
                name: generation.name,
                pokemons: pokemons
            ))

            return partialResult
        })
    }

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
