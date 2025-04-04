
//
//  ListeningQuizView.swift
//  LaMax
//
//  Created by Florian Taffin on 04/04/2025.
//

import SwiftUI

struct ListeningQuizView: View {
    var part: Int
    
    var sampleQuiz: QuizQuestion {
        QuizQuestion(
            question: "Écoutez l'extrait audio et répondez à la question de PART \(part).",
            options: ["A": "Option A", "B": "Option B", "C": "Option C", "D": "Option D"],
            answer: "A",
            grammarTopic: "Listening Comprehension",
            explanation: "Explication de la bonne réponse pour PART \(part).",
            difficulty: "easy"
        )
    }
    
    var body: some View {
        VStack {
            Text("Listening Part \(part)")
                .font(.largeTitle)
                .padding()
            // Intégrer ici un lecteur audio par exemple
            QuizView(quizData: sampleQuiz)
        }
        .navigationTitle("Listening PART \(part)")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ListeningQuizView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ListeningQuizView(part: 1)
        }
    }
}
