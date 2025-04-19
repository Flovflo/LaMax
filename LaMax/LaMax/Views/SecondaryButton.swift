// SecondaryButton.swift
import SwiftUI

struct SecondaryButton: View {
    var title: String
    var action: () -> Void
    var isDisabled: Bool = false
    @State private var isPressed: Bool = false
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(DT.body.weight(.semibold))
                .foregroundColor(DT.accent)
                .frame(maxWidth: .infinity, minHeight: 44)
        }
        .background(DT.background)
        .overlay(
            RoundedRectangle(cornerRadius: DT.cornerMedium)
                .stroke(DT.accent, lineWidth: 1)
        )
        .cornerRadius(DT.cornerMedium)
        .applyShadow(DT.shadowLight)
        .scaleEffect(isPressed ? 0.96 : 1.0)
        .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isPressed)
        .gesture(
            LongPressGesture(minimumDuration: 0.01)
                .onChanged { _ in isPressed = true }
                .onEnded { _ in isPressed = false }
        )
        .disabled(isDisabled)
        .opacity(isDisabled ? 0.5 : 1)
        .accessibilityLabel(Text(title))
    }
}

struct SecondaryButton_Previews: PreviewProvider {
    static var previews: some View {
        SecondaryButton(title: "Cancel", action: {})
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
