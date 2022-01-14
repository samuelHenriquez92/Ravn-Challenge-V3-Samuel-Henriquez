//
//  PokemonDetailView.swift
//  RavnChallenge
//
//  Created by Samuel Henriquez on 1/14/22.
//

import SwiftUI

struct PokemonDetailView: View {
    // MARK: - Defaults
    private let barTitle = "pokemonDetail.bar.title".localized()

    // MARK: - Variables Declaration
    var body: some View {
        ScrollView(showsIndicators: false) {
            
        }
        .navigationTitle(barTitle)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct PokemonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetailView()
    }
}
