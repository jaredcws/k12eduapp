import SwiftUI

/// A short row of dots showing how many steps remain in the current set.
///
/// A *visible, finite finish line* is one of the most powerful supports for a
/// child who struggles to sustain attention: "only two more" is far easier to
/// push through than an open-ended task.
struct ProgressDots: View {
    let total: Int
    let completed: Int

    var body: some View {
        HStack(spacing: 12) {
            ForEach(0..<max(total, 0), id: \.self) { index in
                Circle()
                    .fill(index < completed ? Theme.accent : Theme.ink.opacity(0.15))
                    .frame(width: 18, height: 18)
                    .overlay {
                        if index < completed {
                            Image(systemName: "star.fill")
                                .font(.system(size: 11))
                                .foregroundStyle(.white)
                        }
                    }
            }
        }
        .animation(.spring(duration: 0.35), value: completed)
    }
}
