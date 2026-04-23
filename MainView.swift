//
//  MainView.swift
//  UnaPieza
//
//  Created by Fede Garcia on 22/04/2026.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            Tab("Characters" , systemImage: "hat.widebrim.fill") {
                AllCharactersView()
            }
            
            Tab("Devil Fruits", systemImage: "leaf.circle") {
                ContentView()
            }
            
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    MainView()
}
