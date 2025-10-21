//
//  NoteDetailView.swift
//  notes_ios_1.0
//
//  Created by Алексей Родимкин on 21.10.2025.
//


import SwiftUI
import SwiftData

struct NoteDetailView: View {
    @Bindable var note: Note
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Последнее изменение: \(formattedDate(note.updatedAt))")
                .font(.caption)
                .foregroundColor(.secondary)

            TextEditor(text: $note.title)
                .font(.headline)
                .frame(height: 30)
                .padding(.horizontal)
                .onChange(of: note.title) { _, _ in
                    note.updatedAt = Date()
                }
            
            Divider()
                .background(Color.gray.opacity(0.5))
            
            TextEditor(text: $note.content)
                .padding()
                .onChange(of: note.content) { _, _ in
                    note.updatedAt = Date()
                }

            Spacer()
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}
