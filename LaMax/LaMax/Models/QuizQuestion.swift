//
//  QuizQuestion.swift
//  LaMax
//
//  Created by Florian Taffin on 04/04/2025.
//

import Foundation

struct QuizQuestion: Identifiable {
    let id = UUID()
    var question: String
    var options: [String: String]
    var answer: String
    var grammarTopic: String
    var explanation: String
    var difficulty: String
}
