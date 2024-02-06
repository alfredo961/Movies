//
//  Movies.swift
//  Movies
//
//  Created by Alfredo González on 5/2/24.
//

import Foundation

// Lista de peliculas
struct Peliculas: Codable {
    let page: Int
    let results: [Pelicula]
}

// Objeto Pelicula
struct Pelicula: Codable, Identifiable {
    let backdropPath: String?
    let genreIDS: [Int]
    let id: Int
    let originalTitle, overview: String
    let popularity: Double
    let posterPath, releaseDate, title: String?
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
