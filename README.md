# k12eduapp

A native **SwiftUI iPad app** to help kids learn outside of school. The first
module teaches early **reading** using synthetic phonics, designed from the
ground up for a young learner who finds it hard to stay focused.

> Status: MVP — three working activities, ADHD-friendly lesson structure.
> Packaged as a **Swift Playgrounds App** so it runs on iPad with no Mac.

---

## How to run it on the iPad (no Mac needed)

This project is a **Swift Playgrounds App package** (`k12eduapp.swiftpm`).

1. Install **Swift Playgrounds** from the App Store (free) on the iPad.
2. Get `k12eduapp.swiftpm` onto the iPad — unzip the provided
   `k12eduapp.zip` (Files app → tap the zip to extract), or AirDrop / iCloud
   Drive the `.swiftpm` folder over.
3. Tap `k12eduapp.swiftpm` — it opens in **Swift Playgrounds**.
4. Press the **▶︎ Run** button (top-right). It builds and runs on the iPad.

To keep it on the home screen like a normal app, use Swift Playgrounds'
**"Build to device"** / app submission flow with your Apple Developer account.

> Requires a fairly recent iPadOS (the app targets iOS/iPadOS 17+).

## What it teaches

Synthetic phonics — the most evidence-backed method: teach each letter's
*sound* first, then blend those sounds into words.

| Activity | What the child does |
|---|---|
| 🔤 **Letter Sounds** | Sees one letter, taps to hear its sound and an example word + picture. |
| 👂 **Tap the Sound** | Hears a sound, taps the matching letter from 2–3 choices. |
| 🧩 **Build a Word** | Taps each letter of a CVC word (`c-a-t`), then "Blend it!" sounds it out and reveals the picture. |

Sounds are introduced in `s, a, t, p, i, n …` order because those few letters
alone build dozens of real words — quick early wins.

## Built for attention challenges

Strategies that help kids with attention difficulties are baked into the core
mechanics, not bolted on:

- **Very short sets with a visible finish line** — each activity works in sets
  of 5, shown as a row of dots ("only two more"). A finite, visible goal is one
  of the strongest supports for sustaining attention.
- **Movement "brain breaks"** — after every set the app celebrates, suggests a
  quick physical reset ("Jump up 3 times!"), and offers a pressure-free choice
  to keep going or stop.
- **One task per screen** — never a wall of choices; only three activities on
  the home screen.
- **Instant multi-sensory feedback** — sound + haptic buzz + animation on every
  tap engages multiple senses at once.
- **Frequent, varied rewards** — stars are constant and easy; praise phrases
  rotate so they don't go stale.
- **No-fail / errorless learning** — wrong answers never punish; the round just
  gently resets to try again.
- **Short spoken instructions** — the app talks, since the child can't read yet.
- **Calm, low-distraction visuals** — soft background, small consistent palette.
- **Predictable routine** — every activity follows the same layout and rhythm.

See [Roadmap](#roadmap) for further ADHD supports planned (calm mode, token
rewards, adjustable session length, etc.).

## Adding real recorded audio (recommended next step)

Sounds currently use the built-in iOS speech voice. That's good for whole
words, but isolated letter *sounds* are only approximate with text-to-speech.

The app automatically prefers **bundled recordings** if present — just add
audio files to the package named by convention, no code changes:

- Letter sounds: `phoneme_s.m4a`, `phoneme_a.m4a`, …
- Whole words:  `word_cat.m4a`, `word_dog.m4a`, …

Supported formats: `.m4a`, `.mp3`, `.caf`, `.wav`. See
`Services/SpeechService.swift`.

## Project structure

```
k12eduapp.swiftpm/
  Package.swift                – Swift Playgrounds app manifest
  App/         K12EduApp.swift  – app entry point
  Models/      Phoneme, CVCWord, Curriculum, Praise – content & data
  Services/    SpeechService    – audio (recorded clip → speech fallback)
               ProgressStore    – stars & progress, saved to UserDefaults
               Haptics          – tactile feedback
  Theme/       Theme.swift      – colors & fonts
  Components/  LetterTile, ActivityCard, CelebrationView,
               ProgressDots, BrainBreakView
  Views/       HomeView, SettingsView,
               LetterSoundsView, TapTheSoundView, BlendingView
```

Content is **data-driven**: edit `Models/Curriculum.swift` to add letters,
words, or change the set size — every activity picks up the changes.

## Roadmap

- 🎙️ Record/import real phoneme & word audio (biggest quality win).
- 🧘 **Calm mode** toggle (reduced motion/sound) for overstimulated days.
- 🏆 Token/sticker rewards toward a bigger goal for longer-term motivation.
- ⏱️ Parent-adjustable set length and session limits.
- 🧒 Multiple kid profiles.
- 🗺️ A lesson path that unlocks sounds gradually instead of showing all at once.
- ✍️ Letter tracing/writing practice.
- 📊 A parent dashboard of what's been learned.
