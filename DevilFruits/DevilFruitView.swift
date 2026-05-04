//
//  DevilFruitView.swift
//  UnaPieza
//
//  Created by Fede Garcia on 22/04/2026.
//

import SwiftUI

struct DevilFruitView: View {
    var devilFruit: DevilFruit
    
    var body: some View {
        ZStack{
            LinearGradient(colors: [Color.blue, Color.white], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
               
                    VStack {
                        if devilFruit.romanName != nil {
                            Text(devilFruit.romanName ?? "")
                                .font(.scalableCustom("ONEPIECE", baseSize: 50, textStyle:
                                        .largeTitle))
                        }
                        Text(devilFruit.name)
                            .font(.title2.bold())
                    }
                    
                    Text(devilFruit.type)
                    .font(.title3)
                    .foregroundStyle(.secondary)
                    .padding(.bottom, 40)
                
                
                if let urlString = devilFruit.filename, let url = URL(string: urlString) {
                    CachedAsyncImage2(url: url)
                        .shadow(radius: 6)
                        .frame(width: 200, height: 200)
                        .padding()
                } else {
                    VStack{
                        Image(systemName: "atom")
                            .font(.system(size: 150))
                            .tint(.indigo)
                        Text("No Image")
                            .font(.largeTitle)
                    }
                    .frame(width: 200, height: 200)
                }
                
                Spacer()
           
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(.thinMaterial)
                    
                    ScrollView {
                        Text(devilFruit.description)
                            .foregroundStyle(.primary)
                    }
                    .padding()
                }
                .frame(maxWidth: .infinity, maxHeight: 200)
                .shadow(radius: 6)
                
                
            }
            .navigationTitle("Devil Fruit")
            .navigationBarTitleDisplayMode(.inline)
            .padding()
        }
    }
}

#Preview {
    DevilFruitView(devilFruit: DevilFruit(id: 2, name: "Fede Fede no mi", type: "Paramecia", description: "Soy el mejor del mundo"))
}
