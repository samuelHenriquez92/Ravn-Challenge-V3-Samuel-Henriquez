//
//  String+Extensions.swift
//  RavnChallenge
//
//  Created by Samuel Henriquez on 2/10/21.
//

import Foundation

extension String {
    
    // MARK: - Public Methods
    func localized(withComment: String = "") -> String {
        return NSLocalizedString(
            self,
            tableName: nil,
            bundle: .main,
            value: "",
            comment: withComment
        )
    }
}
