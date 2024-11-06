//
//  PaletteManager.swift
//  Emoji Art
//
//  Created by xyz on 2024/10/15.
//

import SwiftUI

struct PaletteManager: View {
    let stores:[PaletteStore]
    
    @State private var selectedStore: PaletteStore?
    
    var body: some View {
        NavigationSplitView {
            List(stores, selection: $selectedStore) { store in
                Text(store.name)
                    .tag(store)
            }
        } content: {
            if let selectedStore {
                EditablePaletteList(store: selectedStore)
            }
            Text("Choose a store")
        } detail: {
            Text("Choose a palette")

        }
    }
}

//#Preview {
//    PaletteManager()
//}