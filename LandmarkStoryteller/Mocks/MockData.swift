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
        description:
            "An iconic arch monument built during the British Raj in Mumbai, India. It was erected to commemorate the landing of King-Emperor George V and Queen-Empress Mary at Apollo Bunder during their visit to India in 1911.",
        foundingDate: Calendar.current.date(
            from: DateComponents(year: 1924, month: 12, day: 2)
        )
    )

    static let mockUserStory = UserStory(
        title: "Sunset at the Gateway",
        content:
            "The sky just exploded with color! Never seen anything like it. The hustle and bustle around the Gateway of India just added to the magic. A perfect end to my trip.",
        dateAdded: Date.now.addingTimeInterval(-86400)
    )

    static let mockUserStories = [
        mockUserStory,
        UserStory(
            title: "My First Mumbai Moment",
            content:
                "Standing here, looking out at the Arabian Sea, the Gateway of India truly feels like the heart of Mumbai. The energy, the boats, the history – it's all so captivating. A must-see!",
            dateAdded: Date.now.addingTimeInterval(-172800)
        ),
        UserStory(
            title: "Evening Stroll by the Sea",
            content:
                "There's nothing quite like the Gateway of India in the evening. The sea breeze is so refreshing, and watching all the different people – families, tourists, vendors – gives you a real sense of Mumbai life. Loved the boat rides too!",
            dateAdded: Date.now.addingTimeInterval(-86400)
        ),
    ]

    static let mockLandmark2 = Landmark(
        name: "Statue of Unity",
        latitude: 21.8386,
        longitude: 73.7191,
        description:
            "The Statue of Unity is the world's tallest statue, located near Kevadia in Gujarat, India. It depicts Indian statesman and independence activist Sardar Vallabhbhai Patel, who was the first Deputy Prime Minister and Minister of Home Affairs of independent India. The statue is located on an island in the Narmada River and offers panoramic views of the surrounding landscape.",
        foundingDate: Calendar.current.date(
            from: DateComponents(year: 2018, month: 10, day: 31)
        )
    )

    static let mockUserStories2 = [
        UserStory(
            title: "Truly Unbelievable Scale",
            content:
                "The Statue of Unity is even more immense in person than in pictures. You just can't grasp its height until you're standing beneath it. The views from the observation deck are breathtaking, stretching for miles!",
            dateAdded: Date.now.addingTimeInterval(-259200)
        ),
        UserStory(
            title: "More Than Just a Statue",
            content:
                "Visited the Statue of Unity today, and it's not just a giant structure; it's a powerful tribute. The surrounding gardens and the Sardar Sarovar Dam create such a serene and educational environment. Felt a deep sense of respect.",
            dateAdded: Date.now.addingTimeInterval(-432000)
        ),
    ]
}
