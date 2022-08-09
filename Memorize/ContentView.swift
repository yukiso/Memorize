//
//  ContentView.swift
//  Memorize
//
//  Created by Roland Fazakas on 07/08/2022.
//

import SwiftUI
import OrderedCollections

struct Theme {
    var emojis: [String]
    var icon: String
}

let themes: OrderedDictionary = [
    "Vehicles": Theme(emojis: ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎", "🚓", "🚑", "🚒", "🚐", "🛻", "🚚", "🚛", "🚜", "🦯", "🦽", "🦼", "🩼", "🛴", "🚲", "🛵", "🏍", "🛺", "✈️", "🚁"], icon: "car"),
    "Flags": Theme(emojis: ["🇺🇳", "🇨🇴", "🇫🇮", "🇫🇷", "🇩🇪", "🇬🇬", "🇬🇼", "🇪🇺", "🇪🇷", "🇬🇶"], icon: "flag"),
    "Animals": Theme(emojis: ["🐶", "🐨", "🦊", "🐻", "🐼", "🐹", "🐭", "🐷"], icon: "pawprint")
]

func widthThatBestFits(cardCount: Int) -> CGFloat {
    let widthRatio: CGFloat = 2
    let viewportArea: CGFloat = 200 * 400 // very rough aproximation | works for iPhone13 mini
    let aspectRatioArea: CGFloat = widthRatio * 3

    return ((viewportArea)/(aspectRatioArea*CGFloat(cardCount))).squareRoot()*widthRatio
}

struct ContentView: View {
    @State var emojis = themes["Vehicles"]!.emojis
    @State var emojiNum = 8
    
    var body: some View {
        VStack {
            Text("Memorize!")
            ScrollView {
                LazyVGrid(columns:
                            [GridItem(.adaptive(minimum: widthThatBestFits(cardCount: emojiNum), maximum: .infinity))]) {
                    ForEach(emojis[0..<emojiNum], id: \.self) { emoji in
                        CardView(content: emoji)
                    }
                }
                .padding()
            }
            HStack(alignment: .center) {
                ForEach(themes.elements, id: \.key) { (key, newTheme) in
                    Button {
                        emojis = newTheme.emojis.shuffled()
                        emojiNum = Int.random(in: 4...emojis.count)
                    } label: {
                        VStack{
                            Image(systemName: newTheme.icon)
                            Text(key).font(.subheadline)
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
        .font(.largeTitle)
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
