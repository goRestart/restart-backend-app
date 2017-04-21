import PackageDescription

let beta = Version(2,0,0, prereleaseIdentifiers: ["beta"])

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

    	// Storage
        Target(name: "Storage", dependencies: ["Shared", "Domain"]),
        
    	// Core
        Target(name: "Shared")
    ],
    dependencies: [
        .Package(url: "https://github.com/vapor/vapor.git", beta),
        .Package(url: "https://github.com/vapor/redis-provider.git", beta),
        .Package(url: "https://github.com/vapor/fluent-provider.git", Version(1, 0, 0, prereleaseIdentifiers: ["beta"])),
        .Package(url: "https://github.com/vapor/mysql-provider.git", beta),
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
