//
//  PokemonCellView.swift
//  RavnChallenge
//
//  Created by Samuel Henriquez on 2/10/21.
//

import SwiftUI

struct PokemonCellView: View {
    
    // MARK: - Defaults
    private let pokemonImageSize: CGSize = .init(width: 72, height: 72)
    private let pokemonImageOffset: CGSize = .init(width: -12, height: 0)
    private let typeImageSize: CGSize = .init(width: 30, height: 30)
    
    // MARK: - Variables Declaration
    let viewModel: PokemonCellViewModel
    
    // MARK: - Initializers
    init(viewModel: PokemonCellViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: - View Lifecycle
    var body: some View {
        ZStack {
            Color.pokemonCell
                .cornerRadius(16)
                .padding(.leading, 12)
            
            HStack(spacing: 16) {
                AsyncImage(
                    url: viewModel.imageUrl
                ) { pokemonImage in
                    pokemonImage.scaledToFit()
                } placeholder: {
                    SpinnerView()
                }
                .frame(maxWidth: pokemonImageSize.width, maxHeight: pokemonImageSize.height)
                .offset(pokemonImageOffset)
                .shadow(radius: 5)
                
                VStack(
                    alignment: .leading,
                    spacing: 5
                ) {
                    Text(viewModel.name).applyTextStyle(with: .bodyEmphasis)
                    Text(viewModel.id).applyTextStyle(with: .body)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack(
                    spacing: 10
                ) {
                    ForEach(
                        viewModel.types,
                        id: \.self
                    ) { type in
                        Image(type).frame(width: typeImageSize.width, height: typeImageSize.height)
                    }
                }
                .padding(.trailing, 21)
            }
        }
        .listRowSeparator(.hidden)
        .padding(.horizontal, 24)
        .padding(.vertical, 6)
    }
}

struct PokemonCellView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonCellView(
            viewModel: .init(
                pokemon: .init(
                    id: 1,
                    name: "Bulbasaur",
                    generation: "Generacion I",
                    types: .init(),
                    sprites: .init(
                        frontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png"
                    )
                )
            )
        ).previewLayout(.sizeThatFits)
    }
}
