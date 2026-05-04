//
//  CharacterDetailsView.swift
//  UnaPieza
//
//  Created by Fede Garcia on 22/04/2026.
//

import SwiftUI

struct CharacterDetailsView: View {
    
    var character: Character
    @State private var cartaImagen = ""
    @State private var cardImage: [CardImage] = []
    
    @State private var flipCard = false
    @State private var dragAmount = CGSize.zero
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color.black, Color.blue], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            VStack{
               
                Text(character.name)
                    .font(.scalableCustom("ONEPIECE", baseSize: 50, textStyle:
                            .largeTitle))
                    .foregroundStyle(.white)
                
                HStack {
                    Text("Bounty: ")
                    Image(systemName: "bitcoinsign")
                    Text(character.bounty ?? "0")
                }
                .foregroundStyle(.white)
                
                Text("Crew: \(character.crew?.romanName  ?? "No Crew")")
                    .font(.scalableCustom("ONEPIECE", baseSize: 30, textStyle: .title1))
                    .foregroundStyle(.white)
                
                Text("Devil Fruit: \((character.fruit != nil) ? "" : "No")")
                    .foregroundStyle(.white)
                
                if let fruta = character.fruit {
                    NavigationLink{
                        DevilFruitView(devilFruit: fruta)
                    } label: {
                        Text(fruta.romanName ?? "")
                            .font(.scalableCustom("ONEPIECE", baseSize: 30, textStyle: .title1))
                            .foregroundStyle(.white)
                        
                        Image(systemName: "chevron.right.square")
                    }
                }
                
                if cartaImagen != "No",let url = URL(string: cartaImagen) {
                    VStack{
                        CachedAsyncImage3(url: url)
                            .frame(width: 300, height: 500)
                            .shadow(radius: 5)
                    }
                    .offset(dragAmount)
                    .rotationEffect(.degrees(360), anchor: .center)
                    .gesture(
                        DragGesture()
                            .onChanged({ units in
                                dragAmount = units.translation
                            })
                            .onEnded({ units in
                                withAnimation(.bouncy.delay(0.1)){
                                    dragAmount = .zero
                                }
                            })
                    )
                } else {
                     VStack {
                        Image(systemName: "photo.badge.plus")
                            .font(.largeTitle)
                    }
                    .frame(width: 300, height: 500)
                    .foregroundStyle(.indigo)
                }
            }
            .onAppear {
                Task {
                    await nombreDeBusqueda(character.name)
                }
            }
        }

        
        
    }
    
    func nombreDeBusqueda(_ buscar: String) async {
        let palabras = buscar.components(separatedBy: .whitespacesAndNewlines).filter { !$0.isEmpty }
        guard let first = palabras.first else {
            return
        }
        var final = first
        if first.lowercased() == "charlotte" || first.lowercased().contains("-") {
            if palabras.count > 1 {
                final = palabras[1]
            } else {
                final = palabras[0]
            }
        }
        let nuevaURL = Endpoints.characterImage + final
        cardImage = await loadData(url: nuevaURL)
        loadImage(cardsImage: cardImage)

    }
    
    func loadImage(cardsImage: [CardImage]) {
        if cardsImage.isEmpty {
            cartaImagen = "No"
        } else {
            let cartaElegida = cardsImage.randomElement()
            cartaImagen = cartaElegida?.cardImage ?? "No"
        }
    }
}


#Preview {
    CharacterDetailsView(character: Character(id: 2, name: "sanji"))
}
