//
//  SwiftUIView.swift
//  Movies
//
//  Created by Alfredo González on 6/2/24.
//

import SwiftUI


struct MovieCardView: View {
    var image:String
    var title:String
    var releaseDate:String
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: "\(Constants.imagePath)\(image)")){
                image in image.resizable()
                    .aspectRatio(contentMode: .fit)
                    .shadow(radius: 5)
            }placeholder: {
                Image("nodisponible")
            }
                .frame(width: 150, height: 200)
                .clipped()
            
            Text(title)
                .font(.headline)
                .frame(height: 20)

            
            Text(releaseDate)
                .font(.subheadline)
                .frame(height: 20)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 3)
        
    }
}


