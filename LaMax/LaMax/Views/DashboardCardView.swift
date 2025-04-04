//
//  DashboardCardView.swift
//  LaMax
//
//  Created by Florian Taffin on 04/04/2025.
//

import SwiftUI

struct DashboardCardView: View {
    var userStats: UserStats

    var body: some View {
        ZStack(alignment: .topLeading) {
            LinearGradient(
                gradient: Gradient(colors: [Color.blue.opacity(0.9), Color.purple.opacity(0.9)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .cornerRadius(16)
            .shadow(color: .gray.opacity(0.4), radius: 5, x: 0, y: 3)

            VStack(alignment: .leading, spacing: 12) {
                Text("Bonjour, Flo !")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    Text("Points : \(userStats.points)")
                        .foregroundColor(.white)
                        .font(.body)
                }
                
                HStack {
                    Image(systemName: "flag.fill")
                        .foregroundColor(.green)
                    Text("Niveau : \(userStats.level)")
                        .foregroundColor(.white)
                        .font(.body)
                }
                
                HStack(spacing: 8) {
                    ForEach(userStats.badges, id: \.self) { badge in
                        Text(badge)
                            .font(.caption)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(
                                Capsule()
                                    .fill(Color.white.opacity(0.2))
                            )
                            .foregroundColor(.white)
                    }
                }
            }
            .padding(16)
        }
        .padding(.horizontal)
    }
}

struct DashboardCardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardCardView(
            userStats: UserStats(points: 1200, level: 3, badges: ["Expert", "Rapide"])
        )
        .previewLayout(.sizeThatFits)
    }
}
