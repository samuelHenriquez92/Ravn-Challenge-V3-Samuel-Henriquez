//
//  NoInternetConnectionView.swift
//  RavnChallenge
//
//  Created by Samuel Henriquez on 3/10/21.
//

import SwiftUI

struct NoInternetConnectionView: ViewModifier {
    
    // MARK: - Variables Declaration
    private let alertTitle = "reachability.alert.error.title".localized()
    private let alertMessage = "reachability.alert.error.message".localized()
    private let cancelAlertButton = "alert.error.button.cancel".localized()
    private let retrytAlertButton = "alert.error.button.retry".localized()
    
    @EnvironmentObject var networkReachability: NetworkReachability
    @Binding var showAlert: Bool
    
    // MARK: - ViewModifier Implementation
    func body(content: Content) -> some View {
        VStack {
            content
            Spacer()
        }
        .alert(
            isPresented: $showAlert
        ) {
            Alert(
                title: Text(alertTitle),
                message: Text(alertMessage),
                primaryButton: .default(Text(cancelAlertButton), action: {}),
                secondaryButton: .default(Text(retrytAlertButton), action: {
                    networkReachability.checkConnection()
                })
            )
        }
    }
}
