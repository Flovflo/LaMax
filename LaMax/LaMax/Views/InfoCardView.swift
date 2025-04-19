// InfoCardView.swift
import SwiftUI

struct InfoCardView<Content: View>: View {
    let id: String
    let content: Content
    @State private var isPressed: Bool = false
    
    init(id: String = UUID().uuidString, @ViewBuilder content: () -> Content) {
        self.id = id
        self.content = content()
    }
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: DT.cornerLarge)
                .fill(.ultraThinMaterial)
                .applyShadow(DT.shadowStrong)
            content
                .padding(DT.Space.md)
        }
        .frame(minWidth: 280, idealHeight: 180, maxHeight: 200)
        .scaleEffect(isPressed ? 1.02 : 1)
        .animation(.easeInOut(duration: 0.2), value: isPressed)
        .gesture(
            LongPressGesture(minimumDuration: 0.01)
                .onChanged { _ in isPressed = true }
                .onEnded { _ in isPressed = false }
        )
        .matchedGeometryEffect(id: id, in: NamespaceHolder.shared.namespace)
    }
}

struct InfoCardView_Previews: PreviewProvider {
    static var previews: some View {
        InfoCardView { VStack(alignment: .leading) {
            Text("Daily Quest").font(DT.subtitle.bold())
            Text("Révise 10 mots et gagne 50 XP").font(DT.body)
            ProgressView(value: 0.6).tint(DT.accent)
        }}
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
