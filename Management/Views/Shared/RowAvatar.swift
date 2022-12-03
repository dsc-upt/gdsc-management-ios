//
// Created by Dan Percic on 03.12.2022.
//

import Foundation
import SwiftUI

struct RowAvatar: View {
    var avatar: String?

    var body: some View {
        let image = AsyncImage(url: URL(string: avatar ?? defaultAvatar)) { image in
            image.resizable().frame(width: 50, height: 50)
        } placeholder: {
            ProgressView()
        }

        let clipped = image.clipShape(Circle())
        return clipped.overlay(Circle().stroke(Color.gray, lineWidth: 1))
    }
}
