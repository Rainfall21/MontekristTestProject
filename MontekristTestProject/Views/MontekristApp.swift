//
//  ContentView.swift
//  MontekristTestProject
//
//  Created by Alibek Ismagulov on 14.08.2023.
//

import SwiftUI
import RealmSwift

struct ContentView: View {
    
    @State private var searchText = ""
    @State private var items = [ItemModel]()
    @State private var errorTitle: String?
    @Environment(\.dismissSearch) var dismissSearch
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
                SearchView { isSearching in
                    Color.clear
                        .onChange(of: isSearching) { newValue in
                            guard !newValue else {
                                searchText = ""
                                items = []
                                dismissSearch()
                                return
                            }
                            errorTitle = nil
                        }
                }
                List {
                    if let error = errorTitle {
                        Text(error)
                    }
                    if !searchText.isEmpty {
                        ForEach(items) { item in
                            SearchItem(item: item, favoritesCount: $favoritesCount)
                        }
                        .foregroundColor(.teal)
                    }
                }
                .listStyle(GroupedListStyle())
            }
            .navigationTitle("Star Wars")
        }
        .environment(\.colorScheme, .dark)
        .onAppear(perform: {
            errorTitle = nil
            searchText = ""
            items = []
        })
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Type some text to search")
        .foregroundColor(.teal)
        .autocorrectionDisabled(true)
        .onSubmit(of: .search, {
            errorTitle = nil
            if searchText.count < 2 {
                errorTitle = "Type in at least 2 symbols"
            } else {
                FetchItemsViewModel.shared.fetchAll(searchText: searchText, completion: { result in
                    items = result
                    if items.count == 0 {
                        errorTitle = "Did not found anything"
                    }
                })
            }
        })
    }
    
    struct SearchView<Content: View>: View {
        @Environment(\.isSearching) var isSearching
        let content: (Bool) -> Content
        
        var body: some View {
            content(isSearching)
        }
        
        init(@ViewBuilder content: @escaping (Bool) -> Content) {
            self.content = content
        }
    }
}


