//
//  ReadingPracticeView.swift
//  LaMax
//
//  Created by Florian Taffin on 04/04/2025.
//

import SwiftUI

struct ReadingPracticeView: View {
    var body: some View {
        VStack(spacing: 12) {
            ForEach(5..<8) { part in
                NavigationLink(destination: ReadingQuizView(part: part)) {
                    Text("PART \(part)")
                        .font(.headline)
                        .foregroundColor(.primary)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.green.opacity(0.3), Color.green.opacity(0.1)]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(8)
                }
            }
        }
        .padding(.horizontal)
    }
}

struct ReadingPracticeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ReadingPracticeView()
        }
    }
}
