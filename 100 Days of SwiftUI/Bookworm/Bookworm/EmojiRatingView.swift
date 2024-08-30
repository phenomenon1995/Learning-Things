//
//  EmojiRatingView.swift
//  Bookworm
//
//  Created by David Williams on 8/29/24.
//

import SwiftUI

struct EmojiRatingView: View {
    var rating: Int
    var body: some View {
        switch rating{
        case 1:
            Text("😤")
        case 2:
            Text("😔")
        case 3:
            Text("😐")
        case 4:
            Text("😊")
        default:
            Text("😍")
        
        }
    }
}

#Preview {
    EmojiRatingView(rating: 3)
}
