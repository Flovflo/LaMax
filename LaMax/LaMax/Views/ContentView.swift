//
//  ContentView.swift
//  LaMax
//
//  Created by Florian Taffin on 04/04/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            // Onglet Accueil
            NavigationStack {
                HomeView()
                    .navigationTitle("Accueil")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbarBackground(.ultraThinMaterial, for: .navigationBar)
                    .toolbarBackground(.visible, for: .navigationBar)
                    .toolbarColorScheme(.light, for: .navigationBar)
                    .transition(.move(edge: .leading))
            }
            .tabItem {
                Label("Accueil", systemImage: "house.fill")
            }
            
            // Onglet Compte
            NavigationStack {
                AccountView()
                    .navigationTitle("Mon Compte")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbarBackground(.ultraThinMaterial, for: .navigationBar)
                    .toolbarBackground(.visible, for: .navigationBar)
                    .toolbarColorScheme(.light, for: .navigationBar)
                    .transition(.move(edge: .bottom))
            }
            .tabItem {
                Label("Compte", systemImage: "person.crop.circle")
            }
            
            // Onglet Gamification
            NavigationStack {
                GamificationView()
                    .navigationTitle("Gamification")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbarBackground(.ultraThinMaterial, for: .navigationBar)
                    .toolbarBackground(.visible, for: .navigationBar)
                    .toolbarColorScheme(.light, for: .navigationBar)
                    .transition(.move(edge: .trailing))
            }
            .tabItem {
                Label("Gamification", systemImage: "gamecontroller.fill")
            }
        }
        .animation(.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 0.3), value: UUID())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
