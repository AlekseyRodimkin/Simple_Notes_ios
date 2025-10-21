import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Note.timestamp, order: .reverse) private var notes: [Note]

    @State private var viewModel: NoteListViewModel?

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(notes) { note in
                    NavigationLink(destination: NoteDetailView(note: note)) {
                        Text(note.title)
                            .font(.headline)
                            .lineLimit(1)
                    }
                }
                .onDelete { offsets in
                    viewModel?.deleteNotes(notes, at: offsets)
                }
            }
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
            .navigationTitle("Мои заметки")
        } detail: {
            Text("Select an item")
        }
        .onAppear {
            viewModel = NoteListViewModel(modelContext: modelContext)
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Note.self, inMemory: true)
}
