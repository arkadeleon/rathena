// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "rAthenaMap",
    platforms: [
        .iOS(.v13),
    ],
    products: [
        .library(
            name: "rAthenaMap",
            type: .dynamic,
            targets: ["rAthenaMap"]),
    ],
    dependencies: [
        .package(path: "../../3rdparty"),
    ],
    targets: [
        .target(
            name: "rAthenaMap",
            dependencies: [
                .product(name: "libconfig", package: "3rdparty"),
                .product(name: "ryml", package: "3rdparty"),
            ],
            path: ".",
            exclude: [
                "common/winapi.hpp",
                "common/winapi.cpp",
                "rapidyaml",
            ],
            publicHeadersPath: "",
            cxxSettings: [
                .headerSearchPath("rapidyaml/ext/c4core/src"),
                .headerSearchPath("rapidyaml/src"),
            ],
            linkerSettings: [
                .linkedFramework("CoreFoundation"),
                .linkedFramework("Foundation"),
                .linkedLibrary("sqlite3"),
                .linkedLibrary("z"),
            ]),
    ],
    cxxLanguageStandard: .cxx11
)
