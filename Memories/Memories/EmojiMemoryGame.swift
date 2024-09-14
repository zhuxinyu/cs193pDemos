//
//  EmojiMemoryGame.swift
//  Memories
//
//  Created by xyz on 2024/9/12.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    private static let emojis = ["👻","🎃","🤠", "😈","👹","🤡","☠️","🍧","🍳","🥞","🍲"]
    
    private static func createMemoryGame() -> MemoryGame<String> {
        return MemoryGame(numberOfPairsOfCards: 2) { pariIndex in
            if emojis.indices.contains(pariIndex) {
                return emojis[pariIndex]
            } else {
                return "⁉️"
            }
        }
    }
    
    @Published private var model = createMemoryGame()
    
    var cards: Array<Card> {
        model.cards
    }
    
    var color: Color {
        .orange
    }
    
    // MARK: - Intents
    func shuffle(){
        model.shuffle()
    }
    
    func choose(_ card: Card) {
        model.choose(card)
    }
}
