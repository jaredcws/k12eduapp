import Foundation

/// Short, varied encouragement and movement prompts.
///
/// Why variety matters: children with attention challenges habituate quickly,
/// so the same praise every time stops registering. Rotating phrases keeps a
/// little novelty in every reward.
enum Praise {
    static let cheers = [
        "Nice!", "You got it!", "Great job!", "Woohoo!", "Awesome!",
        "Super star!", "Yes!", "Way to go!", "Brilliant!", "High five!"
    ]

    static func cheer() -> String {
        cheers.randomElement() ?? "Great job!"
    }

    /// Quick physical "brain break" prompts offered between short sets.
    /// Movement breaks are one of the most effective ways to reset attention.
    static let movementBreaks = [
        "Stand up and stretch! 🙆",
        "Wiggle like jelly! 🪼",
        "Give yourself a big hug! 🤗",
        "Jump up 3 times! 🦘",
        "Spin around once! 🌀",
        "Reach for the sky, then touch your toes! 🤸",
        "Flap your arms like a bird! 🐦",
        "Take 3 big belly breaths. 🌬️"
    ]

    static func movementBreak() -> String {
        movementBreaks.randomElement() ?? "Stand up and stretch! 🙆"
    }
}
