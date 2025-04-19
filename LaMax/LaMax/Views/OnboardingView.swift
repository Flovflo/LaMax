// OnboardingView.swift
import SwiftUI

struct OnboardingView: View {
    @State private var selectedGoal: String = ""
    @State private var studyMode: String = ""
    var onContinue: (() -> Void)? = nil
    var body: some View {
        VStack(spacing: 24) {
            Text("Bienvenue! Choisissez votre objectif")
            TextField("Objectif", text: $selectedGoal)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Text("Mode d'étude préféré")
            TextField("Mode", text: $studyMode)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            PrimaryButton(title: "Continuer") {
                // Save to UserProfile
                onContinue?()
            }
        }
        .padding()
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
