//
//  LandmarkDetailView.swift
//  LandmarkStoryteller
//
//  Created by Nikhil Hore on 19/06/25.
//

import MapKit
import SwiftData
import SwiftUI

struct LandmarkDetailView: View {
    let landmark: Landmark  // This view receives a Landmark object
    private let landmarkCoordinates: CLLocationCoordinate2D

    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    @State private var position: MapCameraPosition
    @State private var isAddingStory: Bool = false

    init(landmark: Landmark) {
        self.landmark = landmark
        self.landmarkCoordinates = CLLocationCoordinate2D(
            latitude: landmark.latitude,
            longitude: landmark.longitude
        )

        // Initialize the camera position based on the landmark's coordinates
        _position = State(
            initialValue: .camera(
                MapCamera(
                    centerCoordinate: landmarkCoordinates,
                    distance: 1000  // Zoom level in meters
                )
            )
        )
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {

                // Optional: Display founding date if available
                if let foundingDate = landmark.foundingDate {
                    Text(
                        "Established: \(foundingDate, formatter: DateFormatter.yearOnly)"
                    )
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                    Divider()
                }

                VStack(alignment: .leading, spacing: 8) {
                    Text("Description:")
                        .font(.headline)
                    Text(landmark.description_)
                        .font(.body)
                }
                Divider()
                VStack(alignment: .leading, spacing: 8) {
                    Text("Location:")
                        .font(.headline)
                    Text(
                        "Latitude: \(landmark.latitude, format: .number.precision(.fractionLength(4)))"
                    )
                    Text(
                        "Longitude: \(landmark.longitude, format: .number.precision(.fractionLength(4)))"
                    )
                }
                Map(position: $position) {
                    Marker(landmark.name, coordinate: landmarkCoordinates)
                }
                .frame(height: 250)
                .cornerRadius(10)
                Divider()

                // Mark: - User Stories section
                HStack {
                    Text("User Stories")
                        .font(.headline)
                    Spacer()
                    Button("Add Story") {
                        isAddingStory = true
                    }
                }
                UserStoriesView(landmark: landmark)
                Spacer()
            }
            .padding()
            .navigationTitle(landmark.name)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink {
                    EditLandmarkView(landmark: landmark)
                } label: {
                    Text("Edit")
                }
            }
        }
        .sheet(isPresented: $isAddingStory) {
            AddUserStoryView(for: landmark)
                .modelContext(modelContext)
        }
    }
}

#Preview {
    let landmark = MockData.mockLandmark
    landmark.userStories?.append(contentsOf: MockData.mockUserStories)

    return NavigationStack {
        LandmarkDetailView(landmark: landmark)
    }
    .modelContainer(for: [Landmark.self, UserStory.self], inMemory: true)
}
