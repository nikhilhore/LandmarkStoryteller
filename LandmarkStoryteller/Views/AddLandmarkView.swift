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
    @State private var details: String = ""

    func saveAction() {
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
            details: details
        )
        modelContext.insert(newLandmark)
        dismiss()
    }

    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                TextField("Latitude", text: $latitude)
                    .keyboardType(.decimalPad)
                TextField("Longitude", text: $longitude)
                    .keyboardType(.decimalPad)
                TextField("Details", text: $details)
            }
            .navigationTitle("New Landmark")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") { saveAction() }
                        .disabled(
                            name.isEmpty || latitude.isEmpty
                                || longitude.isEmpty
                        )
                }
            }
        }
    }
}
