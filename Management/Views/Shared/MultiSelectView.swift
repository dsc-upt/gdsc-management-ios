//
// Created by Dan Percic on 17.12.2022.
// Copyright (c) 2022 Gdsc. All rights reserved.
//

import Foundation
import SwiftUI

struct IdentifiableString: Identifiable, Hashable {
    let string: String
    var id: String {
        string
    }
}

struct MultiSelectionView<Selectable: Identifiable & Hashable>: View {
    let options: [Selectable]
    let optionToString: (Selectable) -> String

    @Binding var selected: Set<Selectable>

    var body: some View {
        List {
            ForEach(options) { selectable in
                Button(action: { toggleSelection(selectable: selectable) }) {
                    HStack {
                        Text(optionToString(selectable)).foregroundColor(.black)

                        Spacer()

                        if selected.contains { $0.id == selectable.id } {
                            Image(systemName: "checkmark").foregroundColor(.accentColor)
                        }
                    }
                }
                        .tag(selectable.id)
            }
        }
                .listStyle(GroupedListStyle())
    }

    private func toggleSelection(selectable: Selectable) {
        if let existingIndex = selected.firstIndex(where: { $0.id == selectable.id }) {
            selected.remove(at: existingIndex)
        } else {
            selected.insert(selectable)
        }
    }
}

struct MultiSelectionView_Previews: PreviewProvider {
    struct IdentifiableString: Identifiable, Hashable {
        let string: String
        var id: String {
            string
        }
    }

    @State static var selected: Set<IdentifiableString> = Set(["A", "C"].map {
        IdentifiableString(string: $0)
    })

    static var previews: some View {
        NavigationView {
            MultiSelectionView(
                    options: ["A", "B", "C", "D"].map {
                        IdentifiableString(string: $0)
                    },
                    optionToString: { $0.string },
                    selected: $selected
            )
        }
    }
}
