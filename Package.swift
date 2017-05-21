import PackageDescription

let package = Package(
    name: "restart-backend-app",
    targets: [
        
        // Starting point
    	Target(name: "App", dependencies: ["API"]),
    	
    	// Web Api
    	Target(name: "API", dependencies: ["Restart"]),
    	
    	// Domain
    	Target(name: "Restart", dependencies: ["Storage", "Domain"]),
        Target(name: "Domain"), // Pure domain models

        // FluentStorage
        Target(name: "FluentStorage"),

        // Shared
        Target(name: "Shared", dependencies: ["FluentStorage"]),

    	// Storage
        Target(name: "Storage", dependencies: ["Shared", "Domain", "FluentStorage"])
    ],
    dependencies: [
        .Package(url: "https://github.com/vapor/vapor.git", Version(2,0,0)),
        .Package(url: "https://github.com/vapor/redis-provider.git", Version(2,0,0)),
        .Package(url: "https://github.com/vapor/fluent-provider.git", Version(1, 0, 0)),
        .Package(url: "https://github.com/vapor-community/postgresql-provider.git", Version(2,0,0)),
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
