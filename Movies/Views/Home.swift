//
//  Home.swift
//  Movies
//
//  Created by Alfredo González on 5/2/24.
//

import SwiftUI

@main
struct Movies: App {
    var body: some Scene {
        WindowGroup {
            Home()
        }
    }
}

struct Home: View {
    
    @ObservedObject var movies = MoviesViewModel()
    
    var body: some View {
        NavigationView {
            VStack{
                if movies.nowPlayingMovies.isEmpty && movies.popularMovies.isEmpty && movies.topRatedMovies.isEmpty && movies.upcomingMovies.isEmpty {
                    ProgressView()
                        .onAppear {
                            movies.nowPlaying()
                            movies.popular()
                            movies.topRated()
                            movies.upcoming()
                        }
                } else {
                    ScrollView {
                        VStack {
                            Text("Now Playing")
                                .font(.title)
                            MovieSection(movies: movies.nowPlayingMovies)
                            
                            Text("Popular")
                                .font(.title)
                            MovieSection(movies: movies.popularMovies)
                            
                            Text("Top Rated")
                                .font(.title)
                            MovieSection(movies: movies.topRatedMovies)
                            
                            Text("Upcoming")
                                .font(.title)
                            MovieSection(movies: movies.upcomingMovies)
                        }
                    }
                }
            }
            .navigationTitle("Películas")
        }
    }
}
