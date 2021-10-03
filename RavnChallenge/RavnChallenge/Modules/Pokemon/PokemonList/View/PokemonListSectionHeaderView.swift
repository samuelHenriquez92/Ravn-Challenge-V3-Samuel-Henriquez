//
//  PokemonListSectionHeaderView.swift
//  RavnChallenge
//
//  Created by Samuel Henriquez on 2/10/21.
//

import SwiftUI

struct PokemonListSectionHeaderView: View {
    
    let name: String
    
    var body: some View {
        VStack(spacing: 2) {
            Text(name)
                .foregroundColor(.sectionHeader)
                .applyTextStyle(with: .title3)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Divider()
        }
        .frame(maxHeight: 24, alignment: .leading)
        .padding(.vertical, 6)
    }
}

struct PokemonListSectionHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonListSectionHeaderView(name: "Generacion I")
    }
}
