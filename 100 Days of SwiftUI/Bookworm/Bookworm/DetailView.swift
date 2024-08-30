//
//  DetailView.swift
//  Bookworm
//
//  Created by David Williams on 8/29/24.
//
import SwiftData
import SwiftUI

struct DetailView: View {
    var book: Book
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @State private var showingDeleteAlert = false
    var body: some View {
        ScrollView{
            ZStack(alignment: .bottomTrailing){
                Image(book.genre)
                    .resizable()
                    .scaledToFit()
                Text(book.genre)
                    .fontWeight(.black)
                    .padding(8)
                    .foregroundStyle(.white)
                    .background(.black.opacity(0.75))
                    .clipShape(.capsule)
                    .offset(x: -5, y: -5)
            }
            Text(book.author)
                .font(.title)
                .foregroundStyle(.secondary)
            Text(book.formattedDate)
                .font(.subheadline.bold())
            Text(book.review)
                .padding()
            RatingView(rating: .constant(book.rating))
                .font(.largeTitle)
        }
        .navigationTitle(book.title)
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .toolbar{
            ToolbarItem(placement: .topBarTrailing){
                Button("Delete this book", systemImage: "trash"){
                    showingDeleteAlert = true
                }
            }
        }
        .alert("Delete Book", isPresented: $showingDeleteAlert){
            Button("Delete", role: .destructive){
                deleteBook()
            }
            Button("Cancel", role: .cancel){}
        } message: {
            Text("Are you sure?")
        }
    }
    
    func deleteBook(){
        modelContext.delete(book)
        dismiss()
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let containter = try ModelContainer(for: Book.self, configurations: config)
        let example = Book(title: "tat", author: "ata", genre: "Fantasy", review: "EA SPORTS THIS IS PRETTY DARN GOOD BOOK IN THE GAME!", rating: 4)
        
        return DetailView(book: example)
            .modelContainer(containter)
    } catch {
        return Text("Failed to create preview \(error.localizedDescription)")
    }
    
}
