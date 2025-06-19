//
//  MockData.swift
//  LandmarkStoryteller
//
//  Created by Nikhil Hore on 19/06/25.
//

import Foundation
import SwiftData

class MockData {
    static let mockLandmark = Landmark(
        name: "Gateway of India",
        latitude: 18.9219,
        longitude: 72.8347,
        details:
            "An iconic arch monument built during the British Raj in Mumbai, India. It was erected to commemorate the landing of King-Emperor George V and Queen-Empress Mary at Apollo Bunder during their visit to India in 1911.",
        foundingDate: Calendar.current.date(
            from: DateComponents(year: 1924, month: 12, day: 2)
        )
    )

    static let mockLandmark2 = Landmark(
        name: "Statue of Unity",
        latitude: 21.8386,
        longitude: 73.7191,
        details:
            "The Statue of Unity is the world's tallest statue, located near Kevadia in Gujarat, India. It depicts Indian statesman and independence activist Sardar Vallabhbhai Patel, who was the first Deputy Prime Minister and Minister of Home Affairs of independent India. The statue is located on an island in the Narmada River and offers panoramic views of the surrounding landscape.",
        foundingDate: Calendar.current.date(
            from: DateComponents(year: 2018, month: 10, day: 31)
        )
    )
}
