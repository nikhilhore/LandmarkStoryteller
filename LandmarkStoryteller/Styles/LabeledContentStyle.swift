//
//  LabeledContentStyle.swift
//  LandmarkStoryteller
//
//  Created by Nikhil Hore on 19/06/25.
//

import SwiftUI

struct LeadingLabelStyle: LabeledContentStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
                .font(.callout)
                .foregroundStyle(.secondary)
            configuration.content
        }
    }
}

struct TopAlignedLabelStyle: LabeledContentStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading) {
            configuration.label
                .font(.callout)
                .foregroundStyle(.secondary)
            configuration.content
        }
    }
}

extension LabeledContentStyle where Self == TopAlignedLabelStyle {
    static var topAligned: TopAlignedLabelStyle {
        TopAlignedLabelStyle()
    }
}

extension LabeledContentStyle where Self == LeadingLabelStyle {
    static var leading: LeadingLabelStyle {
        LeadingLabelStyle()
    }
}
