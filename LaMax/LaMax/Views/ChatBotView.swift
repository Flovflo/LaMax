// ChatBotView.swift
import SwiftUI

struct ChatBotView: View {
    @State private var message: String = ""
    var onBack: (() -> Void)? = nil
    var body: some View {
        VStack {
            Spacer()
            HStack {
                TextField("Message...", text: $message)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button(action: {
                    // Call ChatService
                }) {
                    Image(systemName: "paperplane.fill")
                }
            }
            .padding()
            .background(.ultraThinMaterial)
            PrimaryButton(title: "Retour") {
                onBack?()
            }
        }
    }
}

struct ChatBotView_Previews: PreviewProvider {
    static var previews: some View {
        ChatBotView()
    }
}
