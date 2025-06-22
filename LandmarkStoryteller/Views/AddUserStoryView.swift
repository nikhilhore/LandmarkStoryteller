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
        NavigationStack {
            Form {
                LabeledContent("Title") {
                    TextField("Story Title", text: $title)
                }
                .labeledContentStyle(.topAligned)
                LabeledContent("Content") {
                    TextEditor(text: $content)
                        .frame(minHeight: 150)
                        .overlay(
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(Color.secondary.opacity(0.2))
                        )
                        .padding(.bottom, 4)
                }
                .labeledContentStyle(.topAligned)
            }
            .navigationTitle("New Story for \(landmark.name)")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") { saveUserStory() }
                        .disabled(title.isEmpty || content.isEmpty)
                }
            }
        }
    }

    private func saveUserStory() {
        let newStory = UserStory(
            title: title,
            content: content,
            dateAdded: Date()
        )
        // Add the new story to the landmark's relationship
        if landmark.userStories != nil {
            landmark.userStories?.append(newStory)
        } else {
            landmark.userStories = [newStory]
        }
        // The modelContext will automatically save due to the @Bindable update
        dismiss()
    }
}

#Preview {
    AddUserStoryView(for: MockData.mockLandmark)
        .modelContainer(for: [Landmark.self, UserStory.self], inMemory: true)
}
