//
//  EditLandmarkView.swift
//  LandmarkStoryteller
//
//  Created by Nikhil Hore on 19/06/25.
//

import SwiftData
import SwiftUI

struct EditLandmarkView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @Bindable var landmark: Landmark

    @State private var name: String
    @State private var latitude: String
    @State private var longitude: String
    @State private var description: String
    @State private var foundingDate: Date

    init(landmark: Landmark) {
        self.landmark = landmark
        _name = State(initialValue: landmark.name)
        _latitude = State(initialValue: String(landmark.latitude))
        _longitude = State(initialValue: String(landmark.longitude))
        _description = State(initialValue: landmark.description_)
        _foundingDate = State(initialValue: landmark.foundingDate ?? Date())
    }

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
                LabeledContent("Founding Date (Optional)") {
                    DatePicker(
                        "",
                        selection: $foundingDate,
                        displayedComponents: .date
                    )
                    .datePickerStyle(.compact)
                    .padding(.vertical, 4)
                    .labelsHidden()
                }
                .labeledContentStyle(.leading)
            }
        }
        .navigationTitle("Edit Landmark")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") { saveLandmark() }
                    .disabled(
                        name.isEmpty || latitude.isEmpty || longitude.isEmpty
                            || description.isEmpty
                    )
            }
        }
    }

    private func saveLandmark() {
        // Update the @Bindable landmark directly
        landmark.name = name
        if let lat = Double(latitude), let long = Double(longitude) {
            landmark.latitude = lat
            landmark.longitude = long
        }

        landmark.description_ = description
        landmark.foundingDate = foundingDate

        // SwiftData automatically saves changes to @Bindable objects
        // modelContext.save() // No need to call explicitly unless you want to force a save point
        dismiss()
    }
}

#Preview {
    NavigationView {
        EditLandmarkView(landmark: MockData.mockLandmark)
    }
    .modelContainer(for: Landmark.self, inMemory: true)
}
