//
//  UserStoryTests.swift
//  LandmarkStorytellerTests
//
//  Created by Nikhil Hore on 22/06/25.
//

import Foundation
import SwiftData
import Testing

@testable import LandmarkStoryteller

struct UserStoryTests {
    @Test func testUserStoryInitialization() {
        let story = UserStory(
            title: "My Visit",
            content: "Great time!",
            dateAdded: Date()
        )

        #expect(story.title == "My Visit")
        #expect(story.content == "Great time!")
        #expect(story.landmark == nil)
    }

    @Test func testUserStoryAssociationWithLandmark() async throws {
        let container = try Test.inMemoryContainer()
        let context = ModelContext(container)
        let landmark = Landmark(
            name: "Associated Landmark",
            latitude: 10.0,
            longitude: 5.5,
            description: "A description"
        )
        let story = UserStory(
            title: "First Story",
            content: "Great time!",
            dateAdded: Date(),
            landmark: landmark
        )

        context.insert(landmark)
        context.insert(story)
        try context.save()

        let fetchedLandmark = try context.fetch(FetchDescriptor<Landmark>())
            .first
        #expect(fetchedLandmark != nil)
        #expect(fetchedLandmark?.userStories?.count == 1)
        #expect(fetchedLandmark?.userStories?.first?.title == "First Story")

        let fetchedStory = fetchedLandmark?.userStories?.first
        #expect(fetchedStory != nil)
        #expect(fetchedStory?.landmark?.name == "Associated Landmark")
    }

    @Test func testUserStoryCascadeDeletion() async throws {
        let container = try Test.inMemoryContainer()
        let context = ModelContext(container)
        let landmark = Landmark(
            name: "Landmark to Delete",
            latitude: 10.0,
            longitude: 5.5,
            description: "A description"
        )
        let story1 = UserStory(
            title: "Story 1",
            content: "Content 1",
            dateAdded: Date(),
            landmark: landmark
        )
        let story2 = UserStory(
            title: "Story 2",
            content: "Content 2",
            dateAdded: Date(),
            landmark: landmark
        )

        context.insert(landmark)
        context.insert(story1)
        context.insert(story2)
        try context.save()

        #expect(try context.fetch(FetchDescriptor<Landmark>()).count == 1)
        #expect(try context.fetch(FetchDescriptor<UserStory>()).count == 2)
        #expect(landmark.userStories?.count == 2)

        context.delete(landmark)
        try context.save()

        #expect(try context.fetch(FetchDescriptor<Landmark>()).isEmpty)
        #expect(try context.fetch(FetchDescriptor<UserStory>()).isEmpty)
    }

    @Test func testMultipleUserStories() async throws {
        let container = try Test.inMemoryContainer()
        let context = ModelContext(container)
        let landmark = Landmark(
            name: "Multiple Stories Landmark",
            latitude: 10.0,
            longitude: 5.5,
            description: "A description"
        )

        context.insert(landmark)
        try context.save()

        let story1 = UserStory(
            title: "Story 1",
            content: "Content 1",
            dateAdded: Date(),
            landmark: landmark
        )
        let story2 = UserStory(
            title: "Story 2",
            content: "Content 2",
            dateAdded: Date(),
            landmark: landmark
        )
        let story3 = UserStory(
            title: "Story 3",
            content: "Content 3",
            dateAdded: Date(),
            landmark: landmark
        )

        landmark.userStories?.append(story1)
        landmark.userStories?.append(story2)
        landmark.userStories?.append(story3)
        context.insert(story1)
        context.insert(story2)
        context.insert(story3)
        try context.save()

        let fetchedLandmark = try context.fetch(FetchDescriptor<Landmark>())
            .first
        #expect(fetchedLandmark?.userStories?.count == 3)
        #expect(
            fetchedLandmark!.userStories!.contains(
                where: { $0.title == "Story 2" }
            )
        )
    }
}
