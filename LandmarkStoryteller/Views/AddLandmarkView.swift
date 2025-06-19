//
//  AddLandmarkView.swift
//  LandmarkStoryteller
//
//  Created by Nikhil Hore on 18/06/25.
//

import SwiftData
import SwiftUI

struct AddLandmarkView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @State private var name: String = ""
    @State private var latitude: String = ""
    @State private var longitude: String = ""
    @State private var description: String = ""

    var body: some View {
        NavigationView {
            Form {
                LabeledContent("Name") {
                    TextField("Landmark Name", text: $name)
                }
                .labeledContentStyle(.topAligned)
                LabeledContent("Location") {
                    TextField("Latitude", text: $latitude)
                        .keyboardType(.decimalPad)
                    TextField("Longitude", text: $longitude)
                        .keyboardType(.decimalPad)
                }
                .labeledContentStyle(.topAligned)
                LabeledContent("Description") {
                    TextEditor(text: $description)
                        .frame(minHeight: 100)  // Give more room for description
                        .border(Color.secondary.opacity(0.2))
                        .padding(.bottom, 8)
                }
                .labeledContentStyle(.topAligned)
            }
            .navigationTitle("New Landmark")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") { saveLandmark() }
                        .disabled(
                            name.isEmpty || latitude.isEmpty
                                || longitude.isEmpty
                        )
                }
            }
        }
    }

    private func saveLandmark() {
        guard let lat = Double(latitude),
            let long = Double(longitude)
        else {
            print("Invalid coordinates")
            return
        }

        let newLandmark = Landmark(
            name: name,
            latitude: lat,
            longitude: long,
            description: description
        )
        modelContext.insert(newLandmark)
        dismiss()
    }
}

#Preview {
    NavigationView {
        AddLandmarkView()
    }
    .modelContainer(for: Landmark.self, inMemory: true)
}
