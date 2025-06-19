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
    @State private var details: String
    @State private var foundingDate: Date

    init(landmark: Landmark) {
        self.landmark = landmark
        _name = State(initialValue: landmark.name)
        _latitude = State(initialValue: String(landmark.latitude))
        _longitude = State(initialValue: String(landmark.longitude))
        _details = State(initialValue: landmark.details)
        _foundingDate = State(initialValue: landmark.foundingDate ?? Date())
    }

    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                TextField("Latitude", text: $latitude)
                    .keyboardType(.decimalPad)
                TextField("Longitude", text: $longitude)
                    .keyboardType(.decimalPad)
                TextEditor(text: $details)
                    .frame(minHeight: 100)  // Give more room for description
                DatePicker(
                    "Founding Date (Optional)",
                    selection: $foundingDate,
                    displayedComponents: .date
                )
                .datePickerStyle(.compact)
                .padding(.vertical, 5)
            }
        }
        .navigationTitle("Edit Landmark")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") { dismiss() }
            }
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") { saveLandmark() }
                    .disabled(
                        name.isEmpty || latitude.isEmpty || longitude.isEmpty
                            || details.isEmpty
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

        landmark.details = details
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
