//
//  Package.swift
//  MovieFlixApp
//
//  Created by vivally iosdev on 1/13/25.
//  Copyright © 2025 Apple. All rights reserved.
//

// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "MovieFlixApp",
    platforms: [
        .iOS(.v13) // Minimum deployment target
    ],
    products: [
        .library(
            name: "MovieFlixApp",
            targets: ["MovieFlixApp"]
        ),
    ],
    dependencies: [
        // Add dependencies here. Example:
        .package(url: "https://github.com/Alamofire/Alamofire.git", from: "5.6.0"),
    ],
    targets: [
        .target(
            name: "MovieFlixApp",
            dependencies: ["Alamofire"]),
        .testTarget(
            name: "MovieFlixAppTests",
            dependencies: ["MovieFlixApp"]),
    ]
)

