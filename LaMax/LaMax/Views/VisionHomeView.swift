// VisionHomeView.swift
import SwiftUI
import Combine
import CoreMotion

// MARK: - MotionManager
class MotionManager: ObservableObject {
    static let shared = MotionManager()
    @Published var tilt: CGSize = .zero
    private let manager = CMMotionManager()
    private init() {
        manager.deviceMotionUpdateInterval = 1/60
        manager.startDeviceMotionUpdates(to: .main) { data, _ in
            guard let attitude = data?.attitude else { return }
            let roll = attitude.roll / (.pi / 2) // -1...1
            let pitch = attitude.pitch / (.pi / 2)
            self.tilt = CGSize(width: roll, height: pitch)
        }
    }
}

// MARK: - ViewModifiers
struct ParallaxEffect: ViewModifier {
    @State private var tilt: CGSize = .zero
    func body(content: Content) -> some View {
        content
            .rotation3DEffect(.degrees(tilt.width * 5), axis: (x: 0, y: 1, z: 0))
            .rotation3DEffect(.degrees(tilt.height * 5), axis: (x: 1, y: 0, z: 0))
            .onReceive(MotionManager.shared.$tilt) { tilt = $0 }
    }
}

struct GlowEffect: ViewModifier {
    var color: Color
    @State private var glow = false
    func body(content: Content) -> some View {
        content
            .shadow(color: color.opacity(glow ? 0.8 : 0.2), radius: glow ? 20 : 5)
            .onAppear {
                withAnimation(.easeInOut(duration: 1.2).repeatForever(autoreverses: true)) {
                    glow.toggle()
                }
            }
    }
}

struct GrainEffect: View {
    var body: some View {
        Canvas { ctx, size in
            let rect = CGRect(origin: .zero, size: size)
            ctx.fill(Path(rect), with: .color(Color.white.opacity(0.03)))
        }
        .blendMode(.overlay)
        .ignoresSafeArea()
    }
}

// MARK: - Components
struct TitleView: View {
    var body: some View {
        Text("Daily Quest")
            .font(.system(size: 36, weight: .semibold))
            .kerning(1)
            .foregroundStyle(.primary)
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16))
            .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
    }
}

struct QuestCardView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(.thickMaterial)
            Text("Quest 1")
                .font(.system(size: 24, weight: .medium))
                .foregroundStyle(.primary)
        }
        .frame(height: 120)
        .cornerRadius(20)
        .shadow(color: Color(red: 77/255, green: 158/255, blue: 1).opacity(0.15), radius: 30, x: 0, y: 10)
        // Press effect removed to allow NavigationLink
    }
}

struct ProgressRingView: View {
    var progress: CGFloat // 0...1
    @State private var animateBounce = false
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 6)
                .foregroundColor(.secondary.opacity(0.3))
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    AngularGradient(gradient: Gradient(colors: [Color(red: 77/255, green: 158/255, blue: 1), Color(red: 77/255, green: 158/255, blue: 1).opacity(0)]), center: .center),
                    style: StrokeStyle(lineWidth: 6, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))
                .onChange(of: progress) { _, _ in
    withAnimation(.interactiveSpring(response: 0.3, dampingFraction: 0.5)) {
        animateBounce = true
    }
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
        animateBounce = false
    }
}
            Text("\(Int(progress * 100))%")
                .font(.headline)
                .foregroundStyle(.primary)
        }
        .frame(width: 100, height: 100)
        .background(.ultraThinMaterial, in: Circle())
        .scaleEffect(animateBounce ? 1.05 : 1)
    }
}

struct NavButton: View {
    let label: String
    let systemImage: String
    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: systemImage)
                .font(.system(size: 28))
            Text(label)
                .font(.caption)
        }
        .foregroundStyle(.primary)
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.clear)
        )
    }
}

struct BottomNavView: View {
    var body: some View {
        HStack(spacing: 16) {
            NavButton(label: "Quiz", systemImage: "book.closed")
            NavButton(label: "Flashcards", systemImage: "rectangle.stack")
            NavButton(label: "ChatBot", systemImage: "ellipsis.bubble")
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 8)
        .background(
    Capsule()
        .fill(.thinMaterial)
)
//.blur(radius: 20)
.frame(maxWidth: .infinity)
        .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: -2)
    }
}

// MARK: - VisionHomeView
struct VisionHomeView: View {
    private let accentColor = Color(red: 77/255, green: 158/255, blue: 1)
    private let secondaryAccent = Color(red: 1, green: 191/255, blue: 105/255)
    var body: some View {
        NavigationStack {
            ZStack {
                GrainEffect()
                Color(.systemBackground)
                    .overlay(
                        RadialGradient(
                            gradient: Gradient(colors: [accentColor.opacity(0.2), .clear]),
                            center: .center,
                            startRadius: 10,
                            endRadius: 500
                        )
                        .blur(radius: 200)
                    )
                    .ignoresSafeArea()
                    .modifier(ParallaxEffect())

                VStack(spacing: 32) {
                    TitleView()
                    NavigationLink {
                        QuizEntryView()
                    } label: {
                        QuestCardView()
                    }
                    ProgressRingView(progress: 0.4)
                    Spacer()
                    HStack(spacing: 16) {
                        NavigationLink {
                            QuizEntryView()
                        } label: {
                            NavButton(label: "Quiz", systemImage: "book.closed")
                        }
                        NavigationLink {
                            FlashcardView(viewModel: SpacedRepetitionViewModel(), onBack: { })
                        } label: {
                            NavButton(label: "Flashcards", systemImage: "rectangle.stack")
                        }
                        NavigationLink {
                            ChatBotView(onBack: { })
                        } label: {
                            NavButton(label: "ChatBot", systemImage: "ellipsis.bubble")
                        }
                    }
                    .padding(.vertical, 12)
                    .padding(.horizontal, 8)
                    .background(
                        Capsule().fill(.thinMaterial)
                    )
                    .frame(maxWidth: .infinity)
                    .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: -2)
                }
                .padding(.horizontal, 20)
            }
        }
    }
}

struct VisionHomeView_Previews: PreviewProvider {
    static var previews: some View {
        VisionHomeView()
    }
}
