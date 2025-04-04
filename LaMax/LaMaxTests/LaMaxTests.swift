//
//  LaMaxTests.swift
//  LaMaxTests
//
//  Created by Florian Taffin on 04/04/2025.
//

import XCTest
@testable import LaMax

final class LaMaxTests: XCTestCase {

    func testExample() throws {
        // Exemple de test unitaire.
        let userStats = UserStats(points: 1000, level: 2, badges: ["Starter"])
        XCTAssertEqual(userStats.points, 1000)
    }
}
