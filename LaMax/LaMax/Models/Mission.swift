//
//  Mission.swift
//  LaMax
//
//  Created by Florian Taffin on 04/04/2025.
//
import Foundation

struct Mission: Identifiable {
    let id = UUID()
    var title: String
    var progress: Double
    var badge: String?
}
