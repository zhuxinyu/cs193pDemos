//
//  EmojiArtDocument.swift
//  Emoji Art
//
//  Created by xyz on 2024/9/24.
//

import SwiftUI

class EmojiArtDocument: ObservableObject {
    typealias Emoji = EmojiArt.Emoji
    
    @Published private var emojiArt = EmojiArt(){
        didSet {
            autoSave()
        }
    }
    
    private var autoSaveURL: URL = URL.documentsDirectory.appendingPathComponent("AutoSaved.emojiart")
    
    private func autoSave() {
        save(to: autoSaveURL)
        print(autoSaveURL)
    }
    
    private func save(to url: URL) {
        do {
            let data = try emojiArt.json()
            try data.write(to: url)
        } catch let error {
            print("EmojiArtDocument: error while saving \(error.localizedDescription)")
        }
    }
    
    init() {
        if let data = try? Data(contentsOf: autoSaveURL),
           let autosavedEmojiArt = try? EmojiArt(json: data) {
            emojiArt = autosavedEmojiArt
        }
    }
    
    var emojis: [Emoji] {
        emojiArt.emojis
    }
    
    var background: URL? {
        emojiArt.background
    }
    
    // MARK: - Intent(s)
    
    func setBackground(_ url: URL?) {
        emojiArt.background = url
    }
    
    func addEmoji(_ emoji: String, at position: Emoji.Position, size: CGFloat) {
        emojiArt.addEmoji(emoji, at: position, size: Int(size ))
    }

}

extension EmojiArt.Emoji {
    var font: Font {
        .system(size: CGFloat(size))
    }
}

extension EmojiArt.Emoji.Position {
    func `in`(_ geometry: GeometryProxy) -> CGPoint {
        let center = geometry.frame(in: .local).center
        return CGPoint(x: center.x + CGFloat(x), y: center.y - CGFloat(y))
    }
}
