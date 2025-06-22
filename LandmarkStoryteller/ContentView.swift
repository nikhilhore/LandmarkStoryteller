//
//  ContentView.swift
//  LandmarkStoryteller
//
//  Created by Nikhil Hore on 18/06/25.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext

    @Query private var landmarks: [Landmark]

    @State private var isAddingLandmark: Bool = false

    var body: some View {
        VStack {
            NavigationStack {
                List {
                    ForEach(landmarks) { landmark in
                        NavigationLink(
                            destination: LandmarkDetailView(landmark: landmark)
                        ) {
                            VStack(alignment: .leading) {
                                Text(landmark.name)
                                    .font(.headline)
                                Text(landmark.description_)
                                    .font(.subheadline)
                                    .foregroundStyle(.gray)
                                    .lineLimit(1)
                            }
                        }
                    }
                    .onDelete(perform: deleteLandmarks)
                }
                .navigationTitle("Landmarks")
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        EditButton()
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            isAddingLandmark = true
                        } label: {
                            Label("Add Landmark", systemImage: "plus")
                        }
                    }
                }
                .sheet(isPresented: $isAddingLandmark) {
                    AddLandmarkView()
                        .modelContext(modelContext)
                }
            }
        }
    }

    private func deleteLandmarks(offsets: IndexSet) {
        for index in offsets {
            let landmark = landmarks[index]
            modelContext.delete(landmark)
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Landmark.self, inMemory: true)
}
