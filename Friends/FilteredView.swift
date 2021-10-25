//
//  FilteredView.swift
//  Friends
//
//  Created by Andres Marquez on 2021-10-23.
//

import SwiftUI

struct FilteredView: View {
    var fetchRequest: FetchRequest<UserData>
    init(filter: String) {
        if filter == "" {
            fetchRequest = FetchRequest<UserData>(entity: UserData.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \UserData.name, ascending: true)])
        } else {
            fetchRequest = FetchRequest<UserData>(entity: UserData.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \UserData.name, ascending: true)], predicate: NSPredicate(format: "name CONTAINS[c] %@", filter))
        }
    }
    
    var body: some View {
        List(fetchRequest.wrappedValue) { user in
            NavigationLink(destination: UserView(user: user)) {
                VStack(alignment: .leading) {
                    Text(user.name ?? "Missing Name")
                        .bold()
                    Text("Company: \(user.company ?? "Missing Company")")
                    Text(user.address ?? "Cant find")
                }
            }
        }
    }
}
