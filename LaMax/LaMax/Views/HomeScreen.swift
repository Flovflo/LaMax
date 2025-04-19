// HomeScreen.swift
import SwiftUI

struct HomeScreen: View {
    var onStartQuiz: ((String) -> Void)? = nil
    var onShowFlashcards: (() -> Void)? = nil
    var onChat: (() -> Void)? = nil
    var body: some View {
        VStack(spacing: 24) {
            Text("Daily Quest")
                .font(.largeTitle)
            TabView {
                ForEach(0..<3) { idx in
                    AppCard { Text("Quest \(idx + 1)") }
                }
            }
            .tabViewStyle(PageTabViewStyle())
            ProgressRingSM2(progress: 0.4)
            HStack(spacing: 16) {
                PrimaryButton(title: "Quiz TOEIC Part 5") { onStartQuiz?("part5") }
                PrimaryButton(title: "Flashcards") { onShowFlashcards?() }
                PrimaryButton(title: "ChatBot") { onChat?() }
            }
        }
        .padding()
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
