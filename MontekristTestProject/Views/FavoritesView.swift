//
//  FavoritesView.swift
//  MontekristTestProject
//
//  Created by Alibek Ismagulov on 23.08.2023.
//

import SwiftUI
import RealmSwift

struct FavoritesView: View {
    
    @State private var items = [ItemModel]()
    @State var favoritesCount = 0
    
    let realmStruct = RealmService()
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.init(Color(#colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)))]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.init(Color(#colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)))]
        UIBarButtonItem.appearance().tintColor = .systemTeal
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    ForEach(items) { item in
                        SearchItem(item: item, favoritesCount: $favoritesCount)
                    }
                    .foregroundColor(.teal)
                }
                .listStyle(GroupedListStyle())
            }
            .navigationTitle("Star Wars")
        }
        .environment(\.colorScheme, .dark)
        .onAppear(perform: {
            items = realmStruct.readFavorites()
            favoritesCount = items.count
        })
        .onChange(of: favoritesCount) { newValue in
            print(favoritesCount)
            items = realmStruct.readFavorites()
        }
    }
}


struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
