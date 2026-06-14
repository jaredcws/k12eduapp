import UIKit

/// Small, gentle vibrations that reinforce taps and celebrate success.
/// Multi-sensory feedback (sound + touch + motion) helps hold attention.
enum Haptics {
    static func tap() {
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
    }

    static func soft() {
        UIImpactFeedbackGenerator(style: .soft).impactOccurred()
    }

    static func success() {
        UINotificationFeedbackGenerator().notificationOccurred(.success)
    }
}
