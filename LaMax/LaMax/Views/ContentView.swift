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
            }
            .tabItem {
                Label("Compte", systemImage: "person.crop.circle")
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
