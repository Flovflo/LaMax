// ProgressRingSM2.swift
import SwiftUI

struct ProgressRingSM2: View {
    var progress: Double // 0.0 to 1.0
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.gray.opacity(0.2), lineWidth: 8)
            Circle()
                .trim(from: 0, to: progress)
                .stroke(Color.accentColor, style: StrokeStyle(lineWidth: 8, lineCap: .round))
                .rotationEffect(.degrees(-90))
            Text("\(Int(progress * 100))%")
                .font(.headline)
                .accessibilityLabel(Text("Progression \(Int(progress * 100)) pourcent"))
        }
        .frame(width: 60, height: 60)
    }
}

struct ProgressRingSM2_Previews: PreviewProvider {
    static var previews: some View {
        ProgressRingSM2(progress: 0.7)
    }
}
