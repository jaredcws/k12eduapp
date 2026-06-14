import SwiftUI

/// A simple parent-facing screen to set the child's name and see progress.
struct SettingsView: View {
    @Environment(ProgressStore.self) private var progress
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        @Bindable var progress = progress
        NavigationStack {
            Form {
                Section("Who's learning?") {
                    TextField("Child's name", text: $progress.childName)
                        .font(Theme.rounded(20, weight: .medium))
                }
                Section("Progress") {
                    LabeledContent("Stars earned", value: "\(progress.totalStars)")
                    LabeledContent("Sounds learned", value: "\(progress.masteredPhonemes.count)")
                    LabeledContent("Words built", value: "\(progress.builtWords.count)")
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") { dismiss() }
                }
            }
        }
    }
}

#Preview {
    SettingsView()
        .environment(ProgressStore())
}
