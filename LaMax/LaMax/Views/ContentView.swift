//
//  ContentView.swift
//  La_Max-W
//
//  Created by Florian Taffin on 19/04/2025.
//

import SwiftUI

import SwiftUI

enum AppScreen {
    case onboarding
    case home
    case quiz(partName: String)
    case flashcards
    case chatbot
}

struct ContentView: View {
    @State private var screen: AppScreen = .onboarding
    var body: some View {
        NavigationStack {
            switch screen {
            case .onboarding:
                OnboardingView(onContinue: { screen = .home })
            case .home:
                HomeScreen(
    onStartQuiz: { part in screen = .quiz(partName: part) },
    onShowFlashcards: { screen = .flashcards },
    onChat: { screen = .chatbot }
)
            case .quiz(let partName):
                QuizView(viewModel: QuizViewModel(partName: partName), onQuit: { screen = .home })
            case .flashcards:
                FlashcardView(viewModel: SpacedRepetitionViewModel(), onBack: { screen = .home })
            case .chatbot:
                ChatBotView(onBack: { screen = .home })
            }
        }
    }
}

#Preview {
    ContentView()
}
