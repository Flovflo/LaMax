//
//  ListeningPracticeView.swift
//  LaMax
//
//  Created by Florian Taffin on 04/04/2025.
//

import SwiftUI

struct ListeningPracticeView: View {
    var body: some View {
        VStack(spacing: 12) {
            ForEach(1..<5) { part in
                NavigationLink(destination: ListeningQuizView(part: part)) {
                    Text("PART \(part)")
                        .font(.headline)
                        .foregroundColor(.primary)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.blue.opacity(0.3), Color.blue.opacity(0.1)]),
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

struct ListeningPracticeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ListeningPracticeView()
        }
    }
}
