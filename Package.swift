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
            type: .dynamic,
            targets: ["SwiftSFML"]
        ),
    ],
    targets: [
        .executableTarget(
            name: "TestApp",
            dependencies: ["SwiftSFML"],
            swiftSettings: [
                .interoperabilityMode(.Cxx),
            ]
        ),
        .target(
            name: "SwiftSFML",
            dependencies: ["CxxSFML", "CxxImGui"],
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
            ],
            linkerSettings: [
                .unsafeFlags(["-L", "/opt/homebrew/lib"], .when(platforms: [.macOS])),
            ]
        ),
        .target(
            name: "CxxImGui",
            publicHeadersPath: ".",
            cxxSettings: [
                .unsafeFlags(["-I", "/opt/homebrew/include"], .when(platforms: [.macOS])),
            ],
            linkerSettings: [
                .linkedFramework("OpenGL", .when(platforms: [.macOS]))
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
