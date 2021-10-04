//
//  SpinnerView.swift
//  RavnChallenge
//
//  Created by Samuel Henriquez on 2/10/21.
//

import SwiftUI

struct SpinnerView: View {
    
    // MARK: - View Lifecycle
    var body: some View {
        ProgressView()
            .progressViewStyle(.circular)
    }
}

struct SpinnerView_Previews: PreviewProvider {
    static var previews: some View {
        SpinnerView()
    }
}
