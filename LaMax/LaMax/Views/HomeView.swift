//
//  HomeView.swift
//  LaMax
//
//  Created by Florian Taffin on 04/04/2025.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @State private var appearAnimation = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 32) {
                    // Section Défis du jour et du mois
                    DailyChallengeView(dailyTarget: 30, monthlyTarget: 600)
                        .padding()
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.purple.opacity(0.1), Color.blue.opacity(0.1)]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                            .cornerRadius(16)
                        )
                        .padding(.horizontal)
                    
                    // Section Listening Practice avec choix du PART
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Listening Practice")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.horizontal)
                        
                        ListeningPracticeView()
                    }
                    .padding()
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.blue.opacity(0.05), Color.blue.opacity(0.1)]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .cornerRadius(16)
                    )
                    .padding(.horizontal)
                    
                    // Section Reading Practice avec choix du PART
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Reading Practice")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.horizontal)
                        
                        ReadingPracticeView()
                    }
                    .padding()
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.green.opacity(0.05), Color.green.opacity(0.1)]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .cornerRadius(16)
                    )
                    .padding(.horizontal)
                    
                    // Section Missions complémentaires
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Vos Missions")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.horizontal)
                        
                        ForEach(viewModel.missions) { mission in
                            MissionCardView(mission: mission)
                                .padding(.horizontal)
                        }
                    }
                    .padding(.bottom, 16)
                }
                .opacity(appearAnimation ? 1 : 0)
                .animation(.easeOut(duration: 0.6), value: appearAnimation)
            }
            .onAppear { appearAnimation = true }
            .navigationTitle("Accueil")
            .navigationBarTitleDisplayMode(.inline)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color.white, Color.gray.opacity(0.05)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
            )
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
