import AVFoundation

/// Plays letter sounds and whole words.
///
/// Strategy: if a recorded audio clip is bundled in the app we play that
/// (best quality, correct pronunciation). Otherwise we fall back to the
/// built-in speech synthesizer.
///
/// To add real recordings later, drop audio files into the app target and name
/// them by convention — no other code needs to change:
///   - a sound:  `phoneme_s.m4a`, `phoneme_a.m4a`, ...
///   - a word:   `word_cat.m4a`, `word_dog.m4a`, ...
/// Supported extensions: m4a, mp3, caf, wav.
final class SpeechService {
    static let shared = SpeechService()

    private let synthesizer = AVSpeechSynthesizer()
    private var audioPlayer: AVAudioPlayer?

    private init() {
        configureAudioSession()
    }

    private func configureAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Audio session setup failed: \(error)")
        }
    }

    /// Play a single letter sound (phoneme).
    func playPhoneme(_ phoneme: Phoneme) {
        if playBundledClip(named: "phoneme_\(phoneme.id)") { return }
        speak(phoneme.respelling, rate: 0.35, pitch: 1.05)
    }

    /// Play a whole word, e.g. "cat".
    func playWord(_ word: String) {
        if playBundledClip(named: "word_\(word.lowercased())") { return }
        speak(word, rate: 0.40)
    }

    /// Speak a spoken prompt or bit of praise.
    func say(_ text: String, rate: Float = 0.45) {
        speak(text, rate: rate)
    }

    func stop() {
        synthesizer.stopSpeaking(at: .immediate)
        audioPlayer?.stop()
    }

    // MARK: - Private

    @discardableResult
    private func playBundledClip(named name: String) -> Bool {
        let extensions = ["m4a", "mp3", "caf", "wav"]
        for ext in extensions {
            if let url = Bundle.main.url(forResource: name, withExtension: ext) {
                do {
                    let player = try AVAudioPlayer(contentsOf: url)
                    audioPlayer = player
                    player.play()
                    return true
                } catch {
                    print("Could not play \(name).\(ext): \(error)")
                }
            }
        }
        return false
    }

    private func speak(_ text: String, rate: Float, pitch: Float = 1.0) {
        synthesizer.stopSpeaking(at: .immediate)
        let utterance = AVSpeechUtterance(string: text)
        utterance.rate = rate
        utterance.pitchMultiplier = pitch
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        synthesizer.speak(utterance)
    }
}
