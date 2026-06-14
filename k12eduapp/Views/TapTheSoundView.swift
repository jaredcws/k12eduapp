import SwiftUI

/// Activity 2 — Tap the Sound.
/// The app plays a sound; the child taps the matching letter from a small set
/// of choices. Wrong taps are gentle: the tile softly highlights, then the
/// round resets so they can try again — never a hard "fail".
struct TapTheSoundView: View {
    @Environment(ProgressStore.self) private var progress

    @State private var target: Phoneme?
    @State private var options: [Phoneme] = []
    @State private var selectedID: String?
    @State private var showStar = false

    private var pool: [Phoneme] {
        Curriculum.phonemes.filter { Curriculum.starterSoundGameIDs.contains($0.id) }
    }

    var body: some View {
        ZStack {
            Theme.background.ignoresSafeArea()
            VStack(spacing: 36) {
                Spacer()
                playButton
                Text("Which letter makes that sound?")
                    .font(Theme.rounded(22, weight: .medium))
                    .foregroundStyle(Theme.ink.opacity(0.7))
                    .multilineTextAlignment(.center)
                choices
                Spacer()
            }
            .padding(28)
            .frame(maxWidth: 760)
            .frame(maxWidth: .infinity)

            if showStar {
                CelebrationView(message: "You got it!").transition(.opacity)
            }
        }
        .navigationTitle("Tap the Sound")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(perform: newRound)
    }

    private var playButton: some View {
        Button {
            if let target {
                SpeechService.shared.playPhoneme(target)
                Haptics.soft()
            }
        } label: {
            VStack(spacing: 12) {
                Image(systemName: "speaker.wave.3.fill").font(.system(size: 60))
                Text("Play the sound").font(Theme.rounded(22))
            }
            .foregroundStyle(.white)
            .frame(width: 240, height: 200)
            .background(
                RoundedRectangle(cornerRadius: 32, style: .continuous)
                    .fill(Theme.primary)
                    .shadow(radius: 10)
            )
        }
        .buttonStyle(.plain)
    }

    private var choices: some View {
        HStack(spacing: 20) {
            ForEach(Array(options.enumerated()), id: \.element.id) { pair in
                LetterTile(letter: pair.element.lowercase,
                           color: Theme.color(for: pair.offset),
                           state: tileState(for: pair.element),
                           fontSize: 70) {
                    choose(pair.element)
                }
            }
        }
    }

    private func tileState(for option: Phoneme) -> LetterTile.TileState {
        guard let selectedID else { return .neutral }
        if option.id == target?.id { return .correct }
        if option.id == selectedID { return .wrong }
        return .neutral
    }

    private func choose(_ option: Phoneme) {
        guard selectedID == nil else { return }   // ignore taps until the round resets
        SpeechService.shared.playPhoneme(option)

        if option.id == target?.id {
            selectedID = option.id
            progress.markPhonemeMastered(option.id)
            Haptics.success()
            withAnimation { showStar = true }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                withAnimation { showStar = false }
                newRound()
            }
        } else {
            selectedID = option.id
            Haptics.tap()
            // Gentle retry: clear the wrong highlight shortly and let them try again.
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
                withAnimation { selectedID = nil }
            }
        }
    }

    private func newRound() {
        selectedID = nil
        let choices = Array(pool.shuffled().prefix(3))
        options = choices.shuffled()
        target = choices.randomElement()
        if let target {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                SpeechService.shared.playPhoneme(target)
            }
        }
    }
}

#Preview {
    NavigationStack { TapTheSoundView() }
        .environment(ProgressStore())
}
