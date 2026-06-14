import SwiftUI

/// A large, friendly row on the home screen that opens one activity.
struct ActivityCard: View {
    let title: String
    let subtitle: String
    let emoji: String
    let color: Color

    var body: some View {
        HStack(spacing: 20) {
            Text(emoji)
                .font(.system(size: 56))
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(Theme.rounded(28))
                    .foregroundStyle(.white)
                Text(subtitle)
                    .font(Theme.rounded(18, weight: .medium))
                    .foregroundStyle(.white.opacity(0.9))
            }
            Spacer()
            Image(systemName: "chevron.right")
                .font(.title)
                .foregroundStyle(.white.opacity(0.8))
        }
        .padding(28)
        .background(
            RoundedRectangle(cornerRadius: 28, style: .continuous)
                .fill(color)
                .shadow(color: color.opacity(0.35), radius: 10, y: 6)
        )
    }
}
