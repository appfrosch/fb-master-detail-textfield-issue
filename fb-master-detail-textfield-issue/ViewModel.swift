//
//  ViewModel.swift
//  fb-master-detail-textfield-issue
//
//  Created by Andreas Seeger on 26.07.23.
//

import Foundation

final class ViewModel: ObservableObject {
    @Published var items: [Item]
    
    init(
        items: [Item] = .init()
    ) {
        self.items = items
    }
}

extension ViewModel {
    static var sample: ViewModel {
        ViewModel(
            items: [
                Item(
                    title: "First Item",
                    subitems: [
                        Item(title: "First Subitem"),
                        Item(title: "Second Subitem"),
                    ]
                ),
                Item(title: "Second Item")
            ]
        )
    }
}
