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
    private let defaultText = "pokemonDetail.defaultSprite.text".localized()
    private let shinyText = "pokemonDetail.shinySprite.text".localized()

    enum Sizes {
        static let pokemonImageContainer = 256.0
        static let pokemonImageSize = 158.4
        static let pokemonImagePaddingTop = 24.8
        static let pokemonImagePaddingBottom = 10.8
        static let pokemonSpriteSelectorHorizontalPadding = 18.0
    }

    // MARK: - Variables Declaration
    @StateObject var viewModel: PokemonDetailViewModel

    // MARK: - View Lifecycle
    var body: some View {
        ScrollView(showsIndicators: false) {
            ZStack {
                pokemonImageContainer()
            }
        }
        .navigationTitle(barTitle)
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: - Private Methods
    fileprivate func pokemonImageContainer() -> some View {
        return LazyVStack {
            LazyImage(source: viewModel.sprite) { state in
                if let image = state.image {
                    image  // Displays the loaded image
                } else if state.error != nil {
                    EmptyView()
                } else {
                    SpinnerView()
                }
            }
            .padding(.top, Sizes.pokemonImagePaddingTop)
            .padding(.bottom, Sizes.pokemonImagePaddingBottom)
            .frame(width: Sizes.pokemonImageSize, height: Sizes.pokemonImageSize, alignment: .center)

            Picker("", selection: $viewModel.changePokemonSpriteInput) {
                Text(defaultText).tag(0)
                Text(shinyText).tag(1)
            }
            .pickerStyle(.segmented)
            .padding(.horizontal, Sizes.pokemonSpriteSelectorHorizontalPadding)
        }
        .frame(height: Sizes.pokemonImageContainer)
        .background(viewModel.detail?.color.getColor)
    }
}

struct PokemonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetailView(viewModel: .init(pokemonName: "bulbasaur"))
    }
}
