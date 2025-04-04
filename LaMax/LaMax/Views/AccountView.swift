//
//  AccountView.swift
//  LaMax
//
//  Created by Florian Taffin on 04/04/2025.
//

import SwiftUI

struct AccountView: View {
    @State private var animateProfile = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    // En-tête du profil
                    VStack {
                        Image("profile_placeholder") // Remplacez par le nom de votre asset
                            .resizable()
                            .scaledToFill()
                            .frame(width: 120, height: 120)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.blue, lineWidth: 4))
                            .shadow(radius: 10)
                            .scaleEffect(animateProfile ? 1 : 0.8)
                            .opacity(animateProfile ? 1 : 0)
                            .animation(.spring(response: 0.6, dampingFraction: 0.7), value: animateProfile)
                        
                        Text("Flo")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .opacity(animateProfile ? 1 : 0)
                            .animation(.easeIn(duration: 0.4).delay(0.2), value: animateProfile)
                        
                        Text("florian@example.com")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .opacity(animateProfile ? 1 : 0)
                            .animation(.easeIn(duration: 0.4).delay(0.3), value: animateProfile)
                    }
                    .padding()
                    .onAppear {
                        animateProfile = true
                    }
                    
                    // Statistiques du profil
                    HStack(spacing: 32) {
                        StatView(icon: "star.fill", title: "Points", value: "1200", color: .yellow)
                        StatView(icon: "flame.fill", title: "Niveau", value: "5", color: .red)
                        StatView(icon: "rosette", title: "Badges", value: "8", color: .purple)
                    }
                    .padding(.vertical)
                    
                    // Boutons d'action
                    HStack(spacing: 20) {
                        ActionButtonView(icon: "pencil", title: "Modifier")
                        ActionButtonView(icon: "gear", title: "Paramètres")
                    }
                    
                    Spacer()
                }
                .padding()
            }
            .navigationTitle("Mon Compte")
        }
    }
}

struct StatView: View {
    var icon: String
    var title: String
    var value: String
    var color: Color

    var body: some View {
        VStack {
            Image(systemName: icon)
                .foregroundColor(color)
                .font(.title)
            Text(title)
                .font(.caption)
            Text(value)
                .font(.headline)
        }
    }
}

struct ActionButtonView: View {
    var icon: String
    var title: String

    var body: some View {
        Button(action: {
            // Action à implémenter
        }) {
            HStack {
                Image(systemName: icon)
                Text(title)
            }
            .padding()
            .background(Color.blue.opacity(0.2))
            .cornerRadius(8)
            .scaleEffect(1.0)
            .animation(.spring(), value: title)
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
