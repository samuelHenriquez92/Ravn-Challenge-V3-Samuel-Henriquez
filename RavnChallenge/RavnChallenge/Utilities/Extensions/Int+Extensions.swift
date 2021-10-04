//
//  Int+Extensions.swift
//  RavnChallenge
//
//  Created by Samuel Henriquez on 2/10/21.
//

import Foundation

extension Int {
    
    // MARK: - Variables Declaration
    var numberFormattedWithZeros: String {
        String(format: "%03d", self)
    }
}
