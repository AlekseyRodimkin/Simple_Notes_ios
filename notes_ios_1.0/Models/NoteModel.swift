//
//  Item.swift
//  notes_ios_1.0
//
//  Created by Алексей Родимкин on 21.10.2025.
//

import Foundation
import SwiftData

@Model
final class Note {
    @Attribute(.unique) var id: UUID = UUID()
    var title: String = ""
    var content: String = ""
    var timestamp: Date = Date()
    var updatedAt: Date = Date()
    
    
    init(title: String, content: String) {
        self.title = title
        self.content = content
        self.timestamp = Date()
        self.updatedAt = Date()
    }
}
