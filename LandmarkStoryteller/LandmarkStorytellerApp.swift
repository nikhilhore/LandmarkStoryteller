//
//  LandmarkStorytellerApp.swift
//  LandmarkStoryteller
//
//  Created by Nikhil Hore on 18/06/25.
//

import SwiftData
import SwiftUI

@main
struct LandmarkStorytellerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [
            Landmark.self,
            UserStory.self,
        ])
    }
}
