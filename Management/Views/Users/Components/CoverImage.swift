//
// Created by Dan Percic on 17.12.2022.
// Copyright (c) 2022 Gdsc. All rights reserved.
//

import Foundation
import SwiftUI

struct CoverImage: View {
    var url: String

    var body: some View {
        AsyncImage(url: URL(string: url)) { image in
            image.resizable().aspectRatio(contentMode: .fit)
        } placeholder: {
            ProgressView()
        }
                .frame(height: 200).clipped()
    }
}
