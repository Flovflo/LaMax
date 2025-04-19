// PrimaryButton.swift
import SwiftUI

struct PrimaryButton: View {
    var title: String
    var action: () -> Void
    var isDisabled: Bool = false
    @State private var isPressed: Bool = false
    var body: some View {
        Button(action: {
            HapticFeedback.light()
            action()
        }) {
            Text(title)
                .font(DT.body.weight(.semibold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, minHeight: 44)
                .background(isDisabled ? DT.accent.opacity(0.5) : DT.accent)
                .cornerRadius(DT.cornerMedium)
                .applyShadow(DT.shadowLight)
        }
        .disabled(isDisabled)
        .opacity(isDisabled ? 0.5 : 1)
        .scaleEffect(isPressed ? 0.96 : 1.0)
        .animation(.spring(response: 0.3, dampingFraction: 0.5), value: isPressed)
        .gesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in isPressed = true }
                .onEnded { _ in isPressed = false }
        )
        .accessibilityLabel(Text(title))
    }
}

// Simple haptic helper
enum HapticFeedback {
    static func light() { UINotificationFeedbackGenerator().notificationOccurred(.success) }
}

struct PrimaryButton_Previews: PreviewProvider {
    static var previews: some View {
        PrimaryButton(title: "Continue", action: {})
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
