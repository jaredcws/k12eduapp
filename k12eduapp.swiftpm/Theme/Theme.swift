import SwiftUI

/// Central place for colors and fonts.
///
/// Design goals for a young learner who is easily distracted:
/// - Calm, soft background so the active task stands out.
/// - Big, rounded, friendly typography.
/// - A small, consistent palette so the screen never feels noisy.
enum Theme {
    static let background = Color(red: 0.96, green: 0.98, blue: 1.0)
    static let primary    = Color(red: 0.30, green: 0.45, blue: 0.95)
    static let accent     = Color(red: 1.00, green: 0.72, blue: 0.20)
    static let correct    = Color(red: 0.30, green: 0.78, blue: 0.45)
    static let gentle     = Color(red: 1.00, green: 0.60, blue: 0.45)
    static let ink        = Color(red: 0.18, green: 0.22, blue: 0.34)

    /// Rotating set of cheerful tile colors.
    static let tileColors: [Color] = [
        Color(red: 0.40, green: 0.62, blue: 0.98),
        Color(red: 0.98, green: 0.55, blue: 0.45),
        Color(red: 0.45, green: 0.80, blue: 0.55),
        Color(red: 0.78, green: 0.52, blue: 0.95),
        Color(red: 1.00, green: 0.72, blue: 0.30)
    ]

    /// Heavy, rounded display font for letters and headlines.
    static func display(_ size: CGFloat) -> Font {
        .system(size: size, weight: .heavy, design: .rounded)
    }

    /// Friendly rounded font for body text and buttons.
    static func rounded(_ size: CGFloat, weight: Font.Weight = .bold) -> Font {
        .system(size: size, weight: weight, design: .rounded)
    }

    /// Pick a stable color from the palette for any index (handles negatives).
    static func color(for index: Int) -> Color {
        let count = tileColors.count
        return tileColors[((index % count) + count) % count]
    }
}
