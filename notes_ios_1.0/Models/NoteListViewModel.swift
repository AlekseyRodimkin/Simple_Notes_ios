//
//  NoteListViewModel.swift
//  notes_ios_1.0
//
//  Created by Алексей Родимкин on 21.10.2025.
//

import Foundation
internal import Combine
import SwiftData
import SwiftUI

@Observable
class NoteListViewModel {
    private var modelContext: ModelContext
    
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func addNote() {
        withAnimation {
            let newNote = Note(title: "Новая заметка", content: "")
            modelContext.insert(newNote)
        }
    }
    
    func deleteNotes(_ notes: [Note], at offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(notes[index])
            }
        }
    }
}
