//
// Created by Dan Percic on 03.12.2022.
//

import Foundation
import SwiftUI

struct CircleImage: View {
    var image: Image

    var body: some View {
        let resized = image.resizable().frame(width: 150, height: 150)
        let clipped = resized.clipShape(Circle())
                .overlay {
                    Circle().stroke(.white, lineWidth: 4)
                }
        return clipped.shadow(radius: 7)
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage(image: Image("turtlerock"))
    }
}
