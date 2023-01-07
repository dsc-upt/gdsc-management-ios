//
// Created by Dan Percic on 03.12.2022.
//

import SwiftUI

let defaultCoverImage = "https://goodmorningimagesforlover.com/wp-content/uploads/2018/11/create-facebook-cover-photo-for-whatsapp.jpg"
let allRoles = ["admin", "user"]

struct UserDetail: View {
    private var user: User
    @State private var selectedRoles: Set<IdentifiableString>

    private var name: String {
        user.firstName + " " + user.lastName
    }

    init(user: User) {
        self.user = user
        selectedRoles = Set(user.roles.map {
            IdentifiableString(string: $0)
        })
    }

    private var details: some View {
        VStack(alignment: .leading) {
            Text(name).font(.title).foregroundColor(.black)

            HStack {
                Text(user.id)

                Spacer()

                Text(user.updated)
            }
                    .font(.subheadline).foregroundColor(.secondary)

            Divider()

            Text("About \(user.firstName)").font(.title2)

            Text(user.created)

            Form {
                NavigationLink {
                    ItemsList()
                } label: {
                    Text("Items")
                }
                UserRoles(roles: allRoles, selected: selectedRoles)
            }
        }
    }

    var body: some View {
        let scrollView = ScrollView {
            CoverImage(url: defaultCoverImage)

            AsyncCircleImage(user.avatar ?? defaultAvatar, width: 150).offset(y: -130).padding(.bottom, -130)

            NavigationView {
                details.padding()
            }
        }

        return scrollView.navigationTitle(name).navigationBarTitleDisplayMode(.inline)
    }
}

class UserDetail_Previews: PreviewProvider {
    static let user = User(id: "1", created: "2021-12-03T12:00:00.000Z", updated: "2021-12-03T12:00:00.000Z", firstName: "Dan", lastName: "Percic", avatar: "https://avatars.githubusercontent.com/u/10229883?v=4", roles: ["admin", "user"])

    static var previews: some View {
        NavigationView {
            UserDetail(user: user)
        }
    }

//    #if DEBUG
//    @objc class func injected() {
//        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
//        windowScene?.windows.first?.rootViewController =
//                UIHostingController(rootView: UserDetail(user: user))
//    }
//    #endif
}
