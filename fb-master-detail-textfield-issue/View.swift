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
            .navigationTitle("Master-Detail TextField Editing Issue")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ItemDetailView: View {
    @Binding var item: Item
    
    var body: some View {
        Text("Trying to change the text in the title textfield **in the middle of the text** unexpectedly moves the cursor to the end of the text.")
            .font(.caption)
            .padding()
        Form {
            Section("Title Textfield") {
                TextField("", text: $item.title)
            }
            Section("Subitems") {
                if item.subitems.isEmpty {
                    Text("No subitems")
                }
                ForEach($item.subitems) { $subitem in
                    NavigationLink {
                        ItemDetailView(item: $subitem)
                    } label: {
                        Text(subitem.title)
                    }
                }
            }
        }
        .navigationTitle(item.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}
