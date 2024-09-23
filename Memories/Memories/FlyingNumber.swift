//
//  FlyingNumber.swift
//  Memories
//
//  Created by xyz on 2024/9/23.
//

import SwiftUI

struct FlyingNumber: View {
    let number: Int
    var body: some View {
        if number != 0 {
            Text(number, format: .number)
        }
    }
}

#Preview {
    FlyingNumber(number: 5)
}
