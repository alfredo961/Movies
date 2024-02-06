//
//  MoviesViewModel.swift
//  Movies
//
//  Created by Alfredo González on 6/2/24.
//

import Foundation
import Alamofire
import SwiftUI
import UIKit


@MainActor
class MoviesViewModel: ObservableObject{
    
    @Published var nowPlayingMovies: [Pelicula] = []
    @Published var popularMovies: [Pelicula] = []
    @Published var topRatedMovies: [Pelicula] = []
    @Published var upcomingMovies: [Pelicula] = []
    @Published var errorMessage: String?
    var peliculaImages: [Int: UIImage] = [:]


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
        
        AF.request(url).validate().responseDecodable(of: Peliculas.self) { [weak self] response in
            switch response.result {
            case .success(let peliculas):
                DispatchQueue.main.async {
                    for pelicula in peliculas.results {
                        if let posterPath = pelicula.posterPath, let imageUrl = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)") {
                            Task {
                                do {
                                    let (data, _) = try await URLSession.shared.data(from: imageUrl)
                                    let image = UIImage(data: data)
                                        DispatchQueue.main.async {
                                            self?.peliculaImages[pelicula.id] = image
                                        }
                                    
                                } catch {
                                    print(error.localizedDescription)
                                }
                            }
                        }
                    }

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

    func fetchVideo(for movie: Pelicula) {
            let urlString = "https://api.themoviedb.org/3/movie/\(movie.id)/videos?api_key=\(Constants.apiKey)&language=es"

            AF.request(urlString).validate().responseDecodable(of: Video.self) { (response: DataResponse<Video, AFError>) in
                switch response.result {
                case .success(let videoResponse):
                    if let video = videoResponse.results.first(where: { $0.type == "Trailer" }) {
                        DispatchQueue.main.async {
                            print("URL del tráiler: \(video.trailerURL)")
                        }
                    }
                case .failure(let error):
                    print("Error al obtener el video: \(error)")
                }
            }
        }
    }


    



    private func buildURL(endpoint: String) -> URL? {
            let urlString = Constants.baseUrl + (endpoint.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) ?? "")
            return URL(string: urlString)
        }


enum MovieType {
    case nowPlaying
    case popular
    case topRated
    case upcoming
}
