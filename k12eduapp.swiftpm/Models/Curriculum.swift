import Foundation

/// The reading content for the app.
///
/// Sounds are introduced in a synthetic-phonics order: the first six
/// (s, a, t, p, i, n) are chosen because they alone can build dozens of real
/// words, giving an early sense of success.
enum Curriculum {

    /// Default items per short "set" before a brain break. Deliberately small
    /// so a distractible learner always has a finish line in sight. The parent
    /// can adjust this between `minSetSize` and `maxSetSize` in Settings.
    static let defaultSetSize = 5
    static let minSetSize = 3
    static let maxSetSize = 8

    /// Collectible sticker rewards, unlocked one at a time as stars add up.
    /// A longer-term goal beyond the per-tap stars helps sustain motivation.
    static let stickers = [
        "🦖", "🚀", "🦄", "🐙", "🌈", "🦊",
        "🐢", "🦋", "🍩", "⚽️", "🎸", "🐳"
    ]

    /// Letter sounds in teaching order.
    static let phonemes: [Phoneme] = [
        Phoneme(id: "s", letter: "s", exampleWord: "sun",      emoji: "☀️", respelling: "sss"),
        Phoneme(id: "a", letter: "a", exampleWord: "apple",    emoji: "🍎", respelling: "aah"),
        Phoneme(id: "t", letter: "t", exampleWord: "top",      emoji: "🎩", respelling: "tuh"),
        Phoneme(id: "p", letter: "p", exampleWord: "pig",      emoji: "🐷", respelling: "puh"),
        Phoneme(id: "i", letter: "i", exampleWord: "igloo",    emoji: "🧊", respelling: "ih"),
        Phoneme(id: "n", letter: "n", exampleWord: "net",      emoji: "🥅", respelling: "nnn"),
        Phoneme(id: "m", letter: "m", exampleWord: "moon",     emoji: "🌙", respelling: "mmm"),
        Phoneme(id: "d", letter: "d", exampleWord: "dog",      emoji: "🐶", respelling: "duh"),
        Phoneme(id: "g", letter: "g", exampleWord: "goat",     emoji: "🐐", respelling: "guh"),
        Phoneme(id: "o", letter: "o", exampleWord: "octopus",  emoji: "🐙", respelling: "oh"),
        Phoneme(id: "c", letter: "c", exampleWord: "cat",      emoji: "🐱", respelling: "kuh"),
        Phoneme(id: "k", letter: "k", exampleWord: "key",      emoji: "🔑", respelling: "kuh"),
        Phoneme(id: "e", letter: "e", exampleWord: "egg",      emoji: "🥚", respelling: "eh"),
        Phoneme(id: "h", letter: "h", exampleWord: "hat",      emoji: "🎩", respelling: "huh"),
        Phoneme(id: "r", letter: "r", exampleWord: "rabbit",   emoji: "🐰", respelling: "rrr"),
        Phoneme(id: "b", letter: "b", exampleWord: "ball",     emoji: "⚽️", respelling: "buh"),
        Phoneme(id: "f", letter: "f", exampleWord: "fish",     emoji: "🐟", respelling: "fff"),
        Phoneme(id: "u", letter: "u", exampleWord: "umbrella", emoji: "☂️", respelling: "uh"),
        Phoneme(id: "l", letter: "l", exampleWord: "leaf",     emoji: "🍃", respelling: "lll"),
        Phoneme(id: "j", letter: "j", exampleWord: "jam",      emoji: "🍓", respelling: "juh")
    ]

    /// CVC words for blending. Every letter here has been introduced above and
    /// maps to a single sound (no digraphs like "sh" or "ch").
    static let words: [CVCWord] = [
        CVCWord(text: "cat", emoji: "🐱"),
        CVCWord(text: "dog", emoji: "🐶"),
        CVCWord(text: "pig", emoji: "🐷"),
        CVCWord(text: "sun", emoji: "☀️"),
        CVCWord(text: "hat", emoji: "🎩"),
        CVCWord(text: "bed", emoji: "🛏️"),
        CVCWord(text: "cup", emoji: "🥤"),
        CVCWord(text: "pan", emoji: "🍳"),
        CVCWord(text: "net", emoji: "🥅"),
        CVCWord(text: "map", emoji: "🗺️"),
        CVCWord(text: "log", emoji: "🪵"),
        CVCWord(text: "bus", emoji: "🚌"),
        CVCWord(text: "pen", emoji: "🖊️"),
        CVCWord(text: "jam", emoji: "🍓")
    ]

    /// Look up a sound by its letter key.
    static func phoneme(for id: String) -> Phoneme? {
        phonemes.first { $0.id == id.lowercased() }
    }

    /// A small, well-known starter set used for the "Tap the Sound" game so
    /// early rounds stay easy.
    static let starterSoundGameIDs = ["s", "a", "t", "p", "i", "n", "m", "d"]
}
