//
//  SearchItemView.swift
//  MontekristTestProject
//
//  Created by Alibek Ismagulov on 14.08.2023.
//

import SwiftUI

struct SearchItem: View {
    
    let item: ItemModel
    let realmService = RealmService()
    @ObservedObject var reloadViewHelper = ReloadViewHelper()
    @Binding public var favoritesCount: Int
    
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.type).font(.system(size: 10))
                Text(item.parameter1).font(.headline)
                VStack(alignment: .leading) {
                    Text(item.parameter2)
                    if let param3 = item.parameter3 {
                        Text(param3)
                    }
                    if let param4 = item.parameter4 {
                        Text(param4)
                    }
                }
                .font(.subheadline)
            }
            Spacer()
            if realmService.findItem(item) {
                Button {
                    realmService.delete(item)
                    reloadViewHelper.reloadView()
                    favoritesCount -= 1
                } label: {
                    Image(systemName: "star.fill")
                }.buttonStyle(.borderless)
            } else {
                Button {
                    realmService.add(item)
                    reloadViewHelper.reloadView()
                    favoritesCount += 1
                } label: {
                    Image(systemName: "star")
                }.buttonStyle(.borderless)
            }
        }
    }
}
