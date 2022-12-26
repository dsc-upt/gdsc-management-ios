//
// Created by Dan Percic on 03.12.2022.
//

import SwiftUI

let defaultCoverImage = "https://goodmorningimagesforlover.com/wp-content/uploads/2018/11/create-facebook-cover-photo-for-whatsapp.jpg"

struct UserDetail: View {
    var user: User
    @State var selectedRoles: Set<IdentifiableString> = Set()

    var body: some View {
        ScrollView {
            CoverImage(url: defaultCoverImage)

            AsyncCircleImage(user.avatar ?? defaultAvatar).offset(y: -130).padding(.bottom, -130)

            VStack(alignment: .leading) {
                Text(user.firstName + " " + user.lastName)
                        .font(.title)
                        .foregroundColor(.black)

                HStack {
                    Text(user.id)

                    Spacer()

                    Text(user.updated)
                }
                        .font(.subheadline).foregroundColor(.secondary)

                Divider()

                Text("About \(user.firstName)").font(.title2)

                Text(user.created)
            }
                    .padding()

            NavigationLink {
                ItemsList()
            } label: {
                Text("Items")
            }
            UserRoles(roles: user.roles, selected: selectedRoles)
        }
                .navigationViewStyle(.stack)
                .navigationTitle(user.firstName + " " + user.lastName).navigationBarTitleDisplayMode(.inline)
    }
}

// struct UserDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        UserDetail(user: ModelData().landmarks[0])
//    }
// }
