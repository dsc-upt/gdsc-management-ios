//
// Created by Dan Percic on 03.12.2022.
//

import Foundation
import SwiftUI

struct CircleImage: View {
    private var image: Image
    private var width: CGFloat?
    private var height: CGFloat?

    init(_ image: Image, width: CGFloat? = nil, height: CGFloat? = nil) {
        self.image = image
        self.width = width
        self.height = height ?? width
    }

    var body: some View {
        let resized = image.resizable().frame(width: width, height: height)
        let clipped = resized.clipShape(Circle())
                .overlay {
                    Circle().stroke(.white, lineWidth: 4)
                }
        return clipped.shadow(radius: 7)
    }
}

struct AsyncCircleImage: View {
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
            CircleImage(image, width: width, height: height)
        } placeholder: {
            ProgressView()
        }
    }
}

struct AsyncImageWithPlaceholder<Content: View>: View {
    private var url: String
    @ViewBuilder private let content: (Image) -> Content

    init(_ url: String, @ViewBuilder _ content: @escaping (Image) -> Content) {
        self.url = url
        self.content = content
    }

    var body: some View {
        AsyncImage(url: URL(string: url)) { image in
            content(image)
        } placeholder: {
            ProgressView()
        }
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        AsyncCircleImage(defaultAvatar)
    }
}
