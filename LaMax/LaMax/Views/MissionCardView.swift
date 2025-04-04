//
//  MissionCardView.swift
//  LaMax
//
//  Created by Florian Taffin on 04/04/2025.
//

import SwiftUI

struct MissionCardView: View {
    var mission: Mission
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: "waveform.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .foregroundColor(.blue)
                .scaleEffect(1.1)
                .animation(.spring(), value: mission.id)
            
            VStack(alignment: .leading, spacing: 6) {
                Text(mission.title)
                    .font(.headline)
                ProgressView(value: mission.progress)
                    .progressViewStyle(LinearProgressViewStyle(tint: .blue))
                if let badge = mission.badge {
                    Text("Badge : \(badge)")
                        .font(.caption)
                        .foregroundColor(.blue)
                }
            }
            Spacer()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(UIColor.systemBackground))
                .shadow(color: .gray.opacity(0.3), radius: 3, x: 0, y: 2)
        )
        .padding(.horizontal)
    }
}

struct MissionCardView_Previews: PreviewProvider {
    static var previews: some View {
        MissionCardView(
            mission: Mission(title: "Exercice de Compréhension Orale", progress: 0.5, badge: "Vitesse")
        )
        .previewLayout(.sizeThatFits)
    }
}
