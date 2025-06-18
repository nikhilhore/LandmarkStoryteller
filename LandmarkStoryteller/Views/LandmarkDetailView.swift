//
//  LandmarkDetailView.swift
//  LandmarkStoryteller
//
//  Created by Nikhil Hore on 19/06/25.
//

import SwiftData
import SwiftUI

struct LandmarkDetailView: View {
    let landmark: Landmark  // This view receives a Landmark object

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                Text(landmark.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 5)

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
                Text(landmark.details)
                    .font(.body)
                    .padding(.bottom, 10)
                Divider()
                Text("Location:")
                    .font(.headline)
                Text(
                    "Latitude:: \(landmark.latitude, format: .number.precision(.fractionLength(4)))"
                )
                Text(
                    "Longitude: \(landmark.longitude, format: .number.precision(.fractionLength(4)))"
                )

                // Placeholder for a Map
                Rectangle()
                    .fill(Color.secondary.opacity(0.2))
                    .frame(height: 200)
                    .overlay(Text("Map Placeholder"))
                    .cornerRadius(10)
                    .padding(.vertical)
                Spacer()
            }
            .padding()
        }
        .navigationTitle(landmark.name)
        .navigationBarTitleDisplayMode(.inline)  // Keep title compact
    }
}

// Extension for DateFormatter to display only year
extension DateFormatter {
    static let yearOnly: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter
    }()
}

#Preview {
    let mockLandmark = Landmark(
        name: "Gateway of India",
        latitude: 18.9219,
        longitude: 72.8347,
        details:
            "An iconic arch monument built during the British Raj in Mumbai, India. It was erected to commemorate the landing of King-Emperor George V and Queen-Empress Mary at Apollo Bunder during their visit to India in 1911.",
        foundingDate: Calendar.current.date(
            from: DateComponents(year: 1924, month: 12, day: 2)
        )
    )

    return NavigationView {  // Wrap in NavigationView for preview to show title
        LandmarkDetailView(landmark: mockLandmark)
    }
}
