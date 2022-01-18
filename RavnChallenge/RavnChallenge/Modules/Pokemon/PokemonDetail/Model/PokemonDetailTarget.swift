//
//  PokemonDetailTarget.swift
//  RavnChallenge
//
//  Created by Samuel Henriquez on 1/17/22.
//

import Moya

enum PokemonDetailTarget {
    case detail(id: String)
    case sprites(id: String)
}

extension PokemonDetailTarget: TargetType {
    var path: String {
        switch self {
        case .detail(let id):
            return "/pokemon-species/\(id)"
        case .sprites(let id):
            return "/pokemon/\(id)"
        }
    }

    var method: Moya.Method {
        switch self {
        case .detail, .sprites:
            return .get
        }
    }

    var task: Task {
        switch self {
        case .detail, .sprites:
            return .requestPlain
        }
    }
}
