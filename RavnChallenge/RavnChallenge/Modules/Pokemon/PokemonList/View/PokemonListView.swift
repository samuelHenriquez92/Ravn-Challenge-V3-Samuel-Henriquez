//
//  PokemonListView.swift
//  RavnChallenge
//
//  Created by Samuel Henriquez on 1/10/21.
//

import Foundation
import SwiftUI

struct PokemonListView: View {
    
    // MARK: - Defaults
    private let barTitle = "pokemonList.bar.title".localized()
    private let alertTitle = "alert.error.title".localized()
    private let acceptAlertButton = "alert.error.button.accept".localized()
    
    // MARK: - Variables Declaration
    @StateObject private var viewModel = PokemonListViewModel()
    
    // MARK: - View Lifecycle
    var body: some View {
        ZStack {
            if viewModel.isLoading {
                SpinnerView()
            } else {
                List {
                    ForEach(viewModel.generationsSource, id: \.name) { generation in
                        Section(content: {
                            ForEach(generation.pokemons, id: \.name) { pokemon in
                                let cellViewModel = PokemonCellViewModel(pokemon: pokemon)
                                PokemonCellView(viewModel: cellViewModel)
                            }
                        }, header: {
                            Text(generation.name)
                        })
                    }
                }
            }
        }
        .onAppear {
            viewModel.fetchPokemons()
        }
        .alert(
            isPresented: $viewModel.showAlert
        ) {
            Alert(
                title: Text(alertTitle),
                message: Text(viewModel.errorMessage)
            )
        }
        .searchable(
            text: $viewModel.searchText,
            placement: .navigationBarDrawer(displayMode: .always)
        )
        .listStyle(.plain)
        .navigationBarTitle(barTitle)
    }
}

struct PokemonListView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonListView()
    }
}
