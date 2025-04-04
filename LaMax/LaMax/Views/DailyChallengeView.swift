//
//  DailyChallengeView.swift
//  LaMax
//
//  Created by Florian Taffin on 04/04/2025.
//

import SwiftUI

struct DailyChallengeView: View {
    var dailyTarget: Int
    var monthlyTarget: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Défis du jour")
                .font(.title2)
                .fontWeight(.bold)
            Text("Objectif de quiz quotidien : \(dailyTarget) questions")
                .font(.body)
            Text("Objectif mensuel : \(monthlyTarget) questions")
                .font(.body)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.blue.opacity(0.1))
        )
    }
}

struct DailyChallengeView_Previews: PreviewProvider {
    static var previews: some View {
        DailyChallengeView(dailyTarget: 30, monthlyTarget: 600)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
