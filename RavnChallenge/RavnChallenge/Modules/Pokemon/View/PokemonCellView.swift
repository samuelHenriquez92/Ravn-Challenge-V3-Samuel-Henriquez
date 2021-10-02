//
//  PokemonCellView.swift
//  RavnChallenge
//
//  Created by Samuel Henriquez on 2/10/21.
//

import Kingfisher
import SwiftUI

struct PokemonCellView: View {
    
    // MARK: - Defaults
    private let rectangle = "Rectangle"
    
    // MARK: - Variables Declaration
    let viewModel: PokemonCellViewModel
    
    // MARK: - Initializers
    init(viewModel: PokemonCellViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: - View Lifecycle
    var body: some View {
        ZStack {
            Image(rectangle).opacity(0.5)
            
            HStack {
                KFImage(viewModel.imageUrl)
                    .frame(maxWidth: 72, maxHeight: 72)
                    .offset(.init(width: -12, height: 0))
                    .shadow(radius: 5)
                
                VStack(
                    alignment: .leading,
                    spacing: 5
                ) {
                    Text(viewModel.name).fontWeight(.semibold)
                    Text(viewModel.id)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack(
                    spacing: 10
                ) {
                    ForEach(
                        viewModel.types,
                        id: \.?.name
                    ) { type in
                        Image(type?.name ?? "").frame(width: 30, height: 30)
                    }
                }
                .padding(.trailing, 21)
                
            }
        }
        .listRowSeparator(.hidden)
        .padding(.horizontal, 24)
        .padding(.bottom, 12)
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
