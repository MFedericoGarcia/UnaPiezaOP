//
//  ContentView.swift
//  UnaPieza
//
//  Created by Fede Garcia on 22/04/2026.
//

import SwiftUI

struct ContentView: View {
    @State private var frutas: [DevilFruit] = []
    @State private var searchText = ""
    private let service = DevilFruitService()

    var filteredNames: [DevilFruit] {
        if searchText.isEmpty {
             frutas
        } else {
            frutas.filter {if $0.romanName != nil && $0.romanName!.localizedStandardContains(searchText) {
                return true
            } else {
                return false
            }
        }
        }
    }
    
    var body: some View {
        NavigationStack {
            
            ZStack {
                LinearGradient(colors: [Color.black, Color.red], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                
                if !frutas.isEmpty {
                    List {
                        ForEach(filteredNames, id: \.id) { fruta in
                                NavigationLink {
                                    DevilFruitView(devilFruit: fruta)
                                } label: {
                                    HStack {
                                        Text(fruta.romanName ?? fruta.name)
                                            .font(.custom("ONEPIECE", fixedSize: 26))
                                            .font(.title3.bold())
                                        
                                        Spacer()
                                        
                                        if let urlString = fruta.filename, let url = URL(string: urlString) {
                                            CachedAsyncImage(url: url)
                                                .frame(width: 100, height: 100)
                                        } else {
                                            Image(systemName: "atom")
                                                .font(.largeTitle)
                                                .frame(width: 100, height: 100)
                                                .foregroundStyle(.indigo)
                                        }
                                    }
                            }
                        }
                    }
                    .listStyle(.automatic)
                    .listRowBackground(Color.clear)
                    .scrollContentBackground(.hidden)
                    .searchable(text: $searchText, prompt: "Search By Name")
                    .navigationTitle("Devil Fruits")
                    .navigationBarTitleDisplayMode(.inline)
                    .padding(.horizontal, 5)
                    
                } else {
                    ContentUnavailableView("Fetching for Fruits", systemImage: "atom", description: Text("Wait until we bring info to you =D").font(.custom("ONEPIECE", fixedSize: 26)).bold())
                }
            }
        }
        .onAppear {
            Task {
                frutas = try await service.fetchFruits()
            }
        }
    }
}

#Preview {
    ContentView()
}
