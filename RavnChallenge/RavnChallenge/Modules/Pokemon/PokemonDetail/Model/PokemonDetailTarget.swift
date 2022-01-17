//
//  PokemonDetailTarget.swift
//  RavnChallenge
//
//  Created by Samuel Henriquez on 1/17/22.
//

import Moya

enum PokemonDetailTarget {
    case detail(name: String)
}

extension PokemonDetailTarget: TargetType {
    var path: String {
        switch self {
        case .detail(let name):
            return "/pokemon-species/\(name)"
        }
    }

    var method: Moya.Method {
        switch self {
        case .detail:
            return .get
        }
    }

    var task: Task {
        switch self {
        case .detail:
            return .requestPlain
        }
    }
}
