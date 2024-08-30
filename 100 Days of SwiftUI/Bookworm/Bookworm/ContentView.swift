//
//  ContentView.swift
//  Bookworm
//
//  Created by David Williams on 8/29/24.
//
import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort:[
        SortDescriptor(\Book.title, order: .reverse),
        SortDescriptor(\Book.author)
    ]) var books: [Book]
    
    @State private var showingAddScreen: Bool = false
    var body: some View {
        NavigationStack{
            List{
                ForEach(books){ book in
                    NavigationLink(value: book){
                        EmojiRatingView(rating: book.rating)
                        VStack(alignment: .leading){
                            Text(book.title)
                                .font(.headline)
                                .foregroundStyle(book.rating == 1 ? .red : .primary)
                            Text(book.author)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
                .onDelete(perform: deleteBooks)
            }
            .navigationTitle("Bookworm")
            .navigationDestination(for: Book.self){book in
                    DetailView(book: book)
            }
            .toolbar{
                ToolbarItem(placement: .topBarTrailing){
                    Button("Add Book", systemImage: "plus"){
                        showingAddScreen.toggle()
                    }
                }
                ToolbarItem(placement: .topBarLeading){
                    EditButton()
                }
            }
            .sheet(isPresented: $showingAddScreen){
                AddBookView()
            }
        }
    }
    func deleteBooks(at offsets: IndexSet){
        for offset in offsets {
            let book = books[offset]
            modelContext.delete(book)
        }
    }
}

#Preview {
    ContentView()
}
