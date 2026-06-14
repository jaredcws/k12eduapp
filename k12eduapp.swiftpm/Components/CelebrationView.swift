import SwiftUI

/// A short, joyful overlay shown when the child gets something right.
/// Frequent, low-effort wins keep a distractible learner engaged.
struct CelebrationView: View {
    let message: String
    @State private var animate = false

    var body: some View {
        ZStack {
            Color.black.opacity(0.25).ignoresSafeArea()
            VStack(spacing: 20) {
                Text("⭐️")
                    .font(.system(size: 120))
                    .scaleEffect(animate ? 1 : 0.2)
                    .rotationEffect(.degrees(animate ? 0 : -40))
                Text(message)
                    .font(Theme.display(40))
                    .foregroundStyle(Theme.ink)
                    .multilineTextAlignment(.center)
            }
            .padding(48)
            .background(
                RoundedRectangle(cornerRadius: 36, style: .continuous)
                    .fill(.white)
                    .shadow(radius: 20)
            )
        }
        .onAppear {
            withAnimation(.spring(duration: 0.5, bounce: 0.5)) { animate = true }
        }
    }
}
