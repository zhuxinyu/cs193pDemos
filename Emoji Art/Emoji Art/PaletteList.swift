//
//  PaletteList.swift
//  Emoji Art
//
//  Created by xyz on 2024/10/15.
//

import SwiftUI

struct EditablePaletteList: View {
    @ObservedObject var store: PaletteStore
    
    @State private var showCursorPalette = false
    var body: some View {
        List{
            ForEach(store.palettes) { palette in
                NavigationLink(value: palette.id) {
                    VStack(alignment: .leading) {
                        Text(palette.name)
                        Text(palette.emojis).lineLimit(1)
                    }
                }
            }
            .onDelete { indexSet in
                withAnimation {
                    store.palettes.remove(atOffsets: indexSet)
                }
            }
            .onMove { IndexSet, newOffset in
                store.palettes.move(fromOffsets: IndexSet, toOffset: newOffset)
            }
        }
        .navigationDestination(for: Palette.ID.self) { paletteId in
            if let index = store.palettes.firstIndex(where: { $0.id == paletteId}) {
                PaletteEditor(palette: $store.palettes[index])
            }
        }
        .navigationDestination(isPresented: $showCursorPalette, destination: {
            PaletteEditor(palette: $store.palettes[store.cursorIndex])
        })
        .navigationTitle("\(store.name) Palettes")
        .toolbar{
            Button {
                store.insert(name: "", emojis: "")
                showCursorPalette = true
            } label: {
                Image(systemName: "plus")
            }
        }
    }
}

struct PaletteView: View {
    let palette: Palette
    
    var body: some View {
        VStack {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 40))]) {
                ForEach(palette.emojis.uniqued.map(String.init), id: \.self) { emoji in
                    NavigationLink(value: emoji) {
                        Text(emoji)
                    }
                }
            }
            .navigationDestination(for: String.self) { emoji in
                Text(emoji).font(.system(size: 300))
            }
            Spacer()
        }
        .padding()
        .font(.largeTitle)
        .navigationTitle(palette.name)
    }
}

//#Preview {
//    EditablePaletteList()
//}
