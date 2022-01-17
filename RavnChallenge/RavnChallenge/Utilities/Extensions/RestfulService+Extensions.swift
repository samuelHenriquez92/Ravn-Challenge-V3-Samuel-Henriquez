//
//  RestfulService+Extensions.swift
//  RavnChallenge
//
//  Created by Samuel Henriquez on 1/17/22.
//

import Foundation
import Moya

extension TargetType {
    var baseURL: URL {
        URL(string: K.Network.restfulAPIBaseUrl)!
    }

    var sampleData: Data {
        .init()
    }

    var headers: [String: String]? {
        nil
    }
}
