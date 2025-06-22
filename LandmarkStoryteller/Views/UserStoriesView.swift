//
//  UserStoriesView.swift
//  LandmarkStoryteller
//
//  Created by Nikhil Hore on 19/06/25.
//

import SwiftUI

struct UserStoriesView: View {
    @Bindable var landmark: Landmark

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            if let stories = landmark.userStories, !stories.isEmpty {
                LazyHStack(alignment: .top, spacing: 15) {
                    ForEach(
                        stories.sorted(
                            using: KeyPathComparator(
                                \UserStory.dateAdded,
                                order: .reverse
                            )
                        )  // Sort stories by date
                    ) { story in
                        VStack(alignment: .leading) {
                            Text(story.title)
                                .font(.subheadline)
                                .fontWeight(.medium)
                            Text(story.content)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                            Text(story.dateAdded, style: .date)
                                .font(.caption2)
                                .foregroundStyle(.tertiary)
                        }
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                        .frame(width: 250)
                    }
                }
            } else {
                Text("No stories yet. Be the first to share!")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
    }
}
