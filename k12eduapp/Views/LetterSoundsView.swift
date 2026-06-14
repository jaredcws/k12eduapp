import SwiftUI

/// Activity 1 — Letter Sounds.
/// One letter at a time. Tap the letter to hear its sound; tap the picture to
/// hear an example word. "I got it!" awards a star and moves on.
struct LetterSoundsView: View {
    @Environment(ProgressStore.self) private var progress
    @State private var index = 0
    @State private var showStar = false

    private let phonemes = Curriculum.phonemes
    private var current: Phoneme { phonemes[index] }

    var body: some View {
        ZStack {
            Theme.background.ignoresSafeArea()
            VStack(spacing: 28) {
                ProgressView(value: Double(index + 1), total: Double(phonemes.count))
                    .tint(Theme.primary)

                Spacer()
                letterCard
                Text("Tap a letter to hear its sound")
                    .font(Theme.rounded(20, weight: .medium))
                    .foregroundStyle(Theme.ink.opacity(0.6))
                Spacer()
                controls
            }
            .padding(28)
            .frame(maxWidth: 760)
            .frame(maxWidth: .infinity)

            if showStar {
                CelebrationView(message: "Nice!").transition(.opacity)
            }
        }
        .navigationTitle("Letter Sounds")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear { speakCurrent() }
    }

    private var letterCard: some View {
        VStack(spacing: 24) {
            HStack(spacing: 28) {
                LetterTile(letter: current.lowercase,
                           color: Theme.color(for: index),
                           fontSize: 90) { speakCurrent() }
                LetterTile(letter: current.uppercase,
                           color: Theme.color(for: index + 1),
                           fontSize: 90) { speakCurrent() }
            }

            Button {
                SpeechService.shared.playWord(current.exampleWord)
                Haptics.soft()
            } label: {
                HStack(spacing: 12) {
                    Text(current.emoji).font(.system(size: 44))
                    Text(current.exampleWord)
                        .font(Theme.rounded(30))
                        .foregroundStyle(Theme.ink)
                }
                .padding(.horizontal, 28)
                .padding(.vertical, 16)
                .background(Capsule().fill(.white).shadow(radius: 6))
            }
            .buttonStyle(.plain)
        }
    }

    private var controls: some View {
        HStack(spacing: 16) {
            navButton(system: "arrow.left", disabled: index == 0) {
                guard index > 0 else { return }
                index -= 1
                speakCurrent()
            }

            Button {
                progress.markPhonemeMastered(current.id)
                Haptics.success()
                withAnimation { showStar = true }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                    withAnimation { showStar = false }
                    advance()
                }
            } label: {
                Text("I got it! ⭐️")
                    .font(Theme.rounded(24))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    .background(Capsule().fill(Theme.correct))
            }
            .buttonStyle(.plain)

            navButton(system: "arrow.right", disabled: index == phonemes.count - 1) {
                advance()
            }
        }
    }

    private func navButton(system: String, disabled: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Image(systemName: system)
                .font(.title)
                .foregroundStyle(.white)
                .frame(width: 64, height: 64)
                .background(Circle().fill(disabled ? Color.gray.opacity(0.4) : Theme.primary))
        }
        .buttonStyle(.plain)
        .disabled(disabled)
    }

    private func advance() {
        guard index < phonemes.count - 1 else { return }
        index += 1
        speakCurrent()
    }

    private func speakCurrent() {
        SpeechService.shared.playPhoneme(current)
        Haptics.soft()
    }
}

#Preview {
    NavigationStack { LetterSoundsView() }
        .environment(ProgressStore())
}
