//
//  UserView.swift
//  Friends
//
//  Created by Andres Marquez on 2021-07-21.
//

import SwiftUI
import CoreData

struct UserView: View {
    @State var user: UserData
    @FetchRequest(entity: UserData.entity(), sortDescriptors: []) var results: FetchedResults<UserData>
    
    var body: some View {
        ScrollView {

            VStack {
                HStack {
                    Text("Profile")
                        .font(.title2)
                        .bold()
                }.padding([.bottom, .horizontal])
                
                HStack {
                    Text("Age:")
                        .bold()
                    Text("\(self.user.age)")
                    Spacer()
                } .padding(.horizontal)
                
                HStack {
                    Text("Company:")
                        .bold()
                    Text("\(self.user.company ?? "Unknown")")
                    Spacer()
                } .padding(.horizontal)
                
                HStack {
                    Text("e-mail:")
                        .bold()
                    Text("\(self.user.email ?? "Unknown")")
                    Spacer()
                } .padding(.horizontal)
                
                HStack {
                    Text("Address:")
                        .bold()
                    Text("\(self.user.address ?? "Unknown")")
                    Spacer()
                } .padding([.bottom, .horizontal])
                
            } .frame(maxWidth: .infinity)
            .border(Color.black)
            
            VStack {
                Text("Tags")
                    .font(.title2)
                    .bold()
                
                ForEach(self.user.tags, id: \.self) {
                    Text("#\($0)")
                }
            } .frame(maxWidth: .infinity)
            .border(Color.black)
            
            VStack {
                Text("About me")
                    .font(.title2)
                    .bold()
                    .padding(.top)
                
                Text(self.user.about ?? "")
                    .italic()
                    .padding([.horizontal, .bottom])
            } .frame(maxWidth: .infinity)
            .border(Color.black)
            
            VStack(alignment: .leading) {
                Text("Friends in common")
                    .font(.title2)
                    .bold()
                    
                ForEach(self.user.friendsArray, id: \.id) { friend in
                    Button(action: {
                        for _ in results {
                            if let match = results.first(where: { $0.id == friend.id }) {
                                user = match
                            } else {
                                fatalError("Friend found not to be among user list")
                            }
                        }
                    }, label: {
                        Text(friend.name ?? "Unknown friend")
                            .bold()
                    })
                }
            }
        }
        .navigationBarTitle(self.user.name ?? "No Name")
    }
}

