// swift-tools-version: 5.9

// This is a Swift Playgrounds *App* package. Open the enclosing
// `k12eduapp.swiftpm` folder in Swift Playgrounds on iPad (or Mac) to build
// and run it directly on the device — no Xcode required.

import PackageDescription
import AppleProductTypes

let package = Package(
    name: "k12eduapp",
    platforms: [
        .iOS("17.0")
    ],
    products: [
        .iOSApplication(
            name: "k12eduapp",
            targets: ["AppModule"],
            bundleIdentifier: "com.k12eduapp.reading",
            teamIdentifier: "",
            displayVersion: "1.0",
            bundleVersion: "1",
            accentColor: .presetColor(.blue),
            supportedDeviceFamilies: [
                .pad,
                .phone
            ],
            supportedInterfaceOrientations: [
                .portrait,
                .landscapeRight,
                .landscapeLeft,
                .portraitUpsideDown(.when(deviceFamilies: [.pad]))
            ]
        )
    ],
    targets: [
        .executableTarget(
            name: "AppModule",
            path: "."
        )
    ]
)
