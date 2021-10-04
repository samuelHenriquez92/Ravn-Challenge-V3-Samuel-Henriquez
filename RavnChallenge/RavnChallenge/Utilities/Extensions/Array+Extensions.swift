//
//  Array+Extensions.swift
//  RavnChallenge
//
//  Created by Samuel Henriquez on 2/10/21.
//

import Foundation

extension Sequence where Iterator.Element: Hashable {
    
    // MARK: - Public Methods
    func removeDuplicates() -> [Iterator.Element] {
        var seen: Set<Iterator.Element> = .init()
        return filter { seen.insert($0).inserted }
    }
}
