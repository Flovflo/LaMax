//
//  QuizView.swift
//  LaMax
//
//  Created by Florian Taffin on 04/04/2025.
//

import SwiftUI

struct QuizView: View {
    var quizData: QuizQuestion
    @State private var selectedOption: String? = nil
    @State private var showExplanation = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(quizData.question)
                .font(.headline)
            
            ForEach(quizData.options.keys.sorted(), id: \.self) { key in
                Button(action: {
                    selectedOption = key
                    withAnimation { showExplanation = true }
                    // Retour haptique différencié selon la réponse
                    HapticService.shared.triggerFeedback(isCorrect: key == quizData.answer)
                }) {
                    Text("\(key): \(quizData.options[key]!)")
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(
                            selectedOption == key
                                ? (key == quizData.answer ? Color.green.opacity(0.3) : Color.red.opacity(0.3))
                                : Color.gray.opacity(0.1)
                        )
                        .cornerRadius(8)
                }
            }
            
            if showExplanation, selectedOption != nil {
                Text("Explication : \(quizData.explanation)")
                    .font(.caption)
                    .padding(.top, 8)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(UIColor.secondarySystemBackground))
                .shadow(radius: 3)
        )
    }
}

struct QuizView_Previews: PreviewProvider {
    static var previews: some View {
        QuizView(quizData: QuizQuestion(
            question: "Sample question",
            options: ["A": "Option A", "B": "Option B", "C": "Option C", "D": "Option D"],
            answer: "A",
            grammarTopic: "Listening",
            explanation: "Explication de la bonne réponse.",
            difficulty: "easy"
        ))
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
