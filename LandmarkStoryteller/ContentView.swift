//
//  ContentView.swift
//  LandmarkStoryteller
//
//  Created by Nikhil Hore on 18/06/25.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Welcome to Landmark Storyteller!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Landmark.self, inMemory: true)
}
