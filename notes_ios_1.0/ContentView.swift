import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Note.timestamp, order: .reverse) private var notes: [Note]

    @State private var viewModel: NoteListViewModel?
    @State private var searchText = ""

    private var filteredNotes: [Note] {
        if searchText.isEmpty {
            return notes
        } else {
            return notes.filter { note in
                note.title.localizedCaseInsensitiveContains(searchText)
                || note.content.localizedCaseInsensitiveContains(searchText)
                || formattedDate(note.timestamp).localizedCaseInsensitiveContains(searchText)
                || formattedDate(note.updatedAt).localizedCaseInsensitiveContains(searchText)
            }
        }
    }

    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(filteredNotes) { note in
                        NavigationLink(destination: NoteDetailView(note: note)) {
                            Text(note.title)
                                .font(.headline)
                                .lineLimit(1)
                        }
                    }
                    .onDelete { offsets in
                        viewModel?.deleteNotes(filteredNotes, at: offsets)
                    }
                }
            }
            .navigationTitle("Заметки")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button {
                        viewModel?.addNote()
                    } label: {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Поиск")
        }
        .onAppear {
            viewModel = NoteListViewModel(modelContext: modelContext)
        }
    }

    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Note.self, inMemory: true)
}
