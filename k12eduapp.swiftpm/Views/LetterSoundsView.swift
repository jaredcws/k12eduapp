import SwiftUI

/// Activity 1 — Letter Sounds.
/// One letter at a time. Tap the letter to hear its sound; tap the picture to
/// hear an example word. "I got it!" awards a star and moves on.
///
/// ADHD supports: a short spoken instruction, a visible finish line (dots),
/// work in small sets, and a movement "brain break" after each set.
struct LetterSoundsView: View {
    @Environment(ProgressStore.self) private var progress
    @Environment(\.dismiss) private var dismiss

    @State private var index = 0
    @State private var completedInSet = 0
    @State private var starsInSet = 0
    @State private var showStar = false
    @State private var showBreak = false
    @State private var cheer = ""

    private let phonemes = Curriculum.phonemes
    private var setSize: Int { progress.setSize }
    private var current: Phoneme { phonemes[index] }

    var body: some View {
        ZStack {
            Theme.background.ignoresSafeArea()
            VStack(spacing: 24) {
                ProgressDots(total: setSize, completed: completedInSet)
                    .padding(.top, 8)

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
                CelebrationView(message: cheer, calm: progress.calmMode).transition(.opacity)
            }
            if showBreak {
                BrainBreakView(starsThisSet: starsInSet,
                               prompt: Praise.movementBreak(),
                               onKeepGoing: startNextSet,
                               onDone: { dismiss() })
                    .transition(.opacity)
            }
        }
        .navigationTitle("Letter Sounds")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            SpeechService.shared.say("Tap a letter to hear its sound.")
        }
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

            Button(action: gotIt) {
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

    private func gotIt() {
        progress.markPhonemeMastered(current.id)
        completedInSet += 1
        starsInSet += 1
        cheer = Praise.cheer()
        if !progress.calmMode { SpeechService.shared.say(cheer) }
        Haptics.success()
        withAnimation { showStar = true }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            withAnimation { showStar = false }
            if completedInSet >= setSize {
                withAnimation { showBreak = true }
            } else {
                advance()
            }
        }
    }

    private func startNextSet() {
        completedInSet = 0
        starsInSet = 0
        withAnimation { showBreak = false }
        advance()
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
