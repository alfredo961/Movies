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
                    let image = Image("placeholder")
                    NavigationLink(destination: MovieDetail(movie: movie, image: image, video: <#T##Video#>)) {
                                            MovieCardView(image: movie.posterPath ?? "",
                                            title: movie.title!,
                                            releaseDate: movie.releaseDate!)
                                        }
                }
            }
        }
    }
}
