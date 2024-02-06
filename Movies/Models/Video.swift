//
//  Video.swift
//  Movies
//
//  Created by Alfredo González on 6/2/24.
//

import Foundation

struct Video: Codable {
    let id: Int
    let results: [VideoResult]
}

struct VideoResult: Codable {
    let name: String
    let key: String
    let type: String
    var trailerURL: String? {
        return "https://www.youtube.com/watch?v=\(key)"
    }
}

