// SpacedRepetitionViewModel.swift
import Foundation

class SpacedRepetitionViewModel: ObservableObject {
    @Published var word: String = "Bonjour"
    @Published var definition: String = "Hello (in French)"
    @Published var example: String = "Bonjour, comment ça va ?"
    // Ajouter ici la logique Leitner/SM-2 si besoin
}
