import Foundation
import Observation

/// Tracks the child's name, settings, stars earned, and what they've learned.
/// State is saved to `UserDefaults` so progress survives app restarts.
@Observable
final class ProgressStore {
    /// Stars needed to unlock each new sticker reward.
    static let starsPerSticker = 10

    // MARK: - Parent settings

    var childName: String { didSet { save() } }

    /// Calm Mode tones the app down for sensory-sensitive days: gentler
    /// celebrations, no screen-dimming flashes, and less spoken chatter.
    var calmMode: Bool { didSet { save() } }

    /// How many items make up one short set before a brain break.
    /// Parent-adjustable so the burst can match the child's day.
    var setSize: Int { didSet { save() } }

    // MARK: - Learning progress

    private(set) var totalStars: Int { didSet { save() } }
    private(set) var masteredPhonemes: Set<String> { didSet { save() } }
    private(set) var builtWords: Set<String> { didSet { save() } }

    private let defaults = UserDefaults.standard

    init() {
        // Property observers do not fire during init, so this does not re-save.
        childName = defaults.string(forKey: Keys.name) ?? ""
        calmMode = defaults.bool(forKey: Keys.calm)
        setSize = (defaults.object(forKey: Keys.setSize) as? Int) ?? Curriculum.defaultSetSize
        totalStars = defaults.integer(forKey: Keys.stars)
        masteredPhonemes = Set(defaults.stringArray(forKey: Keys.phonemes) ?? [])
        builtWords = Set(defaults.stringArray(forKey: Keys.words) ?? [])
    }

    // MARK: - Sticker rewards

    /// How many stickers have been unlocked so far.
    var unlockedStickerCount: Int {
        min(totalStars / Self.starsPerSticker, Curriculum.stickers.count)
    }

    /// Whether there are still stickers left to earn.
    var hasMoreStickers: Bool {
        unlockedStickerCount < Curriculum.stickers.count
    }

    /// Progress (0...starsPerSticker) toward the next sticker.
    var starsTowardNextSticker: Int {
        guard hasMoreStickers else { return Self.starsPerSticker }
        return totalStars % Self.starsPerSticker
    }

    // MARK: - Mutations

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
        defaults.set(calmMode, forKey: Keys.calm)
        defaults.set(setSize, forKey: Keys.setSize)
        defaults.set(totalStars, forKey: Keys.stars)
        defaults.set(Array(masteredPhonemes), forKey: Keys.phonemes)
        defaults.set(Array(builtWords), forKey: Keys.words)
    }

    private enum Keys {
        static let name = "childName"
        static let calm = "calmMode"
        static let setSize = "setSize"
        static let stars = "totalStars"
        static let phonemes = "masteredPhonemes"
        static let words = "builtWords"
    }
}
