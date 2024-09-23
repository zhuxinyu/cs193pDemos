//
//  EmojiMemoryGameView.swift
//  Memories
//
//  Created by xyz on 2024/9/10.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    typealias Card = MemoryGame<String>.Card
    @ObservedObject var viewModel: EmojiMemoryGame
    
    private let aspectRatio: CGFloat = 2/3
    private let padding: CGFloat = 4
    
    var body: some View {
        VStack{
            cards
                .foregroundColor(viewModel.color)
            HStack {
                score
                Spacer()
                shuffle
                
            }.font(.largeTitle)
        }
        .padding()
    }
    
    private var score: some View {
        Text("Score: \(viewModel.score)")
            .animation(nil)
    }
    
    private var shuffle: some View {
        Button("Shuffle"){
            withAnimation {
                viewModel.shuffle()
            }
        }
    }
    
    private var cards: some View {
        AspectVGrid(viewModel.cards, aspectRatio: aspectRatio) { card in
            CardView(card)
                .padding(padding)
                .overlay(FlyingNumber(number: scoreChange(causedBy: card )))
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 1)) {
                        viewModel.choose(card)
                    }
                }
        }
    }
    
    private func scoreChange(causedBy card: Card) -> Int {
        return 0
    }
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}

