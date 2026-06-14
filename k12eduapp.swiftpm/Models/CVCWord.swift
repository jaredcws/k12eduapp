import Foundation

/// A simple consonant-vowel-consonant word used for blending practice
/// (e.g. "cat", "dog"). Every letter maps to exactly one sound, so the word
/// can be sounded out one letter at a time.
struct CVCWord: Identifiable, Hashable {
    var id: String { text }
    let text: String
    let emoji: String

    /// The individual sound keys, in order — e.g. "cat" -> ["c", "a", "t"].
    var phonemeIDs: [String] { text.map { String($0) } }
}
