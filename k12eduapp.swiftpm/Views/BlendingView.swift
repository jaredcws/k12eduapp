import SwiftUI

/// Activity 3 — Build a Word.
/// The heart of phonics: blending. The child taps each letter to hear its
/// sound, then "Blend it!" sounds the word out letter-by-letter and finally
/// says the whole word while revealing the picture.
///
/// ADHD supports: short sets with a visible finish line, a spoken instruction,
/// and a movement "brain break" after each set.
struct BlendingView: View {
    @Environment(ProgressStore.self) private var progress
    @Environment(\.dismiss) private var dismiss

    @State private var index = 0
    @State private var revealed = false
    @State private var highlightedLetter: Int?
    @State private var completedInSet = 0
    @State private var starsInSet = 0
    @State private var showStar = false
    @State private var showBreak = false

    private let words = Curriculum.words
    private let setSize = Curriculum.setSize
    private var current: CVCWord { words[index] }

    var body: some View {
        ZStack {
            Theme.background.ignoresSafeArea()
            VStack(spacing: 28) {
                ProgressDots(total: setSize, completed: completedInSet)
                    .padding(.top, 8)
                Spacer()

                Text(revealed ? current.emoji : "❓")
                    .font(.system(size: 110))
                    .animation(.spring(duration: 0.4), value: revealed)

                letters
                blendButton

                Spacer()
                controls
            }
            .padding(28)
            .frame(maxWidth: 760)
            .frame(maxWidth: .infinity)

            if showStar {
                CelebrationView(message: "\(current.text.uppercased())!").transition(.opacity)
            }
            if showBreak {
                BrainBreakView(starsThisSet: starsInSet,
                               prompt: Praise.movementBreak(),
                               onKeepGoing: startNextSet,
                               onDone: { dismiss() })
                    .transition(.opacity)
            }
        }
        .navigationTitle("Build a Word")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            SpeechService.shared.say("Tap each letter, then press Blend it.")
        }
    }

    private var letters: some View {
        HStack(spacing: 16) {
            ForEach(Array(current.text.enumerated()), id: \.offset) { pair in
                LetterTile(letter: String(pair.element),
                           color: Theme.color(for: pair.offset),
                           state: highlightedLetter == pair.offset ? .correct : .neutral,
                           fontSize: 70) {
                    highlightedLetter = pair.offset
                    if let phoneme = Curriculum.phoneme(for: String(pair.element)) {
                        SpeechService.shared.playPhoneme(phoneme)
                    }
                    Haptics.soft()
                }
            }
        }
    }

    private var blendButton: some View {
        Button(action: blend) {
            Text("🔊 Blend it!")
                .font(Theme.rounded(26))
                .foregroundStyle(.white)
                .padding(.horizontal, 40)
                .padding(.vertical, 18)
                .background(Capsule().fill(Theme.primary))
        }
        .buttonStyle(.plain)
    }

    private var controls: some View {
        HStack(spacing: 16) {
            Button(action: previous) {
                Image(systemName: "arrow.left")
                    .font(.title)
                    .foregroundStyle(.white)
                    .frame(width: 64, height: 64)
                    .background(Circle().fill(index == 0 ? Color.gray.opacity(0.4) : Theme.primary))
            }
            .buttonStyle(.plain)
            .disabled(index == 0)

            Button(action: next) {
                Text("Next word")
                    .font(Theme.rounded(22))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 18)
                    .background(Capsule().fill(Theme.accent))
            }
            .buttonStyle(.plain)
        }
    }

    /// Sound out each letter in turn, then say the whole word and reveal the picture.
    private func blend() {
        revealed = true
        let ids = current.phonemeIDs
        let step = 0.55

        for (i, id) in ids.enumerated() {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i) * step) {
                highlightedLetter = i
                if let phoneme = Curriculum.phoneme(for: id) {
                    SpeechService.shared.playPhoneme(phoneme)
                }
            }
        }

        let finish = Double(ids.count) * step + 0.4
        DispatchQueue.main.asyncAfter(deadline: .now() + finish) {
            highlightedLetter = nil
            SpeechService.shared.playWord(current.text)
            let isNew = !progress.builtWords.contains(current.text)
            progress.markWordBuilt(current.text)
            if isNew {
                completedInSet += 1
                starsInSet += 1
            }
            Haptics.success()
            withAnimation { showStar = true }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.4) {
                withAnimation { showStar = false }
                if completedInSet >= setSize {
                    withAnimation { showBreak = true }
                }
            }
        }
    }

    private func startNextSet() {
        completedInSet = 0
        starsInSet = 0
        withAnimation { showBreak = false }
        next()
    }

    private func next() {
        revealed = false
        highlightedLetter = nil
        index = (index + 1) % words.count
    }

    private func previous() {
        guard index > 0 else { return }
        revealed = false
        highlightedLetter = nil
        index -= 1
    }
}

#Preview {
    NavigationStack { BlendingView() }
        .environment(ProgressStore())
}
