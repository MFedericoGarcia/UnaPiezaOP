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
                                .font(.custom("ONEPIECE", fixedSize: 50))
                                .font(.largeTitle.bold())
                        }
                        Text(devilFruit.name)
                            .font(.title2.bold())
                    }
                    
                    Text(devilFruit.type)
                    .font(.title3)
                    .foregroundStyle(.secondary)
                    .padding(.bottom, 40)
                
                
                if let urlString = devilFruit.filename, let url = URL(string: urlString) {
                    CachedAsyncImage(url: url)
                        .frame(width: 200, height: 200)
                } else {
                    Image(systemName: "atom")
                        .font(.largeTitle)
                        .tint(.indigo)
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
                .frame(width: 250, height: 200)
                .shadow(radius: 6)
                
                

                Spacer()
            }
            .navigationTitle("Devil Fruit")
            .padding()
        }
    }
}

#Preview {
    DevilFruitView(devilFruit: DevilFruit(id: 2, name: "Fede Fede no mi", type: "Paramecia", description: "Soy el mejor del mundo"))
}
