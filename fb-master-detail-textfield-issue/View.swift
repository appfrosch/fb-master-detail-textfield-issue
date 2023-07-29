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
    @State private var itemTitle: String
    
    init(
        item: Binding<Item>
    ) {
        self._item = item
        self._itemTitle = State(initialValue: item.wrappedValue.title)
    }
    
    var body: some View {
        VStack {
            Text("Trying to change the text in the title textfield **in the middle of the text** unexpectedly moves the cursor to the end of the text.")
                .font(.caption)
                .padding()
            Form {
                Section("Title Textfield") {
                    TextField("", text: $itemTitle)
                        .onChange(of: itemTitle, perform: { _ in
                            item.title = itemTitle
                        })
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
            Text("""
                Rather hacky workaround:
                instantiate a local `@State` variable in the detail view and synchronize it with the `@Binding`.
                """)
                .font(.caption)
                .padding()
        }
        .navigationTitle(item.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ItemDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
