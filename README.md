# k12eduapp

A native **SwiftUI iPad app** to help kids learn outside of school. The first
module teaches early **reading** using synthetic phonics, designed for a young
learner who finds it hard to stay focused.

> Status: MVP scaffold — three working activities, ready to build and run in
> Xcode. See [Roadmap](#roadmap) for what's next.

---

## What it teaches

The app uses **synthetic phonics** (the most evidence-backed approach): teach
each letter's *sound* first, then blend those sounds into words.

Three activities:

| Activity | What the child does |
|---|---|
| 🔤 **Letter Sounds** | Sees one letter, taps to hear its sound and an example word + picture. |
| 👂 **Tap the Sound** | Hears a sound, taps the matching letter from 2–3 choices. |
| 🧩 **Build a Word** | Taps each letter of a CVC word (e.g. `c-a-t`) to hear it, then "Blend it!" sounds the word out and reveals the picture. |

Sounds are introduced in the classic `s, a, t, p, i, n …` order because those
few letters alone build dozens of real words — quick early wins.

## Design for a distractible learner

Every screen is built around a short attention span:

- **One task per screen** — never a wall of choices.
- **Big tap targets** and minimal on-screen text (the child can't read yet — the app talks).
- **Instant multi-sensory feedback** — sound + haptic buzz + animation on every tap.
- **Frequent rewards** — stars are easy and constant; progress is saved.
- **No-fail / gentle retry** — wrong answers never punish; the round simply resets.
- **Calm visuals** — soft background, small consistent color palette.

## Requirements

- **Xcode 16 or later** (the project uses file-system-synchronized groups).
- iOS/iPadOS **17.0+** deployment target.
- An Apple Developer account (you have one) to run on a physical iPad.

## How to build & run

1. Open `k12eduapp.xcodeproj` in Xcode.
2. Select the **k12eduapp** scheme.
3. In **Signing & Capabilities**, set your **Team** (and change the bundle id
   `com.k12eduapp.reading` to something unique if Xcode complains).
4. Choose an **iPad simulator** (or your connected iPad) and press **Run** (⌘R).

> **If the project ever fails to open** (e.g. older Xcode): create a new
> *iOS → App* project named `k12eduapp` (SwiftUI, no tests needed), delete its
> default `ContentView.swift` and `*App.swift`, then drag the `k12eduapp/`
> source folder from this repo into the project navigator
> ("Copy items if needed" + "Create groups"). Everything will compile.

## Adding real recorded audio (recommended next step)

Right now sounds use the built-in iOS speech voice. That's fine for words, but
isolated letter *sounds* (pure phonemes) are only approximate with text-to-speech.

The app automatically prefers **bundled recordings** if they exist — just add
audio files to the app target named by convention, no code changes needed:

- Letter sounds: `phoneme_s.m4a`, `phoneme_a.m4a`, `phoneme_t.m4a`, …
- Whole words:  `word_cat.m4a`, `word_dog.m4a`, …

Supported formats: `.m4a`, `.mp3`, `.caf`, `.wav`. See
`Services/SpeechService.swift`.

## Project structure

```
k12eduapp/
  App/         K12EduApp.swift        – app entry point
  Models/      Phoneme, CVCWord, Curriculum – the reading content & data
  Services/    SpeechService          – audio (recorded clip → speech fallback)
               ProgressStore          – stars & progress, saved to UserDefaults
               Haptics                – tactile feedback
  Theme/       Theme.swift            – colors & fonts
  Components/  LetterTile, ActivityCard, CelebrationView – reusable UI
  Views/       HomeView, SettingsView,
               LetterSoundsView, TapTheSoundView, BlendingView
  Resources/   Assets.xcassets        – accent color, app icon slot
```

The content is **data-driven**: edit `Models/Curriculum.swift` to add letters
or words — every activity picks up the changes automatically.

## Roadmap

Ideas for where to take it next (happy to build any of these):

- 🎙️ Record/import real phoneme & word audio (biggest quality win).
- 🎨 A real app icon and a few illustrations.
- 🗺️ A "lesson path" that unlocks new sounds gradually instead of showing all at once.
- 🧒 Multiple kid profiles (you mentioned more than one child).
- 🏆 Sticker book / reward collection for longer-term motivation.
- 🔊 Optional voice instructions read aloud on each screen.
- ✍️ Letter tracing/writing practice.
- 📊 A parent dashboard with what's been learned.
```
