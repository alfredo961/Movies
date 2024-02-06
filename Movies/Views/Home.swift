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
    
    @State private var searchTxt = ""
    @State private var searchBtn = false
    
    var body: some View {
        
        NavigationView {
            VStack{
                TextField("Buscar", text: $searchTxt)
                    .textFieldStyle(.roundedBorder)
                    .padding(.top, 15)
                    .padding(.bottom, 20)
                    .onAppear{
                        searchTxt = ""
                    }
                Button{
                    searchBtn.toggle()
                } label: {
                    Text("Buscar")
                        .font(.title2)
                        .bold()
                }
                .buttonStyle(.bordered)
                .tint(.blue)
                
                NavigationLink(destination: MoviesView(movie: searchTxt), isActive: $searchBtn){
                                EmptyView()
                }.hidden()
                
                Spacer()
            }.padding(.all)
                .navigationTitle("Buscar Película")
        }
    }
}
