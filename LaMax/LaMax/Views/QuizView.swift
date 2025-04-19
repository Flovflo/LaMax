// QuizView.swift
import SwiftUI

struct QuizView: View {
    @ObservedObject var viewModel: QuizViewModel
    var onQuit: (() -> Void)? = nil

    var body: some View {
        Group {
            if viewModel.isLoading {
                ProgressView("Chargement…")
                    .progressViewStyle(CircularProgressViewStyle())
            } else if let error = viewModel.errorMessage {
                VStack(spacing: 16) {
                    Text("Erreur : \(error)")
                        .foregroundColor(.red)
                    Button("Réessayer") {
                        Task { await viewModel.load() }
                    }
                }
            } else {
                List(viewModel.questions) { question in
                    NavigationLink(destination: QuestionDetailView(question: question)) {
                        Text(question.text ?? "")
                            .padding(.vertical, 8)
                    }
                }
                .listStyle(PlainListStyle())
            }
        }
        .navigationTitle("Quiz \(viewModel.partName.capitalized)")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Quitter") { onQuit?() }
            }
        }
    }
}

struct QuizView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            QuizView(viewModel: QuizViewModel(partName: "part5"), onQuit: {})
        }
    }
}
