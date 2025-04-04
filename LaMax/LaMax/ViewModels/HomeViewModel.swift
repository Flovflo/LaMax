//
//  HomeViewModel.swift
//  LaMax
//
//  Created by Florian Taffin on 04/04/2025.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var userStats = UserStats(points: 1000, level: 2, badges: ["Starter"])
    @Published var missions: [Mission] = [
        Mission(title: "Oral Practice", progress: 0.2),
        Mission(title: "Vocabulary Quiz", progress: 0.5, badge: "Express")
    ]
}
