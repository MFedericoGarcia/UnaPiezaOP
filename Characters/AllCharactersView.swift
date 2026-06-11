//
//  AllCharactersView.swift
//  UnaPieza
//
//  Created by Fede Garcia on 22/04/2026.
//

import SwiftUI

struct AllCharactersView: View {
    
    @State private var characters: [Character] = []
    
    @State private var searchText = ""

    private let service = CharacterService()
    
    var filteredNames: [Character] {
        if searchText.isEmpty {
             characters
        } else {
            characters.filter {$0.name.localizedStandardContains(searchText)}
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(colors: [Color.black, Color.blue], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                
                if !characters.isEmpty {
                    
                    List {
                            ForEach(filteredNames, id: \.id) { char in
                                NavigationLink {
                                    CharacterDetailsView(character: char)
                                } label: {
                                    HStack {
                                        Text(char.name)
                                            .font(.custom("ONEPIECE", fixedSize: 26))
                                            .font(.title3.bold())
                                        
                                        Spacer()
                                        Image(systemName: "bitcoinsign")
                                        Text(char.bounty ?? "")
                                        
                                    }
                                }
                            }
                    }
                    .listStyle(.automatic)
                    .listRowBackground(Color.clear)
                    .scrollContentBackground(.hidden)
                    .navigationTitle("Nakamas")
                    .searchable(text: $searchText, prompt: "Search by Name")

                } else {
                    ContentUnavailableView("Fetching for Characters", systemImage: "person.3", description: Text("Wait until we bring info to you =D").font(.custom("ONEPIECE", fixedSize: 26)).bold())
                }
            }
        }
        .onAppear {
            Task {
                characters = try await service.fetchCharacters()
            }
        }
    }
}

#Preview {
    AllCharactersView()
}
