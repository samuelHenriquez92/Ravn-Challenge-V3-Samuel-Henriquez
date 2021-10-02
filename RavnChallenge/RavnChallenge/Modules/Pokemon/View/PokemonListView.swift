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
    
    private var pokemonList: some View {
        List {
            ForEach(viewModel.generations, id: \.name) { generation in
                Section(content: {
                    ForEach(generation.pokemons, id: \.name) { pokemon in
                        Text(pokemon.name ?? "")
                    }
                }, header: {
                    Text(generation.name)
                })
            }
        }
        .listStyle(PlainListStyle())
    }
    
    // MARK: - View Lifecycle
    var body: some View {
        ZStack {
            if viewModel.isLoading {
                SpinnerView()
            } else {
                pokemonList
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
        .navigationBarTitle(barTitle)
    }
}

struct PokemonListView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonListView()
    }
}
