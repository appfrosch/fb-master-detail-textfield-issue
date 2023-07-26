//
//  ContentView.swift
//  fb-master-detail-textfield-issue
//
//  Created by Andreas Seeger on 26.07.23.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ViewModel.sample
    
    var body: some View {
        ItemListView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ItemListView: View {
        @StateObject private var viewModel = ViewModel.sample
    
    var body: some View {
        let _ = Self._printChanges()
        NavigationStack {
            List {
                ForEach($viewModel.items) { $item in
                    NavigationLink {
                        ItemDetailView(item: $item)
                    } label: {
                        Text(item.title)
                    }
                }
            }
        }
    }
}

struct ItemDetailView: View {
    @Binding var item: Item
    
    var body: some View {
        Form {
            TextField("", text: $item.title)
            Section {
                ForEach($item.subitems) { $subitem in
                    NavigationLink {
                        ItemDetailView(item: $subitem)
                    } label: {
                        Text(subitem.title)
                    }
                }
            }
        }
    }
}
