//
//  ContentView.swift
//  Memorize
//
//  Created by Roland Fazakas on 07/08/2022.
//

import SwiftUI

struct ContentView: View {
    var emojis = ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎", "🚓", "🚑", "🚒", "🚐", "🛻", "🚚", "🚛", "🚜", "🦯", "🦽", "🦼", "🩼", "🛴", "🚲", "🛵", "🏍", "🛺", "✈️", "🚁"]
    @State var emojiNum = 8
    
    var body: some View {
        VStack {
            Text("Memorize!")
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(emojis[0..<emojiNum], id: \.self) { emoji in
                        CardView(content: emoji)
                    }
                }
            }
            Spacer()
            HStack {
                
            }
        }
        .font(.largeTitle)
        .padding(.horizontal)
    }
}

struct CardView: View {
    var content: String
    @State var isFaceUp = true
    
    var cardShape = RoundedRectangle(cornerRadius: 20)
    
    var body: some View {
        ZStack {
            if isFaceUp {
                cardShape.stroke(lineWidth: 3)
                cardShape.foregroundColor(.white)
                Text(content)
            } else {
                cardShape
            }
        }
        .foregroundColor(.red)
        .aspectRatio(2/3, contentMode: .fit)
        .onTapGesture {
            isFaceUp = !isFaceUp
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
        ContentView()
            .preferredColorScheme(.light)
    }
}
