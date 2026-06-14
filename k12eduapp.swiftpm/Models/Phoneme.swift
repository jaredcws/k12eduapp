import Foundation

/// A single letter and the sound it makes.
///
/// In synthetic phonics we teach the *sound* (e.g. "sss") rather than the
/// letter *name* ("ess"), then blend those sounds into words.
struct Phoneme: Identifiable, Hashable {
    /// Lowercase letter key, e.g. "s". Also used to find recorded audio files.
    let id: String
    /// The letter as displayed, e.g. "s".
    let letter: String
    /// A familiar word that starts with this sound, e.g. "sun".
    let exampleWord: String
    /// A picture for the example word.
    let emoji: String
    /// A spelling that nudges the text-to-speech voice toward the pure sound.
    /// Only used as a fallback when no recorded clip is bundled.
    let respelling: String

    var uppercase: String { letter.uppercased() }
    var lowercase: String { letter.lowercased() }
}
