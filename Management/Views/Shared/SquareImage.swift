//
// Created by Dan Percic on 26.12.2022.
// Copyright (c) 2022 Gdsc. All rights reserved.
//

import Foundation
import SwiftUI

struct SquareImage: View {
    private var image: Image
    private var width: CGFloat?
    private var height: CGFloat?

    init(_ image: Image, width: CGFloat? = nil, height: CGFloat? = nil) {
        self.image = image
        self.width = width
        self.height = height
    }

    var body: some View {
        let resized = image.resizable().frame(width: width, height: height)
        let clipped = resized.clipShape(Rectangle())
        return clipped.shadow(radius: 7).aspectRatio(contentMode: .fit)
    }
}

struct AsyncSquareImage: View {
    private var url: String
    private var width: CGFloat?
    private var height: CGFloat?

    init(_ url: String, width: CGFloat? = nil, height: CGFloat? = nil) {
        self.url = url
        self.width = width
        self.height = height
    }

    var body: some View {
        AsyncImage(url: URL(string: url)) { image in
            SquareImage(image, width: width, height: height)
        } placeholder: {
            ProgressView()
        }
    }
}

struct SquareImage_Previews: PreviewProvider {
    static var previews: some View {
        AsyncSquareImage(defaultAvatar)
    }
}
