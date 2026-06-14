import SwiftUI

/// A big, tappable letter. Used across every activity.
/// Large touch targets and a clear pressed/correct/wrong state keep it easy
/// for little fingers and give instant visual feedback.
struct LetterTile: View {
    enum TileState { case neutral, correct, wrong }

    let letter: String
    let color: Color
    var state: TileState = .neutral
    var fontSize: CGFloat = 80
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(letter)
                .font(Theme.display(fontSize))
                .foregroundStyle(.white)
                .frame(width: fontSize * 1.6, height: fontSize * 1.6)
                .background(
                    RoundedRectangle(cornerRadius: 24, style: .continuous)
                        .fill(fillColor)
                        .shadow(color: .black.opacity(0.15), radius: 8, y: 4)
                )
                .overlay(alignment: .topTrailing) {
                    if state == .correct {
                        Image(systemName: "star.fill")
                            .foregroundStyle(.white)
                            .padding(10)
                    }
                }
        }
        .buttonStyle(.plain)
        .scaleEffect(state == .correct ? 1.08 : 1)
        .animation(.spring(duration: 0.3), value: state)
    }

    private var fillColor: Color {
        switch state {
        case .neutral: color
        case .correct: Theme.correct
        case .wrong:   Theme.gentle
        }
    }
}
