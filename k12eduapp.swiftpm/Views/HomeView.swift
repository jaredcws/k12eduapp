import SwiftUI

/// The starting screen: a warm greeting, a star count, and three big activity
/// choices. Kept deliberately short — only three options — so it never
/// overwhelms.
struct HomeView: View {
    @Environment(ProgressStore.self) private var progress
    @State private var showSettings = false

    var body: some View {
        NavigationStack {
            ZStack {
                Theme.background.ignoresSafeArea()
                ScrollView {
                    VStack(spacing: 28) {
                        header
                        rewardBar
                        activities
                    }
                    .padding(28)
                    .frame(maxWidth: 760)
                    .frame(maxWidth: .infinity)
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button { showSettings = true } label: {
                        Image(systemName: "gearshape.fill")
                            .font(.title2)
                            .foregroundStyle(Theme.primary)
                    }
                }
            }
            .sheet(isPresented: $showSettings) {
                SettingsView()
            }
        }
    }

    private var greeting: String {
        let name = progress.childName.trimmingCharacters(in: .whitespaces)
        return name.isEmpty ? "Let's read!" : "Hi \(name)!\nLet's read!"
    }

    private var header: some View {
        VStack(spacing: 10) {
            Text(greeting)
                .font(Theme.display(40))
                .foregroundStyle(Theme.ink)
                .multilineTextAlignment(.center)
            HStack(spacing: 8) {
                Image(systemName: "star.fill").foregroundStyle(Theme.accent)
                Text("\(progress.totalStars) stars")
                    .font(Theme.rounded(24))
                    .foregroundStyle(Theme.ink.opacity(0.7))
            }
        }
        .padding(.top, 12)
    }

    /// Tappable reward bar showing progress toward the next sticker.
    private var rewardBar: some View {
        NavigationLink {
            StickerBookView()
        } label: {
            HStack(spacing: 16) {
                Text("🏅").font(.system(size: 40))
                VStack(alignment: .leading, spacing: 6) {
                    Text("Sticker Book")
                        .font(Theme.rounded(22))
                        .foregroundStyle(Theme.ink)
                    if progress.hasMoreStickers {
                        ProgressView(value: Double(progress.starsTowardNextSticker),
                                     total: Double(ProgressStore.starsPerSticker))
                            .tint(Theme.accent)
                        Text("\(ProgressStore.starsPerSticker - progress.starsTowardNextSticker) ⭐️ to your next sticker")
                            .font(Theme.rounded(14, weight: .medium))
                            .foregroundStyle(Theme.ink.opacity(0.6))
                    } else {
                        Text("All stickers collected! 🎉")
                            .font(Theme.rounded(14, weight: .medium))
                            .foregroundStyle(Theme.correct)
                    }
                }
                Spacer()
                Text("\(progress.unlockedStickerCount)/\(Curriculum.stickers.count)")
                    .font(Theme.rounded(18))
                    .foregroundStyle(Theme.ink.opacity(0.7))
            }
            .padding(20)
            .background(
                RoundedRectangle(cornerRadius: 24, style: .continuous)
                    .fill(.white)
                    .shadow(color: .black.opacity(0.08), radius: 8, y: 4)
            )
        }
        .buttonStyle(.plain)
    }

    private var activities: some View {
        VStack(spacing: 20) {
            NavigationLink {
                LetterSoundsView()
            } label: {
                ActivityCard(title: "Letter Sounds",
                             subtitle: "Learn how letters sound",
                             emoji: "🔤",
                             color: Theme.color(for: 0))
            }
            NavigationLink {
                TapTheSoundView()
            } label: {
                ActivityCard(title: "Tap the Sound",
                             subtitle: "Hear it, then tap it",
                             emoji: "👂",
                             color: Theme.color(for: 1))
            }
            NavigationLink {
                BlendingView()
            } label: {
                ActivityCard(title: "Build a Word",
                             subtitle: "Blend sounds into words",
                             emoji: "🧩",
                             color: Theme.color(for: 2))
            }
        }
    }
}

#Preview {
    HomeView()
        .environment(ProgressStore())
}
