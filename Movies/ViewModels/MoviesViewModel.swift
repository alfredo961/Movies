//
//  MoviesViewModel.swift
//  Movies
//
//  Created by Alfredo González on 6/2/24.
//

import Foundation
import Alamofire
import SwiftUI


@MainActor
class MoviesViewModel: ObservableObject{
    
    @Published var nowPlayingMovies: [Pelicula] = []
    @Published var popularMovies: [Pelicula] = []
    @Published var topRatedMovies: [Pelicula] = []
    @Published var upcomingMovies: [Pelicula] = []
    @Published var errorMessage: String?

    func nowPlaying() {
        let moviesEndpoint = "/3/movie/now_playing?api_key=\(Constants.apiKey)&language=en-US&page=1"
        fetchMovies(endpoint: moviesEndpoint, movieType: .nowPlaying)
    }

    func popular() {
        let moviesEndpoint = "/3/movie/popular?api_key=\(Constants.apiKey)&language=en-US&page=1"
        fetchMovies(endpoint: moviesEndpoint, movieType: .popular)
    }

    func topRated() {
        let moviesEndpoint = "/3/movie/top_rated?api_key=\(Constants.apiKey)&language=en-US&page=1"
        fetchMovies(endpoint: moviesEndpoint, movieType: .topRated)
    }

    func upcoming() {
        let moviesEndpoint = "/3/movie/upcoming?api_key=\(Constants.apiKey)&language=en-US&page=1"
        fetchMovies(endpoint: moviesEndpoint, movieType: .upcoming)
    }

    private func fetchMovies(endpoint: String, movieType: MovieType) {
        guard let url = buildURL(endpoint: endpoint) else {return}
        print(url)
        
        AF.request(url).validate().responseDecodable(of: Peliculas.self) { [weak self] response in
            switch response.result {
            case .success(let peliculas):
                DispatchQueue.main.async {
                    switch movieType {
                    case .nowPlaying:
                        self?.nowPlayingMovies = peliculas.results
                    case .popular:
                        self?.popularMovies = peliculas.results
                    case .topRated:
                        self?.topRatedMovies = peliculas.results
                    case .upcoming:
                        self?.upcomingMovies = peliculas.results
                    }
                }
            case .failure(let error):
                self?.errorMessage = error.localizedDescription
            }
        }
    }

    private func buildURL(endpoint: String) -> URL? {
            let urlString = Constants.baseUrl + (endpoint.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) ?? "")
            return URL(string: urlString)
        }
}

enum MovieType {
    case nowPlaying
    case popular
    case topRated
    case upcoming
}
