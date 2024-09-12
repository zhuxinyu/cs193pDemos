//
//  ContentView.swift
//  Memories
//
//  Created by xyz on 2024/9/10.
//

import SwiftUI

struct ContentView: View {
    let emojis = ["🤠", "😈","👹","🤡","👻","☠️","🍧","🍳","🥞","🍲"]
    @State var cardCount: Int = 4
    var body: some View {
        VStack {
            ScrollView{
                cards
            }
            Spacer()
            cardCountAdjusters
        }.padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]) {
            ForEach(0..<cardCount, id: \.self) { index in
                CardView(emoji: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(.orange)
    }
    
    var cardCountAdjusters : some View {
        HStack{
            remover
            Spacer()
            adder
        }
        .imageScale(.large)
        .font(.largeTitle)
    }
    
    var adder: some View {
        cardCountAdjuster(by: 1, symbol: "rectangle.stack.badge.plus")
    }
    
    var remover: some View {
        cardCountAdjuster(by: -1, symbol: "rectangle.stack.badge.minus")
    }
    
    func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
        Button(action: {
            cardCount += offset
        }, label: {
            Image(systemName: symbol)
        })
        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
    }
}

struct CardView: View {
    let emoji: String
    @State var isFaceUp: Bool = true
    var body: some View {
        ZStack{
             let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(emoji)
                    .font(.largeTitle)
            }.opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
            
        }.onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}

