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

    @State private var position: MapCameraPosition

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
            VStack(alignment: .leading, spacing: 15) {
                Text(landmark.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 8)

                // Optional: Display founding date if available
                if let foundingDate = landmark.foundingDate {
                    Text(
                        "Established: \(foundingDate, formatter: DateFormatter.yearOnly)"
                    )
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                }

                Divider()
                Text("Description:")
                    .font(.headline)
                Text(landmark.description_)
                    .font(.body)
                    .padding(.bottom, 8)
                Divider()
                Text("Location:")
                    .font(.headline)
                Text(
                    "Latitude:: \(landmark.latitude, format: .number.precision(.fractionLength(4)))"
                )
                Text(
                    "Longitude: \(landmark.longitude, format: .number.precision(.fractionLength(4)))"
                )
                Map(position: $position) {
                    Marker(landmark.name, coordinate: landmarkCoordinates)
                }
                .frame(height: 250)
                .cornerRadius(10)
                .padding(.vertical)
                Spacer()
            }
            .padding()
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
    }
}

#Preview {
    NavigationView {  // Wrap in NavigationView for preview to show title
        LandmarkDetailView(landmark: MockData.mockLandmark)
    }
    .modelContainer(for: Landmark.self, inMemory: true)
}
