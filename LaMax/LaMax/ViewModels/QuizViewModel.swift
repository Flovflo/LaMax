// QuizViewModel.swift
import Foundation
import Combine

@MainActor
final class QuizViewModel: ObservableObject {
    @Published var questions: [Question] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    let partName: String
    private let api = QuizAPIClient.shared

    init(partName: String) {
        self.partName = partName
        Task { await load() }
    }

    func load() async {
        isLoading = true
        errorMessage = nil
        do {
            let quizPart = try await api.fetchQuizPart(named: partName)
            self.questions = quizPart.questions
        } catch {
            self.errorMessage = error.localizedDescription
        }
        isLoading = false
    }

    func retry() {
        Task { await load() }
    }
}
