//
//  MovieSection.swift
//  Movies
//
//  Created by Alfredo González on 6/2/24.
//

import SwiftUI

struct MovieSection: View {
    var movies: [Pelicula]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(movies) { movie in
                    MovieCardView(image: movie.posterPath ?? "",
                                  title: movie.title!,
                                  rating: String(movie.voteAverage)) {
                        print("Película seleccionada: ", movie.title!)
                    }
                }
            }
        }
    }
}
