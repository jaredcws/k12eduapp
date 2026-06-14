import Foundation
import Observation

/// Tracks the child's name, stars earned, and what they've learned.
/// State is saved to `UserDefaults` so progress survives app restarts.
@Observable
final class ProgressStore {
    var childName: String { didSet { save() } }
    private(set) var totalStars: Int { didSet { save() } }
    private(set) var masteredPhonemes: Set<String> { didSet { save() } }
    private(set) var builtWords: Set<String> { didSet { save() } }

    private let defaults = UserDefaults.standard

    init() {
        // Property observers do not fire during init, so this does not re-save.
        childName = defaults.string(forKey: Keys.name) ?? ""
        totalStars = defaults.integer(forKey: Keys.stars)
        masteredPhonemes = Set(defaults.stringArray(forKey: Keys.phonemes) ?? [])
        builtWords = Set(defaults.stringArray(forKey: Keys.words) ?? [])
    }

    func awardStar(_ count: Int = 1) {
        totalStars += count
    }

    /// Mark a sound as learned. Awards a star only the first time.
    func markPhonemeMastered(_ id: String) {
        guard !masteredPhonemes.contains(id) else { return }
        masteredPhonemes.insert(id)
        awardStar()
    }

    /// Mark a word as successfully built. Awards a star only the first time.
    func markWordBuilt(_ text: String) {
        guard !builtWords.contains(text) else { return }
        builtWords.insert(text)
        awardStar()
    }

    private func save() {
        defaults.set(childName, forKey: Keys.name)
        defaults.set(totalStars, forKey: Keys.stars)
        defaults.set(Array(masteredPhonemes), forKey: Keys.phonemes)
        defaults.set(Array(builtWords), forKey: Keys.words)
    }

    private enum Keys {
        static let name = "childName"
        static let stars = "totalStars"
        static let phonemes = "masteredPhonemes"
        static let words = "builtWords"
    }
}
