import SwiftUI

/// A short celebration + movement break shown after every small set of items.
///
/// Core ADHD-friendly strategy: work in very short bursts, then deliberately
/// release energy with a quick physical break before deciding whether to keep
/// going. The child is always given a clear, pressure-free choice to continue
/// or stop, which protects motivation.
struct BrainBreakView: View {
    let starsThisSet: Int
    let prompt: String
    let onKeepGoing: () -> Void
    let onDone: () -> Void

    var body: some View {
        ZStack {
            Color.black.opacity(0.35).ignoresSafeArea()
            VStack(spacing: 22) {
                Text("🎉").font(.system(size: 88))
                Text("You earned \(starsThisSet) ⭐️!")
                    .font(Theme.display(34))
                    .foregroundStyle(Theme.ink)
                Text("Brain break")
                    .font(Theme.rounded(20, weight: .heavy))
                    .foregroundStyle(Theme.accent)
                Text(prompt)
                    .font(Theme.rounded(26, weight: .semibold))
                    .foregroundStyle(Theme.primary)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)

                HStack(spacing: 16) {
                    Button(action: onDone) {
                        Text("All done")
                            .font(Theme.rounded(22))
                            .foregroundStyle(Theme.ink)
                            .padding(.horizontal, 28)
                            .padding(.vertical, 16)
                            .background(Capsule().fill(Color.gray.opacity(0.18)))
                    }
                    .buttonStyle(.plain)

                    Button(action: onKeepGoing) {
                        Text("Keep going ▶︎")
                            .font(Theme.rounded(22))
                            .foregroundStyle(.white)
                            .padding(.horizontal, 28)
                            .padding(.vertical, 16)
                            .background(Capsule().fill(Theme.correct))
                    }
                    .buttonStyle(.plain)
                }
                .padding(.top, 8)
            }
            .padding(40)
            .frame(maxWidth: 520)
            .background(
                RoundedRectangle(cornerRadius: 36, style: .continuous)
                    .fill(.white)
                    .shadow(radius: 20)
            )
            .padding(32)
        }
    }
}
