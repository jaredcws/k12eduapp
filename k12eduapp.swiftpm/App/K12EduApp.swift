import SwiftUI

/// Entry point for the app.
///
/// A single shared `ProgressStore` is created here and injected into the
/// environment so every screen can read the child's name, stars, and what
/// they've already learned.
@main
struct K12EduApp: App {
    @State private var progress = ProgressStore()

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(progress)
        }
    }
}
