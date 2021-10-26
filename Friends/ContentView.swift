//
//  ContentView.swift
//  Friends
//
//  Created by Andres Marquez on 2021-07-21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State private var filter = ""
    @StateObject var jsonModel = JSONViewModel()
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(entity: UserData.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \UserData.name, ascending: true)]) var results: FetchedResults<UserData>
    
    var body: some View {
        NavigationView {
            FilteredView(filter: filter)
            .onAppear(perform: {
                jsonModel.loadData(context: moc)
            })
            .navigationBarTitle("Friends")
            .navigationBarItems(leading: HStack {
                Button {
                    //pending
                } label: {
                    Image(systemName: "magnifyingglass")
                }
                
                TextField("Look for...", text: $filter)
            })
            .navigationBarItems(trailing: Button {
                jsonModel.reload(context: moc)
            } label: {
                Image(systemName: "arrow.triangle.2.circlepath")
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
