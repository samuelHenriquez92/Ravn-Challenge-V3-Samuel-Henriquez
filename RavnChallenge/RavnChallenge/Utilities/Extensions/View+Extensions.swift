//
//  View+Extensions.swift
//  RavnChallenge
//
//  Created by Samuel Henriquez on 2/10/21.
//

import SwiftUI
import Accelerate

enum TextStyleType {
    case largeTitle
    case largeTitleEmphasis
    case title1
    case title1Emphasis
    case title2
    case title2Emphasis
    case title3
    case title3Emphasis
    case headlineEmphasis
    case subheadline
    case subheadlineEmphasis
    case body
    case bodyEmphasis
    case bodyAction
    case bodyActionEmphasis
    case footnote
    case footnoteEmphasis
    case footnoteDanger
    
    var font: Font {
        switch self {
        case .largeTitle:
            return .system(size: 34, weight: .regular)
        case .largeTitleEmphasis:
            return .system(size: 34, weight: .bold)
        case .title1:
            return .system(size: 28, weight: .regular)
        case .title1Emphasis:
            return .system(size: 28, weight: .bold)
        case .title2:
            return .system(size: 22, weight: .regular)
        case .title2Emphasis:
            return .system(size: 22, weight: .bold)
        case .title3:
            return .system(size: 20, weight: .regular)
        case .title3Emphasis:
            return .system(size: 20, weight: .bold)
        case .headlineEmphasis:
            return .system(size: 17, weight: .regular)
        case .subheadline:
            return .system(size: 15, weight: .regular)
        case .subheadlineEmphasis:
            return .system(size: 15, weight: .bold)
        case .body, .bodyAction:
            return .system(size: 17, weight: .regular)
        case .bodyEmphasis, .bodyActionEmphasis:
            return .system(size: 17, weight: .semibold)
        case .footnote, .footnoteDanger:
            return .system(size: 13, weight: .regular)
        case .footnoteEmphasis:
            return .system(size: 13, weight: .semibold)
        }
    }
    
    var color: Color {
        switch self {
        case .bodyAction, .bodyActionEmphasis:
            return .blue
        case .footnoteDanger:
            return .red
        default:
            return .black
        }
    }
}

struct TextStyle: ViewModifier {
    
    // MARK: - Variables Declaration
    let style: TextStyleType
    
    // MARK: - ViewModifier Implementation
    func body(content: Content) -> some View {
        content
            .font(style.font)
    }
}

extension View {
    
    // MARK: - Public Methods
    func checkForConnectivity(showAlert: Binding<Bool>) -> some View {
        modifier(NoInternetConnectionView(showAlert: showAlert))
    }
    
    func applyTextStyle(with style: TextStyleType) -> some View {
        modifier(TextStyle(style: style))
    }
}
