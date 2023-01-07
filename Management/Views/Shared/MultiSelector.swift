//
// Created by Dan Percic on 17.12.2022.
// Copyright (c) 2022 Gdsc. All rights reserved.
//

import Foundation
import SwiftUI

struct MultiSelector<LabelView: View, Selectable: Identifiable & Hashable>: View {
    let label: LabelView
    let options: [Selectable]
    let optionToString: (Selectable) -> String

    var selected: Binding<Set<Selectable>>

    private var formattedSelectedListString: String {
        ListFormatter.localizedString(byJoining: selected.wrappedValue.map {
            optionToString($0)
        })
    }

    var body: some View {
        NavigationLink {
            multiSelectionView()
        } label: {
            HStack {
                label
                Spacer()
                Text(formattedSelectedListString)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.trailing)
            }
        }
    }

    private func multiSelectionView() -> some View {
        MultiSelectionView(
                options: options,
                optionToString: optionToString,
                selected: selected
        )
    }
}

struct MultiSelector_Previews: PreviewProvider {
    @State static var selected = Set(["A", "C"].map {
        IdentifiableString(string: $0)
    })

    static var previews: some View {
        NavigationView {
            Form {
                MultiSelector<Text, IdentifiableString>(
                        label: Text("Multiselect"),
                        options: ["A", "B", "C", "D"].map {
                            IdentifiableString(string: $0)
                        },
                        optionToString: { $0.string },
                        selected: $selected
                )
            }
                    .navigationTitle("Title")
        }
    }
}
