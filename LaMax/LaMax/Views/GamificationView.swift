//
//  GamificationView.swift
//  LaMax
//
//  Created by Florian Taffin on 04/04/2025.
//

import SwiftUI

struct GamificationView: View {
    @State private var showContent = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    SectionView(
                        icon: "star.fill",
                        title: "Points, Badges et Niveaux",
                        description: "À chaque exercice validé, des points sont attribués. Des badges spécifiques (exemple : « Expert en Vocabulaire ») se débloquent au fil de la progression.",
                        bgColor: Color.blue.opacity(0.1)
                    )
                    
                    SectionView(
                        icon: "calendar",
                        title: "Défis Quotidiens et Missions",
                        description: "Chaque jour, l’utilisateur se voit proposer des missions personnalisées qui, une fois accomplies, débloquent du contenu exclusif ou des améliorations de profil.",
                        bgColor: Color.orange.opacity(0.1)
                    )
                    
                    SectionView(
                        icon: "hand.tap",
                        title: "Feedback et Haptic",
                        description: "Des retours haptiques et des animations natives sont utilisés lors de la validation des réponses, renforçant le plaisir d’apprendre.",
                        bgColor: Color.green.opacity(0.1)
                    )
                    
                    SectionView(
                        icon: "person.3.fill",
                        title: "Social et Compétitif",
                        description: "Le leaderboard et la possibilité de défier d’autres utilisateurs via des notifications natives dynamisent la compétition amicale et l’entraide.",
                        bgColor: Color.purple.opacity(0.1)
                    )
                    
                    Spacer()
                }
                .padding()
                .opacity(showContent ? 1 : 0)
                .animation(.easeIn(duration: 0.6), value: showContent)
            }
            .navigationTitle("Gamification")
            .onAppear {
                showContent = true
            }
        }
    }
}

struct SectionView: View {
    var icon: String
    var title: String
    var description: String
    var bgColor: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(bgColor.opacity(1))
                    .font(.title2)
                Text(title)
                    .font(.title3)
                    .fontWeight(.bold)
            }
            Text(description)
                .font(.body)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(bgColor)
        )
    }
}

struct GamificationView_Previews: PreviewProvider {
    static var previews: some View {
        GamificationView()
    }
}
