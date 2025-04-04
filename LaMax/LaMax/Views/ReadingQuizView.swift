//
//  ReadingQuizView.swift
//  LaMax
//
//  Created by Florian Taffin on 04/04/2025.
//

import SwiftUI

struct ReadingQuizView: View {
    var part: Int
    
    var sampleQuiz: QuizQuestion {
        QuizQuestion(
            question: "Voici une question de Reading pour le PART \(part).",
            options: ["A": "Option A", "B": "Option B", "C": "Option C", "D": "Option D"],
            answer: "B",
            grammarTopic: "Reading Comprehension",
            explanation: "Explication de la bonne réponse pour le Reading PART \(part).",
            difficulty: "medium"
        )
    }
    
    var body: some View {
        VStack {
            Text("Reading Part \(part)")
                .font(.largeTitle)
                .padding()
            QuizView(quizData: sampleQuiz)
        }
        .navigationTitle("Reading PART \(part)")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ReadingQuizView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ReadingQuizView(part: 5)
        }
    }
}
