//
//  MemoriesApp.swift
//  Memories
//
//  Created by xyz on 2024/9/10.
//

import SwiftUI

@main
struct MemoriesApp: App {
    @StateObject var game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
