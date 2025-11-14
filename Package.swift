// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "SwiftSFML",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .library(
            name: "SwiftSFML",
            targets: ["SwiftSFML"]
        ),
    ],
    targets: [
        .target(
            name: "SwiftSFML",
            dependencies: ["CxxSFML"],
            swiftSettings: [
                .unsafeFlags(["-I", "/opt/homebrew/include"], .when(platforms: [.macOS])),
                .interoperabilityMode(.Cxx),
            ]
        ),
        .target(
            name: "CxxSFML",
            publicHeadersPath: ".",
            cxxSettings: [
                .unsafeFlags(["-I", "/opt/homebrew/include"], .when(platforms: [.macOS])),
            ]
        ),
        .testTarget(
            name: "SwiftSFMLTests",
            dependencies: ["SwiftSFML"]
        ),
    ],
    swiftLanguageModes: [.v6],
    cxxLanguageStandard: .cxx20,
)
