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
            NavigationView {
                List {
                    ForEach(landmarks) { landmark in
                        Text(landmark.name)
                    }
                }
                .navigationTitle("Landmarks")
                .toolbar {
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
        .padding()
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Landmark.self, inMemory: true)
}
