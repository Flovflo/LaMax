// LaMaxDesign.swift
// Design system for La_Max-W: iOS18 Apple-grade components
import SwiftUI

// MARK: - LMCardView
struct LMCardView<Content: View>: View {
    let id: String
    let content: Content
    init(id: String = UUID().uuidString, @ViewBuilder content: () -> Content) {
        self.id = id
        self.content = content()
    }
    var body: some View {
        content
            .frame(width: 300, height: 180)
            .background(.ultraThinMaterial)
            .cornerRadius(16)
            .shadow(radius: 8)
            .matchedGeometryEffect(id: id, in: NamespaceHolder.shared.namespace)
    }
}

// MARK: - LMPrimaryButton
struct LMPrimaryButton: View {
    let title: String
    var isLoading: Bool = false
    var isDisabled: Bool = false
    let action: () -> Void
    var body: some View {
        Button(action: {
            Haptic.hit(.medium)
            action()
        }) {
            if isLoading {
                ProgressView()
                    .progressViewStyle(.circular)
            } else {
                Text(title)
                    .font(.body.weight(.semibold))
            }
        }
        .buttonStyle(.borderedProminent)
        .controlSize(.large)
        .cornerRadius(12)
        .opacity(isDisabled ? 0.5 : 1)
        .disabled(isDisabled || isLoading)
    }
}

// MARK: - LMBadgeView
struct LMBadgeView: View {
    let systemName: String
    var body: some View {
        Image(systemName: systemName)
            .font(.title2)
            .frame(width: 32, height: 32)
            .clipShape(Circle())
            .onAppear {
                withAnimation(.interpolatingSpring(stiffness: 150, damping: 12)) {}
            }
    }
}

// MARK: - ProgressRing
struct ProgressRing: View {
    var progress: Double
    @State private var animated: Double = 0
    var body: some View {
        Circle()
            .trim(from: 0, to: animated)
            .stroke(Color.accentColor, style: StrokeStyle(lineWidth: 6, lineCap: .round))
            .frame(width: 80, height: 80)
            .rotationEffect(.degrees(-90))
            .onAppear {
                withAnimation(.easeInOut(duration: 0.7)) {
                    animated = progress
                }
            }
    }
}

// MARK: - GlassModal
struct GlassModal<Content: View>: View {
    @Binding var isPresented: Bool
    let content: Content
    init(isPresented: Binding<Bool>, @ViewBuilder content: () -> Content) {
        self._isPresented = isPresented
        self.content = content()
    }
    var body: some View {
        if isPresented {
            ZStack {
                Color.black.opacity(0.3).ignoresSafeArea()
                VStack {
                    Spacer()
                    content
                        .padding()
                        .background(.thinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .gesture(
                            DragGesture().onEnded { _ in isPresented = false }
                        )
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                }
            }
            .animation(.spring(), value: isPresented)
        }
    }
}

// MARK: - NamespaceHolder for matchedGeometryEffect
class NamespaceHolder {
    static let shared = NamespaceHolder()
    let namespace = Namespace().wrappedValue
    private init() {}
}

// MARK: - Haptic helper
enum Haptic {
    static func hit(_ style: UIImpactFeedbackGenerator.FeedbackStyle) {
        UIImpactFeedbackGenerator(style: style).impactOccurred()
    }
}

// MARK: - View Modifiers
extension View {
    func glassStyle() -> some View {
        self.background(.ultraThinMaterial).cornerRadius(20).shadow(radius: 5)
    }
    func cardAnimation() -> some View {
        self.transition(.scale.combined(with: .opacity)).animation(.spring(), value: UUID())
    }
}
