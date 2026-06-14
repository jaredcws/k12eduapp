import SwiftUI

/// The reward collection. Stickers unlock one at a time as stars add up,
/// giving a longer-term goal beyond the moment-to-moment stars.
struct StickerBookView: View {
    @Environment(ProgressStore.self) private var progress

    private let columns = [GridItem(.adaptive(minimum: 96), spacing: 16)]

    var body: some View {
        ZStack {
            Theme.background.ignoresSafeArea()
            ScrollView {
                VStack(spacing: 24) {
                    Text("You have \(progress.unlockedStickerCount) of \(Curriculum.stickers.count) stickers!")
                        .font(Theme.rounded(24))
                        .foregroundStyle(Theme.ink)
                        .multilineTextAlignment(.center)

                    if progress.hasMoreStickers {
                        Text("\(ProgressStore.starsPerSticker - progress.starsTowardNextSticker) more ⭐️ to unlock the next one")
                            .font(Theme.rounded(18, weight: .medium))
                            .foregroundStyle(Theme.ink.opacity(0.6))
                    } else {
                        Text("Wow — you collected them all! 🎉")
                            .font(Theme.rounded(18, weight: .medium))
                            .foregroundStyle(Theme.correct)
                    }

                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(Array(Curriculum.stickers.enumerated()), id: \.offset) { pair in
                            stickerTile(emoji: pair.element,
                                        unlocked: pair.offset < progress.unlockedStickerCount)
                        }
                    }
                }
                .padding(28)
                .frame(maxWidth: 760)
                .frame(maxWidth: .infinity)
            }
        }
        .navigationTitle("Sticker Book")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func stickerTile(emoji: String, unlocked: Bool) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(unlocked ? Color.white : Color.gray.opacity(0.12))
                .shadow(color: .black.opacity(unlocked ? 0.12 : 0), radius: 6, y: 3)
            if unlocked {
                Text(emoji).font(.system(size: 50))
            } else {
                Image(systemName: "lock.fill")
                    .font(.system(size: 28))
                    .foregroundStyle(Theme.ink.opacity(0.25))
            }
        }
        .frame(width: 96, height: 96)
    }
}

#Preview {
    NavigationStack { StickerBookView() }
        .environment(ProgressStore())
}
