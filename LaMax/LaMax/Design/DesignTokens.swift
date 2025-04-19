// DesignTokens.swift
// Design tokens for La_Max-W iOS18 theme
import SwiftUI

struct DT {
    // Colors
    static let accent = Color.accentColor
    static let background = Color(.systemBackground)
    static let primaryText = Color(.label)
    static let secondaryText = Color(.secondaryLabel)
    static let disabled = Color(.tertiaryLabel)
    // Typography
    static let hero = Font.largeTitle.weight(.bold)
    static let title = Font.title.weight(.semibold)
    static let subtitle = Font.title2
    static let body = Font.body
    static let caption = Font.caption
    // Spacing (4pt scale)
    enum Space {
        static let xs: CGFloat = 4
        static let sm: CGFloat = 8
        static let md: CGFloat = 16
        static let lg: CGFloat = 24
        static let xl: CGFloat = 32
    }
    // Corners
    static let cornerSmall: CGFloat = 8
    static let cornerMedium: CGFloat = 12
    static let cornerLarge: CGFloat = 16
    // Shadows
    static let shadowLight = Shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
    static let shadowStrong = Shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
}

// Helper type for shadows
typealias Shadow = (color: Color, radius: CGFloat, x: CGFloat, y: CGFloat)

extension View {
    func applyShadow(_ shadow: Shadow) -> some View {
        self.shadow(color: shadow.color, radius: shadow.radius, x: shadow.x, y: shadow.y)
    }
}
