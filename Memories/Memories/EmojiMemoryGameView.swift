//
//  EmojiMemoryGameView.swift
//  Memories
//
//  Created by xyz on 2024/9/10.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    let emojis = ["🤠", "😈","👹","🤡","👻","☠️","🍧","🍳","🥞","🍲"]
    var body: some View {
        ScrollView{
            cards
        }.padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]) {
            ForEach(emojis.indices, id: \.self) { index in
                CardView(emoji: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(.orange)
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
    EmojiMemoryGameView()
}

