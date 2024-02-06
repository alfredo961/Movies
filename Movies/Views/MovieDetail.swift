//
//  MovieDetail.swift
//  Movies
//
//  Created by Alfredo González on 6/2/24.
//

import SwiftUI
import AVKit


struct MovieDetail: View {
    var movie: Pelicula
    var image: Image
    var video: Video
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    ZStack(alignment: .bottomTrailing) {
                        if let image = image {
                                                    image
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fill)
                                                        .frame(width: geometry.size.width, height: geometry.size.height / 3)
                                                        .clipped()
                                                } else {
                                                    Image("nodisponible")
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fill)
                                                        .frame(width: geometry.size.width, height: geometry.size.height / 3)
                                                        .clipped()
                                                }
                            
                            Circle()
                                .fill(Color.green)
                                .frame(width: geometry.size.width / 4, height: geometry.size.width / 4)
                                .overlay(
                                    Text(String(format: "%.1f", movie.voteAverage))
                                        .font(.title)
                                        .fontWeight(.bold)
                                )
                                .padding()
                        }
                        
                        Text(movie.title ?? "")
                        .font(.title3)
                        Text(movie.overview)
                            .font(.body)
                    
                    if let videoResult = video.results.first, let url = URL(string: videoResult.trailerURL ?? "") {
                        VideoPlayer(player: AVPlayer(url: url))
                            .frame(height: 200)
                    }


                    }
                    .padding()
                }
            }
        }
    }

