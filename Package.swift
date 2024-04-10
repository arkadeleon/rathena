// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swift-rathena",
    platforms: [
        .iOS(.v13),
    ],
    products: [
        .library(
            name: "rAthenaCommon",
            targets: ["rAthenaCommon"]
        ),
        .library(
            name: "rAthenaLogin",
            type: .dynamic,
            targets: ["rAthenaLogin"]
        ),
        .library(
            name: "rAthenaChar",
            type: .dynamic,
            targets: ["rAthenaChar"]
        ),
        .library(
            name: "rAthenaMap",
            type: .dynamic,
            targets: ["rAthenaMap"]
        ),
        .library(
            name: "rAthenaWeb",
            type: .dynamic,
            targets: ["rAthenaWeb"]
        ),
        .library(
            name: "rAthenaResource",
            targets: ["rAthenaResource"]
        ),
        .library(
            name: "rAthenaRyml",
            targets: ["rAthenaRyml"]
        ),
    ],
    targets: [
        .target(
            name: "rAthenaCommon",
            dependencies: [
                "libconfig",
                "ryml",
            ],
            exclude: [
                "common",
                "config",
                "custom",
                "map",
            ],
            cxxSettings: [
                .headerSearchPath(""),
            ]
        ),
        .target(
            name: "rAthenaLogin",
            dependencies: [
                "libconfig",
                "ryml",
                "rAthenaCommon",
            ],
            exclude: [
                "common/winapi.hpp",
                "common/winapi.cpp",
            ],
            cxxSettings: [
                .headerSearchPath(""),
            ],
            linkerSettings: [
                .linkedFramework("CoreFoundation"),
                .linkedFramework("Foundation"),
                .linkedLibrary("sqlite3"),
                .linkedLibrary("z"),
            ]
        ),
        .target(
            name: "rAthenaChar",
            dependencies: [
                "libconfig",
                "ryml",
                "rAthenaCommon",
            ],
            exclude: [
                "common/winapi.hpp",
                "common/winapi.cpp",
            ],
            cxxSettings: [
                .headerSearchPath(""),
            ],
            linkerSettings: [
                .linkedFramework("CoreFoundation"),
                .linkedFramework("Foundation"),
                .linkedLibrary("sqlite3"),
                .linkedLibrary("z"),
            ]
        ),
        .target(
            name: "rAthenaMap",
            dependencies: [
                "libconfig",
                "ryml",
                "rAthenaCommon",
            ],
            exclude: [
                "common/winapi.hpp",
                "common/winapi.cpp",
            ],
            cxxSettings: [
                .headerSearchPath(""),
            ],
            linkerSettings: [
                .linkedFramework("CoreFoundation"),
                .linkedFramework("Foundation"),
                .linkedLibrary("sqlite3"),
                .linkedLibrary("z"),
            ]
        ),
        .target(
            name: "rAthenaWeb",
            dependencies: [
                "httplib",
                "json",
                "libconfig",
                "ryml",
                "yaml-cpp",
                "rAthenaCommon",
            ],
            exclude: [
                "common/winapi.hpp",
                "common/winapi.cpp",
            ],
            cxxSettings: [
                .headerSearchPath(""),
            ],
            linkerSettings: [
                .linkedFramework("CoreFoundation"),
                .linkedFramework("Foundation"),
                .linkedLibrary("sqlite3"),
                .linkedLibrary("z"),
            ]
        ),
        .target(
            name: "rAthenaResource",
            path: ".",
            exclude: [
                "3rdparty",
                "doc",
                "src",
                "tools",
            ],
            sources: [
                "Sources/rAthenaResource",
            ],
            resources: [
                .copy("conf"),
                .copy("db"),
                .copy("npc"),
                .copy("ragnarok.sqlite3"),
            ]
        ),
        .target(
            name: "rAthenaRyml",
            dependencies: [
                "ryml",
            ],
            swiftSettings: [
                .interoperabilityMode(.Cxx),
            ]
        ),
        .target(
            name: "httplib",
            path: "3rdparty/httplib",
            publicHeadersPath: ""
        ),
        .target(
            name: "json",
            path: "3rdparty/json"
        ),
        .target(
            name: "libconfig",
            path: "3rdparty/libconfig",
            publicHeadersPath: "",
            cSettings: [
                .define("HAVE_XLOCALE_H"),
            ]
        ),
        .target(
            name: "ryml",
            path: "3rdparty/rapidyaml",
            sources: [
                "ext/c4core/src",
                "src",
            ],
            cxxSettings: [
                .headerSearchPath("ext/c4core/src"),
                .headerSearchPath("src"),
            ]
        ),
        .target(
            name: "yaml-cpp",
            path: "3rdparty/yaml-cpp",
            sources: [
                "src",
            ]
        ),
        .plugin(
            name: "rAthenaExportConstantsPlugin",
            capability: .command(
                intent: .custom(verb: "export-constants", description: ""),
                permissions: [
                    .writeToPackageDirectory(reason: "")
                ]
            )
        ),
        .testTarget(
            name: "rAthenaLoginTests",
            dependencies: [
                "rAthenaLogin",
                "rAthenaResource",
            ]
        ),
        .testTarget(
            name: "rAthenaCharTests",
            dependencies: [
                "rAthenaChar",
                "rAthenaResource",
            ]
        ),
        .testTarget(
            name: "rAthenaMapTests",
            dependencies: [
                "rAthenaMap",
                "rAthenaResource",
            ]
        ),
        .testTarget(
            name: "rAthenaWebTests",
            dependencies: [
                "rAthenaWeb",
                "rAthenaResource",
            ]
        ),
    ],
    cxxLanguageStandard: .cxx17
)
