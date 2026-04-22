//
//  ContentView.swift
//  UnaPieza
//
//  Created by Fede Garcia on 22/04/2026.
//

import SwiftUI

struct ContentView: View {
    @State private var frutas: [DevilFruit] = []
    
    var body: some View {
        NavigationStack {
            if !frutas.isEmpty {
                List {
                        ForEach(frutas, id: \.id) { fruta in
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
                .navigationTitle("Devil Fruits")

            } else {
                ContentUnavailableView("Fetching for Fruits", systemImage: "atom", description: Text("Wait until we bring info to you =D").font(.custom("ONEPIECE", fixedSize: 26)).bold())
            }
        }
        .onAppear {
            Task {
                frutas = await loadData()
            }
        }
    }
}

#Preview {
    ContentView()
}
