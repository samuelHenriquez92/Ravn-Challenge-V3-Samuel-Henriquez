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
    private let connectionAsset = "connection"

    // MARK: - Variables Declaration
    @EnvironmentObject var networkReachability: NetworkReachability
    @StateObject private var viewModel = PokemonListViewModel()
    @State private var connectivityAlert = false
    @State private var navigate = false
    @State private var pokemonIdSelected = ""

    // MARK: - View Lifecycle
    var body: some View {
        ZStack {
            if viewModel.isLoading {
                SpinnerView()
            } else if !networkReachability.reachable {
                Image(connectionAsset)
            } else {
                ScrollView {
                    LazyVStack {
                        ForEach(viewModel.generationsSource, id: \.name) { generation in
                            Section(
                                content: {
                                    ForEach(generation.pokemons, id: \.name) { pokemon in
                                        let cellViewModel = PokemonCellViewModel(pokemon: pokemon)
                                        PokemonCellView(viewModel: cellViewModel) {
                                            if let id = pokemon.id {
                                                pokemonIdSelected = "\(id)"
                                                navigate.toggle()
                                            }
                                        }
                                    }
                                },
                                header: {
                                    PokemonListSectionHeaderView(name: generation.name)
                                }
                            )
                        }
                    }
                    NavigationLink(isActive: $navigate) {
                        PokemonDetailView(viewModel: .init(pokemonName: pokemonIdSelected))
                    } label: {
                        EmptyView()
                    }
                }
            }
        }
        .onReceive(networkReachability.$reachable.dropFirst()) { reachable in
            connectivityAlert = !reachable
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
        .navigationBarTitle(!navigate ? barTitle : "")
        .checkForConnectivity(showAlert: $connectivityAlert)
    }
}

struct PokemonListView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonListView()
    }
}
