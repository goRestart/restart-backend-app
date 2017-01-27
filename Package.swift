import PackageDescription

let package = Package(
    name: "restart-backend-app",
    targets: [
    	Target(name: "App", dependencies: ["Restart"])
    ],
    dependencies: [
        .Package(url: "https://github.com/vapor/vapor.git", majorVersion: 1, minor: 3)
    ],
    exclude: [
        "Config",
        "Database",
        "Localization",
        "Public",
        "Resources",
    ]
)