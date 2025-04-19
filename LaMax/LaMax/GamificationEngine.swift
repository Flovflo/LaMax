// GamificationEngine.swift
import Foundation
import SwiftUI

enum LearningEvent {
    case correctAnswer(time: Int)
    case streak(count: Int)
    // Add more events as needed
}

class GamificationEngine: ObservableObject {
    static let shared = GamificationEngine()
    @Published var points: Int = 0
    @Published var badges: [String] = []
    @Published var streak: Int = 0
    
    func awardPoints(event: LearningEvent) -> Int {
        switch event {
        case .correctAnswer(let time):
            let pts = time < 5 ? 10 : 5
            points += pts
            return pts
        case .streak(let count):
            if count == 10 {
                badges.append("First 10 correct in a row")
                // Déclencher animation/haptic ici
            }
            return 0
        }
    }
}
