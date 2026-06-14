import SwiftUI

/// A short, joyful overlay shown when the child gets something right.
/// Frequent, low-effort wins keep a distractible learner engaged.
///
/// In `calm` mode the celebration is gentler: no screen dimming and no
/// spinning/scaling, for children who are sensitive to flashy motion.
struct CelebrationView: View {
    let message: String
    var calm: Bool = false
    @State private var animate = false

    var body: some View {
        ZStack {
            if !calm {
                Color.black.opacity(0.25).ignoresSafeArea()
            }
            VStack(spacing: 20) {
                Text("⭐️")
                    .font(.system(size: calm ? 90 : 120))
                    .scaleEffect(animate ? 1 : (calm ? 0.9 : 0.2))
                    .rotationEffect(.degrees(animate || calm ? 0 : -40))
                Text(message)
                    .font(Theme.display(calm ? 34 : 40))
                    .foregroundStyle(Theme.ink)
                    .multilineTextAlignment(.center)
            }
            .padding(calm ? 36 : 48)
            .background(
                RoundedRectangle(cornerRadius: 36, style: .continuous)
                    .fill(.white)
                    .shadow(radius: calm ? 8 : 20)
            )
        }
        .onAppear {
            if calm {
                animate = true
            } else {
                withAnimation(.spring(duration: 0.5, bounce: 0.5)) { animate = true }
            }
        }
    }
}
