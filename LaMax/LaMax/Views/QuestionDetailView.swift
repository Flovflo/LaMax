// QuestionDetailView.swift
import SwiftUI

struct QuestionDetailView: View {
    let question: Question
    @State private var selectedChoice: Choice? = nil
    @State private var showExplanation = false
    @State private var isCorrect: Bool? = nil
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(question.text ?? "")
                .font(.headline)
            ForEach(question.choices ?? [], id: \.self) { choice in
                Button(action: {
                    selectedChoice = choice
                    isCorrect = (choice.label == (question.answer ?? ""))
                    showExplanation = true
                    if isCorrect == true {
                        _ = GamificationEngine.shared.awardPoints(event: .correctAnswer(time: 0))
                    }
                }) {
                    HStack {
                        Text(choice.label)
                            .foregroundColor(.primary)
                        Spacer()
                        if selectedChoice == choice {
                            Image(systemName: isCorrect == true ? "checkmark.circle" : "x.circle")
                                .foregroundColor(isCorrect == true ? .green : .red)
                        }
                    }
                }
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(8)
            }
            Spacer()
        }
        .padding()
    }
}
