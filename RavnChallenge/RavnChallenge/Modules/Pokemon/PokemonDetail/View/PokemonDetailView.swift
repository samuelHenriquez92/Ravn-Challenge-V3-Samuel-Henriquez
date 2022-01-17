//
//  PokemonDetailView.swift
//  RavnChallenge
//
//  Created by Samuel Henriquez on 1/14/22.
//

import NukeUI
import SwiftUI

struct PokemonDetailView: View {
    // MARK: - Defaults
    private let barTitle = "pokemonDetail.bar.title".localized()

    // MARK: - Variables Declaration
    @StateObject var viewModel: PokemonDetailViewModel

    // MARK: - View Lifecycle
    var body: some View {
        ScrollView(showsIndicators: false) {
            ZStack {
                LazyVStack {
                    
                }
                .frame(height: 256)
                .background(viewModel.detail?.color.getColor)
            }
        }
        .navigationTitle(barTitle)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct PokemonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetailView(viewModel: .init(pokemonName: "bulbasaur"))
    }
}
