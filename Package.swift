import PackageDescription

let package = Package(
    name: "restart-backend-app",
    targets: [
    	Target(name: "App", dependencies: ["Restart"])
    ],
    dependencies: [
        .Package(url: "https://github.com/vapor/vapor.git", Version(1, 5, 7)),
        .Package(url: "https://github.com/vapor/mysql-provider.git", Version(1, 1, 1)),
        .Package(url: "https://github.com/vapor/redis-provider.git", Version(1, 0, 1)),
        .Package(url: "https://github.com/goRestart/restart-service-locator.git", majorVersion: 0)
    ],
    exclude: [
        "Config",
        "Database",
        "Localization",
        "Public",
        "Resources"
    ]
)
