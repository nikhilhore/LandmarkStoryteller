//
//  DateFormatter.swift
//  LandmarkStoryteller
//
//  Created by Nikhil Hore on 19/06/25.
//

import Foundation

// Extension for DateFormatter to display only year
extension DateFormatter {
    static let yearOnly: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter
    }()
}
