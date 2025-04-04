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
            ZStack {
                // Fond dégradé moderne
                LinearGradient(
                    gradient: Gradient(colors: [.white, Color.blue.opacity(0.1)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea(edges: [.bottom, .leading, .trailing])
                
                ScrollView {
                    VStack(spacing: 24) {
                        DashboardCardView(userStats: viewModel.userStats)
                            .padding(.horizontal)
                            .scaleEffect(appearAnimation ? 1 : 0.9)
                            .opacity(appearAnimation ? 1 : 0)
                            .animation(.easeOut(duration: 0.6).delay(0.1), value: appearAnimation)
                        
                        ForEach(viewModel.missions) { mission in
                            MissionCardView(mission: mission)
                                .scaleEffect(appearAnimation ? 1 : 0.95)
                                .opacity(appearAnimation ? 1 : 0)
                                .animation(.easeOut(duration: 0.5).delay(0.2), value: appearAnimation)
                        }
                    }
                    .padding(.vertical, 20)
                }
            }
            .onAppear {
                appearAnimation = true
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
