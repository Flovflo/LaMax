// AppCard.swift
import SwiftUI

struct AppCard<Content: View>: View {
    let content: Content
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    var body: some View {
        content
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(.systemBackground))
                    .shadow(radius: 4)
            )
            .accessibilityElement(children: .contain)
    }
}

struct AppCard_Previews: PreviewProvider {
    static var previews: some View {
        AppCard { Text("Sample Card") }
    }
}
