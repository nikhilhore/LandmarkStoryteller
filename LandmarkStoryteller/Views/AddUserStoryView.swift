//
//  AddUserStoryView.swift
//  LandmarkStoryteller
//
//  Created by Nikhil Hore on 19/06/25.
//

import SwiftData
import SwiftUI

struct AddUserStoryView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    // The landmark this story is being added to
    @Bindable var landmark: Landmark  // Use @Bindable for direct association

    @State private var title: String = ""
    @State private var content: String = ""

    init(for landmark: Landmark) {
        self.landmark = landmark
    }

    var body: some View {
        NavigationView {
            VStack {
                Text("New Story for \(landmark.name)")
                    .font(.headline)
                    .padding()
                Form {
                    LabeledContent("Title") {
                        TextField("Story Title", text: $title)
                    }
                    .labeledContentStyle(.topAligned)
                    TextEditor(text: $content)
                        .frame(minHeight: 100)
                        .border(Color.secondary.opacity(0.2))
                        .padding(.vertical, 8)
                }
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let newStory = UserStory(
                            title: title,
                            content: content,
                            dateAdded: Date()
                        )
                        // Add the new story to the landmark's relationship
                        landmark.userStories?.append(newStory)
                        // The modelContext will automatically save due to the @Bindable update
                        dismiss()
                    }
                    .disabled(title.isEmpty || content.isEmpty)
                }
            }
        }
    }
}

#Preview {
    AddUserStoryView(for: MockData.mockLandmark)
        .modelContainer(for: [Landmark.self, UserStory.self], inMemory: true)
}
