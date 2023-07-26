//
//  Item.swift
//  fb-master-detail-textfield-issue
//
//  Created by Andreas Seeger on 26.07.23.
//

import Foundation

struct Item: Identifiable {
    let id: UUID
    var title: String
    var subitems: [Item]
    
    init(
        id: UUID = .init(),
        title: String,
        subitems: [Item] = .init()
    ) {
        self.id = id
        self.title = title
        self.subitems = subitems
    }
}
